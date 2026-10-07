# Lab 09 - Pulse Width Modulation

Complete RTL sources, board constraints, and Tcl project-generation scripts for
**Nexys4 DDR / Nexys A7-100T** (`xc7a100tcsg324-1`) and **Vivado 2022.2**.

This package follows the supplied L9 laboratory material but keeps only the
hardware exercises. Simulation tasks are intentionally omitted.

| Exercise | Folder | Generated project |
| --- | --- | --- |
| L9.1 PWM LED brightness | `L9.1_PWM_LED` | `L9_1_PWM_LED.xpr` |
| L9.2 DC motor control with Pmod DHB1 | `L9.2_DC_Motor` | `L9_2_DC_Motor.xpr` |
| L9.3 Knight Rider LED light | `L9.3_Knight_Rider` | `L9_3_Knight_Rider.xpr` |

## Generate one project in Vivado

Open Vivado 2022.2, close any current project, and source the required script
from the **Tcl Console**, for example:

```tcl
source {C:/Labs/Logic_design_using_HDL/Lab09/L9.1_PWM_LED/create_project.tcl}
```

Then click **Generate Bitstream**, or run the exercise's
`build_bitstream.tcl`.

To create all three projects:

```tcl
source {C:/Labs/Logic_design_using_HDL/Lab09/create_all_projects.tcl}
```

Each generated project is placed below the exercise's `build/` directory.
The generated project references the version-controlled sources directly.

## Hardware summary

- Board clock: **100 MHz**.
- Reset: **BTNC** (active high in these designs).
- L9.1 uses **SW[7:0]** to set PWM duty and **LED0** as the PWM output.
- L9.2 uses **SW[7:0]** for motor speed, **SW15** for motor 1 direction,
  **SW14** for motor 2 direction, and the **JA** Pmod header for the DHB1.
- L9.3 uses **LED[7:0]**, **SW0/SW1**, and BTNC.

For L9.2, set `SW[7:0]=0` before changing either direction switch. This keeps
the DHB1 EN inputs low while DIR changes. Restore the duty switches only after
the desired direction is selected.

## Scope

The original 100 MHz clock and 1 kHz PWM architecture are retained. No clocking
redesign, simulation testbench, or nonessential RTL modernization is included.
See `SOURCE_NOTES.md` for the one required L9.3 RTL correction and the slide
updates recommended for the laboratory presentation.

The source directory on the original web server also contains an `L9.4`
audio-PWM example, but the supplied `L9.pdf` ends with L9.3. L9.4 is therefore
not included in this package.

Vivado 2022.2 and the physical FPGA/Pmod hardware are not available in this
preparation environment, so synthesis, implementation, bitstream generation,
and on-board operation must be verified locally.

## Original material

- L9 laboratory PDF: https://irh.inf.unideb.hu/~onigai/LDuHDL/2023/L9.pdf
- L9 source directory: https://irh.inf.unideb.hu/~onigai/LDuHDL/src/L9/
- Digilent Pmod DHB1 reference manual:
  https://digilent.com/reference/_media/pmod%3Apmod%3ApmodDHB1_rm.pdf
