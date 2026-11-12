# L9.6 - Melody Player: Boci, boci, tarka

Play a complete 24-note melody through the onboard **J8 3.5 mm audio output**.
Target: **Nexys4 DDR / Nexys A7-100T**, `xc7a100tcsg324-1`, **Vivado 2022.2**.
This exercise contains **no simulation files or simulation scripts**.

## Controls

- **SW0 = 1:** play the melody repeatedly.
- **SW0 = 0:** stop, mute the amplifier, and return to the first note.
- **BTNC:** reset/restart. While held, the audio is muted; releasing it starts
  from the beginning if SW0 is on.

Connect headphones or an appropriate audio speaker to J8. The board itself
has no built-in loudspeaker. Begin with low external volume.

## Melody and rhythm

The transcription follows [Dalok Online: Boci, boci, tarka](https://dalok.theisz.hu/index.php?id=BociBociTarka&lang=hu&page=song),
including its [machine-readable score](https://dalok.theisz.hu/songs/BociBociTarka/BociBociTarka.ly).
The melody is in **C major, 2/4, quarter note = 100 BPM**. Octave notation
uses middle C = C4. The traditional melody has published variants; this
version uses F4-A4 at the end of phrase 3.

| Phrase | Notes | Durations in quarter-note beats |
| --- | --- | --- |
| 1 | C4 E4 C4 E4 G4 G4 | 0.5, 0.5, 0.5, 0.5, 1, 1 |
| 2 | C4 E4 C4 E4 G4 G4 | 0.5, 0.5, 0.5, 0.5, 1, 1 |
| 3 | C5 B4 A4 G4 F4 A4 | 0.5, 0.5, 0.5, 0.5, 1, 1 |
| 4 | G4 F4 E4 D4 C4 C4 | 0.5, 0.5, 0.5, 0.5, 1, 1 |

An eighth note occupies 300 ms; a quarter note occupies 600 ms. The last
30 ms of each note is silent so that repeated notes are distinguishable.
This articulation gap is included in the note duration, not added to it.
A 600 ms rest follows the 9.6-second melody, giving a **10.2-second loop**.
No lyrics, recorded performances or third-party score files are bundled.

## Architecture

All logic runs on the 100 MHz board clock; no generated clocks or IP cores
are needed:

1. Input synchronizers handle SW0 and reset. Reset asserts asynchronously
   into its synchronizer and releases synchronously. FPGA register initial
   values establish a deterministic startup state.
2. A 100,000-cycle clock enable provides a 1 ms timebase. The note sequencer
   steps through 24 note entries followed by one rest entry.
3. A 24-bit phase accumulator generates the selected pitch. It advances
   once per 256-clock PWM frame, at **390.625 kHz**.
4. The top five phase bits address a 32-sample sine lookup table.
5. An 8-bit PWM counter converts samples to duty cycle. Samples are latched
   only between frames; the PWM comparison is registered.

The sine table is centered on 128 with amplitude 32 (sample range 96..160).
Silence uses the midpoint 128. This is an audio amplitude setting, unrelated
to the RGB LED duty limit in L9.5. The small sine table gives a quantized
sine tone rather than instrument-quality audio; brief clicks at note boundaries
or amplifier enable/disable are possible.

The phase increment is `round(frequency * 2^24 / 390625)`. Equal-tempered
notes use A4 = 440 Hz. Change `note_step` and the duration selection in
`src/melody_player.v` to teach another melody.

## Board pins

| Signal | Pin | I/O standard |
| --- | --- | --- |
| CLK100MHZ | E3 | LVCMOS33 |
| BTNC | N17 | LVCMOS33 |
| SW0 | J15 | LVCMOS33 |
| AUD_PWM | A11 | LVCMOS33 |
| AUD_SD | D12 | LVCMOS33 |

`AUD_PWM` is **open drain: only 0 or high impedance (Z), never driven high**.
The board supplies the analog pull-up and reconstruction filter. `AUD_SD`
is high during playback and low when stopped/reset. This matches the
[Digilent Nexys A7 reference manual, section 15](https://digilent.com/reference/_media/reference/programmable-logic/nexys-a7/nexys-a7_rm.pdf)
and [master XDC](https://github.com/Digilent/digilent-xdc/blob/master/Nexys-A7-100T-Master.xdc).

## Create and build

In the Vivado 2022.2 Tcl Console, close any unrelated project and run:

```tcl
source {C:/Labs/Logic_design_using_HDL/Lab09/L9.6_Melody_Player/create_project.tcl}
```

Adjust the repository path. The project appears at
`build/L9_6_Melody_Player/L9_6_Melody_Player.xpr`. Sources are referenced
in place. Re-running the script opens/reuses the existing project.

Click **Generate Bitstream**, or run:

```tcl
source {C:/Labs/Logic_design_using_HDL/Lab09/L9.6_Melody_Player/build_bitstream.tcl}
```

Alternatively, from this exercise directory:

```text
vivado -mode batch -source build_bitstream.tcl
```

The script checks synthesis, implementation and bitstream completion and
writes timing/utilization/DRC reports in `build/`.
Generated project files, reports and bitstreams are not version-controlled.

## Program and test

1. Connect/power the board with SW0 off.
2. In **Hardware Manager -> Open Target -> Auto Connect**, choose **Program Device**.
3. Select `build/L9_6_Melody_Player/L9_6_Melody_Player.runs/impl_1/melody_player.bit`.
4. Connect the audio output at J8 and turn SW0 on. Listen for the four phrases,
   the short final rest, and automatic repetition.
5. Turn SW0 off: audio stops. Turn it back on: phrase 1 starts again.
6. Hold BTNC during playback: audio stops. Release it: phrase 1 restarts.

No behavioral simulation is provided or run for this exercise. Physical audio
quality and operation must be checked on the board.

## Build validation

Vivado 2022.2 synthesis, implementation and bitstream generation completed
successfully on 2026-11-12. Routed timing at 100 MHz: **WNS +4.402 ns,
WHS +0.092 ns**, with no failing endpoints. DRC reports no errors and one
non-blocking `CFGBVS-1` warning for missing configuration-bank voltage
metadata in the master pin constraints. No severity overrides are used.
External switch/button timing and analog audio outputs do not use synchronous
external input/output delay constraints. No simulation was run.
