# Lab 09 - Pulse Width Modulation

Complete RTL sources, board constraints, and Tcl project-generation scripts for
**Nexys4 DDR / Nexys A7-100T** (`xc7a100tcsg324-1`) and **Vivado 2022.2**.

This package includes **all four exercises** from the original L9 source
directory, plus the **L9.1 behavioral PWM simulation**.

| Exercise | Folder | Generated project |
| --- | --- | --- |
| L9.1 PWM LED brightness | `L9.1_PWM_LED` | `L9_1_PWM_LED.xpr` |
| L9.2 DC motor control with Pmod DHB1 | `L9.2_DC_Motor` | `L9_2_DC_Motor.xpr` |
| L9.3 Knight Rider LED light | `L9.3_Knight_Rider` | `L9_3_Knight_Rider.xpr` |
| L9.4 PWM audio sine-wave generator | `L9.4_PWM_Audio` | `L9_4_PWM_Audio.xpr` |

## Generate one project in Vivado

Open Vivado 2022.2, close any current project, and source the required script
from the **Tcl Console**, for example:

```tcl
source {C:/Labs/Logic_design_using_HDL/Lab09/L9.1_PWM_LED/create_project.tcl}
```

Then click **Generate Bitstream**, or run the exercise's
`build_bitstream.tcl`.

To create all four projects, including L9.4 and its ROM IP:

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

## Hardware summary

- Board clock: **100 MHz**.
- Reset in L9.1-L9.3: **BTNC** (active high).
- L9.1 uses **SW[7:0]** to set PWM duty and **LED0** as the PWM output.
- L9.2 uses **SW[7:0]** for motor speed, **SW15** for motor 1 direction,
  **SW14** for motor 2 direction, and the **JA** Pmod header for the DHB1.
- L9.3 uses **LED[7:0]**, **SW0** for run/pause, **SW1** for fast/slow fading, and BTNC.
- L9.4 uses **SW[8:0]** to select the sine-wave frequency and the board's
  **3.5 mm audio output (J8)**. Start with decimal `SW=97` for approximately
  1 kHz. Increasing SW lowers the pitch. No external Pmod is needed.

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

Vivado 2022.2 and the physical FPGA/Pmod hardware are not available in this
preparation environment, so synthesis, implementation, bitstream generation,
and on-board operation must be verified locally.

## Original material

- L9 laboratory PDF: https://irh.inf.unideb.hu/~onigai/LDuHDL/2023/L9.pdf
- L9 source directory: https://irh.inf.unideb.hu/~onigai/LDuHDL/src/L9/
- Digilent Pmod DHB1 reference manual:
  https://digilent.com/reference/_media/pmod%3Apmod%3ApmodDHB1_rm.pdf
