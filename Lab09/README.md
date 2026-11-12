# Lab 09 - Pulse Width Modulation

Complete RTL sources, board constraints, and Tcl project-generation scripts for
**Nexys4 DDR / Nexys A7-100T** (`xc7a100tcsg324-1`) and **Vivado 2022.2**.

This package includes **all four exercises** from the original L9 source
directory, plus **L9.5 RGB332 color control**, **L9.6 melody playback**, and behavioral simulations for
**L9.1 and L9.5**.

| Exercise | Folder | Generated project |
| --- | --- | --- |
| L9.1 PWM LED brightness | `L9.1_PWM_LED` | `L9_1_PWM_LED.xpr` |
| L9.2 DC motor control with Pmod DHB1 | `L9.2_DC_Motor` | `L9_2_DC_Motor.xpr` |
| L9.3 Knight Rider LED light | `L9.3_Knight_Rider` | `L9_3_Knight_Rider.xpr` |
| L9.4 PWM audio sine-wave generator | `L9.4_PWM_Audio` | `L9_4_PWM_Audio.xpr` |
| L9.5 two RGB LEDs with RGB332 PWM | `L9.5_RGB_PWM` | `L9_5_RGB_PWM.xpr` |
| L9.6 Boci, boci, tarka melody player | `L9.6_Melody_Player` | `L9_6_Melody_Player.xpr` |

## Generate one project in Vivado

Open Vivado 2022.2, close any current project, and source the required script
from the **Tcl Console**, for example:

```tcl
source {C:/Labs/Logic_design_using_HDL/Lab09/L9.1_PWM_LED/create_project.tcl}
```

Then click **Generate Bitstream**, or run the exercise's
`build_bitstream.tcl`.

To create all six projects, including L9.4 and its ROM IP:

```tcl
source {C:/Labs/Logic_design_using_HDL/Lab09/create_all_projects.tcl}
```

Each generated project is placed below the exercise's `build/` directory.
The generated project references the version-controlled sources directly.

## Simulate L9.1

L9.1 includes `sim/pwmsim.sv`, configured automatically as the simulation
source by `create_project.tcl`. Use **Run Behavioral Simulation**, or run:

```tcl
source {C:/Labs/Logic_design_using_HDL/Lab09/L9.1_PWM_LED/run_simulation.tcl}
```

The simulation checks the 100 MHz clock / 1 ms PWM period, `SW=97`, zero duty,
and saturation at full duty. It finishes after approximately 5 ms and prints
`PASS: L9.1 PWM simulation completed`. L9.2-L9.4 remain hardware exercises.

## Simulate L9.5

```tcl
source {C:/Labs/Logic_design_using_HDL/Lab09/L9.5_RGB_PWM/run_simulation.tcl}
```

The self-checking test covers every RGB332 word on each LED independently,
complementary colors on both LEDs, zero/max duty, reset during PWM and recovery.
See [L9.5 instructions](L9.5_RGB_PWM/README.md) for pin mapping and board tests.

## Hardware summary

- Board clock: **100 MHz**.
- Reset in L9.1-L9.3, L9.5 and L9.6: **BTNC** (active high).
- L9.1 uses **SW[7:0]** to set PWM duty and **LED0** as the PWM output.
- L9.2 uses **SW[7:0]** for motor speed, **SW15** for motor 1 direction,
  **SW14** for motor 2 direction, and the **JA** Pmod header for the DHB1.
- L9.3 uses **LED[7:0]**, **SW0** for run/pause, **SW1** for fast/slow fading, and BTNC.
- L9.4 uses **SW[8:0]** to select the sine-wave frequency and the board's
  **3.5 mm audio output (J8)**. Start with decimal `SW=97` for approximately
  1 kHz. Increasing SW lowers the pitch. No external Pmod is needed.
- L9.5 uses all 16 switches as two RGB332 words for LED16/LED17. One shared
  8-bit counter provides 390.625 kHz PWM, limited to 127/256 (49.609375%) duty.
  SW8/SW9 use LVCMOS18; the other switches and RGB outputs use LVCMOS33.

- L9.6 plays the 24-note melody **Boci, boci, tarka** through J8, using sine-wave
  PWM. SW0 starts/stops playback, BTNC restarts, and the melody repeats.
  [L9.6 instructions](L9.6_Melody_Player/README.md) include notes and rhythm.
  L9.6 has no simulation files or scripts.

For L9.2, set `SW[7:0]=0` before changing either direction switch. This keeps
the DHB1 EN inputs low while DIR changes. Restore the duty switches only after
the desired direction is selected.

## Scope

The original 100 MHz clocks, RTL architectures, and timing constants are
retained. L9.1-L9.3 retain their 1 kHz PWM; L9.4 retains its 10-bit,
97.65625 kHz audio PWM. The L9.4 Tcl script recreates `dist_mem_gen_0` as a
1024 x 10 asynchronous ROM initialized from the original `data/pwm.coe`.
See `SOURCE_NOTES.md` for the required L9.3 RTL correction and presentation
notes. Keep the L9.1 simulation slides (11-12).

The original L9.1-L9.4 preparation did not include Vivado or hardware
validation. L9.5 and L9.6 validation is documented in their READMEs. Physical FPGA/Pmod
operation must be verified on the board.

## Original material

- L9 laboratory PDF: https://irh.inf.unideb.hu/~onigai/LDuHDL/2023/L9.pdf
- L9 source directory: https://irh.inf.unideb.hu/~onigai/LDuHDL/src/L9/
- Digilent Pmod DHB1 reference manual:
  https://digilent.com/reference/_media/pmod%3Apmod%3ApmodDHB1_rm.pdf
