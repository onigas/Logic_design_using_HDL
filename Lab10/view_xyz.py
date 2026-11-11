"""Display Nexys4 DDR UART reports. Start with: python view_xyz.py"""
import re
import time
import tkinter as tk
from collections import deque
from pathlib import Path
from tkinter import ttk

import serial
from serial.tools import list_ports
from matplotlib.figure import Figure
from matplotlib.backends.backend_tkagg import FigureCanvasTkAgg

FRAME = re.compile(rb"X=([+-]\d{4}) Y=([+-]\d{4}) Z=([+-]\d{4})")


def decode(line):
    match = FRAME.fullmatch(line.rstrip(b"\r\n"))
    if match:
        return tuple(int(field) / 1000 for field in match.groups())


class Viewer:
    def __init__(self, window):
        self.window = window
        window.title("LDHDL 10 | ADXL362")
        bar = ttk.Frame(window, padding=8)
        bar.pack(fill="x")
        ports = [p.device for p in list_ports.comports()]
        self.port = ttk.Combobox(bar, values=ports, width=10)
        self.port.set("COM8")
        self.port.pack(side="left")
        ttk.Button(bar, text="Connect live", command=self.connect).pack(side="left", padx=6)
        ttk.Button(bar, text="Replay capture", command=self.replay).pack(side="left")
        self.status = tk.StringVar()
        ttk.Label(window, textvariable=self.status, padding=6).pack(anchor="w")
        figure = Figure(figsize=(8, 4.5), tight_layout=True)
        self.axes = figure.add_subplot(111)
        self.axes.set(xlim=(-10, 0), ylim=(-2.1, 2.1), xlabel="Time before latest sample (s)",
                      ylabel="Acceleration (g)")
        self.axes.grid(alpha=0.25)
        self.lines = [self.axes.plot([], [], color=color, label=axis, marker=".", ms=3)[0]
                      for axis, color in zip("XYZ", ("#b74912", "#007575", "#434db4"))]
        self.axes.legend(loc="upper left", ncol=3)
        self.canvas = FigureCanvasTkAgg(figure, master=window)
        self.canvas.get_tk_widget().pack(fill="both", expand=True)
        self.samples = deque(maxlen=256)
        self.buffer = bytearray()
        self.stream = None
        self.recording = deque()
        self.connect()
        window.after(50, self.tick)
        window.protocol("WM_DELETE_WINDOW", self.close)

    def clear(self):
        if self.stream:
            self.stream.close()
            self.stream = None
        self.recording.clear()
        self.samples.clear()
        self.buffer.clear()
        for line in self.lines:
            line.set_data([], [])
        self.canvas.draw_idle()

    def connect(self):
        self.clear()
        name = self.port.get().strip()
        try:
            self.stream = serial.Serial(name, 115200, timeout=0)
            self.status.set(f"Live | {name} | Waiting for XYZ data")
        except serial.SerialException:
            self.status.set(f"Cannot open {name}. Close PuTTY, check the port, then click Connect live.")

    def replay(self):
        self.clear()
        path = Path(__file__).with_name("uart_capture.txt")
        try:
            for row in path.read_bytes().splitlines():
                stamp, line = row.split(None, 1)
                values = decode(line)
                if values is None:
                    raise ValueError("Invalid XYZ record")
                self.recording.append((int(stamp) / 1000, values))
            self.started = time.monotonic()
            self.status.set("Replay | Recorded board capture")
        except (OSError, ValueError) as error:
            self.recording.clear()
            self.status.set(f"Cannot read capture: {error}")

    def tick(self):
        now = time.monotonic()
        changed = False
        if self.stream:
            try:
                self.buffer.extend(self.stream.read(min(self.stream.in_waiting, 8192)))
                while b"\n" in self.buffer:
                    line, _, self.buffer = self.buffer.partition(b"\n")
                    values = decode(line)
                    if values:
                        self.samples.append((now, values))
                        changed = True
                if len(self.buffer) > 1024:
                    self.buffer.clear()
            except (serial.SerialException, OSError):
                self.clear()
                self.status.set("Port disconnected. Reconnect the board and click Connect live.")
        while self.recording and self.recording[0][0] <= now - self.started:
            self.samples.append(self.recording.popleft())
            changed = True
        if changed:
            latest, (x, y, z) = self.samples[-1]
            while self.samples[0][0] < latest - 10:
                self.samples.popleft()
            for i, line in enumerate(self.lines):
                line.set_data([t-latest for t, _ in self.samples], [v[i] for _, v in self.samples])
            mode = f"Live | {self.stream.port}" if self.stream else ("Replay" if self.recording else "Replay complete")
            self.status.set(f"{mode}    X {x:+.3f} g     Y {y:+.3f} g     Z {z:+.3f} g")
            self.canvas.draw_idle()
        self.window.after(50, self.tick)

    def close(self):
        if self.stream:
            self.stream.close()
        self.window.destroy()


if __name__ == "__main__":
    root = tk.Tk()
    Viewer(root)
    root.mainloop()
