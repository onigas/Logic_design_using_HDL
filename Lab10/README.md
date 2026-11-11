# LDHDL Laboratory 10 | Onboard accelerometer to serial terminal

Start with [Laboratory 10 handout (PDF)](Laboratory_10.pdf). Page 12 lists the test environments.

| Activity | Prerequisites | Python |
| --- | --- | --- |
| Simulate the Verilog design | Vivado 2022.2 with XSim and Artix-7 device support. The bench supplies the sensor data. | None |
| Generate a bitstream | Vivado 2022.2 with Artix-7 support | None |
| Program the board | Powered Nexys4 DDR, PROG/UART USB data cable, working JTAG drivers and Vivado Hardware Manager. Generate lab10_top.bit in Vivado as described below. | None |
| Display raw UART text | Programmed board, USB serial driver, assigned serial port and PuTTY or another serial terminal | None |
| Plot XYZ live | Same programmed board, its serial port available exclusively to the viewer | Python with Tk, pySerial and Matplotlib |
| Replay the saved recording | Viewer, desktop display and uart_capture.txt | Same Python environment as the live plot |

## Build and run

1. Open the Lab10 folder in your clone or extracted download. Open a Vivado 2022.2 command prompt there and run `vivado -mode batch -source create_project.tcl`. The default project is `build/lab10.xpr`. To build in a fresh directory, append `-tclargs "path/to/new-directory"`. The project references the extracted source files.
2. Open the project. Select **Run Simulation > Run Behavioral Simulation**. Use **Run All** if necessary. The final console message begins with PASS. The test drives the physical SPI pins of the simulated FPGA and decodes the UART pin at the center of each bit.
3. Select **Generate Bitstream** and allow synthesis and implementation to run. The top is `lab10_top`, part `xc7a100tcsg324-1`. The generated file is `build/lab10.runs/impl_1/lab10_top.bit`.
4. Connect the powered Nexys4 DDR via PROG/UART. In Hardware Manager select **Open Target > Auto Connect**, choose the Artix-7 device and **Program Device** with the bitstream. Programming configures the FPGA until power is removed.
5. Open the USB serial port in a terminal at **115200, 8N1, flow control off**. Streaming starts automatically. CPU RESET restarts sensor initialization. The stream contains three signed fields in raw counts, then CR LF. At the configured range, divide by 1000 for approximate g.

## Source map

| File | Role |
| --- | --- |
| rtl/lab10_top.v | Synchronizes reset, sequences configuration, schedules bursts, captures XYZ. |
| rtl/spi_frame.v | Holds CS low across a 24- or 64-bit mode-0 transaction. |
| rtl/ascii_report.v | Formats labels, signs, four decimal digits, spaces and line endings. |
| rtl/uart_tx.v | Serializes each character into a start bit, eight data bits and a stop bit. |
| sim/tb_lab10.v | Checks command order, frame lengths, cadence and two complete UART lines. |
| constraints/nexys4_ddr.xdc | Maps all seven ports and defines the 100 MHz system clock. |
| create_project.tcl | Creates the synthesis and simulation file sets in Vivado. |

## Timing and design choices

The 100 MHz clock drives every sequential block. SPI changes phase every 50 clocks. One UART bit spans 868 clocks, yielding about 115207 baud. The ADXL362 updates its registers at 100 Hz and the FPGA reads the latest triplet at 10 Hz. A report uses 25 characters (250 serial bits). Acquisition uses timed reads and has no sample queue. When changing parameters, keep the reporting interval longer than a complete report, the SPI burst and the initial measurement settling time of 4/ODR, or separate the settling timer from the report timer.

The simulated sensor supplies two synthetic test vectors. The first exercises -2048, +2047 and zero. The second exercises -1, +1 and -1000. The test checks these through the UART output, including padding and CR LF. Shortened timing parameters keep the simulation fast.

## Primary references

- [ADXL362 data sheet, Rev. G](https://www.analog.com/media/en/technical-documentation/data-sheets/adxl362.pdf), especially Specifications, SPI Communications, Register Map, and Register Descriptions.
- [Digilent Nexys4 DDR Rev. C master XDC](https://github.com/Digilent/digilent-xdc/blob/master/Nexys-4-DDR-Master.xdc), Clock signal, Buttons, Accelerometer and USB-RS232 Interface sections. D4 is the FPGA output driving the bridge receiver.

## Validation record

The reference hardware capture in uart_capture.txt contains 30 real XYZ reports in one orientation, received at 115200 8N1 (COM8 on the test PC). Mean PC arrival interval was 99.7 ms. Column one is elapsed host time in milliseconds. This capture predates the project rename. The separate behavioral test compares two synthetic records byte for byte, including the signed limits and CR/LF.

The renamed lab10_top was rebuilt with Vivado 2022.2. Internal setup/hold slack was +5.040/+0.131 ns. Bitstream DRC reported zero errors and one CFGBVS-1 configuration-bank warning. The FPGA configuration payload of the rebuilt lab10_top.bit is byte-for-byte identical to the configuration used for the recorded hardware run. The renamed tb_lab10 passed the two-record XSim test at 130775 ns.

## Python viewer setup (Windows)

Replay was tested on 64-bit CPython 3.9.2 and in a fresh 64-bit CPython 3.11 environment. Both use pySerial 3.5 and Matplotlib 3.9.0. Tkinter comes with the Tcl/Tk component of the Windows Python installer. A working desktop display is required. The file requirements.txt pins the two direct third-party libraries, and pip installs their dependencies.

For a fresh lab PC, install 64-bit Python 3.11 with Tcl/Tk, pip and the Windows Python launcher. Extract the archive, open a terminal in Lab10 and run:

```powershell
py -3.11 -m venv .venv
.\.venv\Scripts\python.exe -m pip install -r requirements.txt
.\.venv\Scripts\python.exe -m tkinter
```

The last command opens a small Tk test window. Close it, then double-click **Start_XYZ.cmd**. It uses the local .venv if present, otherwise it uses python on PATH. To use an already configured interpreter, run `python -m pip install -r requirements.txt` and `python view_xyz.py` from Lab10.

Choose **Replay capture** to check the plotting installation with the 30 supplied samples. For live operation, close PuTTY, choose the board's port (Device Manager > Ports on Windows), and select **Connect live**. At 115200 baud the display should update about ten times per second. If the board has lost power, program the FPGA again before attempting a live acquisition.
