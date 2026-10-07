# L9.4 - PWM Audio Sine-Wave Generator

This VHDL exercise generates a continuous tone at the board's **3.5 mm mono
audio output (J8)**. `SW[8:0]` controls the tone frequency. No external Pmod
is needed; connect headphones or powered speakers to the audio jack.

## How it works

1. `data/pwm.coe` contains one sine-wave period: **1024 samples of 10 bits**.
2. The `dist_mem_gen_0` Distributed Memory Generator IP implements a
   **1024 x 10 asynchronous ROM**.
3. `PWMAudio.vhd` advances the ROM address once every `SW + 1` clock cycles.
4. `PWMDriver.vhd` turns the ROM sample into a 10-bit PWM duty level, with
   a carrier frequency of `100 MHz / 1024 = 97.65625 kHz`.
5. The board's analog low-pass filter reconstructs the audio signal.

From the original address counter, the nominal sine-wave frequency is:

```text
f_tone = 100000000 / (1024 * (SW + 1)) Hz
```

The PWM driver samples the ROM value once per PWM period. The formula describes
the ROM traversal frequency; very small SW values can produce ultrasonic or
aliased output. Start with `SW=97` for an audible tone of approximately 1 kHz.
Increasing SW lowers the tone frequency; it does not adjust the volume.

| SW value (decimal) | Nominal tone frequency |
| --- | --- |
| 97 | 996.49 Hz |
| 195 | 498.25 Hz |
| 255 | 381.47 Hz |
| 511 | 190.73 Hz |

## Generate and run the project

In the Vivado 2022.2 Tcl Console, run:

```tcl
source {C:/Labs/Logic_design_using_HDL/Lab09/L9.4_PWM_Audio/create_project.tcl}
```

The script creates `build/L9_4_PWM_Audio/L9_4_PWM_Audio.xpr`, adds both VHDL
files and the XDC, and recreates the ROM IP from `data/pwm.coe`. No manual
IP customization or import of the old XCI is required.

Generate a bitstream in the GUI, or run:

```tcl
source {C:/Labs/Logic_design_using_HDL/Lab09/L9.4_PWM_Audio/build_bitstream.tcl}
```

Program the board with `PWMAudio.bit`. Set the nine switches to decimal 97
(`SW6=1`, `SW5=1`, `SW0=1`; the other switches SW0-SW8 are 0), connect the
audio output, and change SW0-SW8 to hear the pitch change. There is no button
reset or volume control in the original design.

## Board connections

| Port | FPGA pin / board function | I/O standard |
| --- | --- | --- |
| `CLK100MHZ` | E3 / 100 MHz clock | LVCMOS33 |
| `SW[7:0]` | Eight lower board switches | LVCMOS33 |
| `SW[8]` | T8 / switch 8 | LVCMOS18 |
| `AUD_PWM` | A11 / audio-filter input | LVCMOS33 |
| `AUD_SD` | D12 / audio enable | LVCMOS33 |

The original open-drain audio behavior is retained: `AUD_PWM` drives `0` or
high impedance (`Z`), and `AUD_SD` stays high. This matches the Nexys4 DDR
audio interface; the board provides the pull-up and reconstruction filter.

The two VHDL sources and the COE data are preserved without RTL or timing
changes. The project is generated for **Nexys4 DDR / Nexys A7-100T**
(`xc7a100tcsg324-1`). Synthesis, implementation, bitstream generation, and
audio operation still require Vivado 2022.2 and the physical board.

Original sources: [L9.4 directory](https://irh.inf.unideb.hu/~onigai/LDuHDL/src/L9/L9.4/).
Board audio interface: [Digilent Nexys4 DDR Reference Manual, section 16](https://digilent.com/reference/_media/nexys4-ddr%3Anexys4ddr_rm.pdf).
