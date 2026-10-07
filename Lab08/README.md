# Lab 08 - UART Projects for Vivado 2022.2

Complete sources, board constraints, and Tcl project-generation scripts for
**Nexys4 DDR** and **Nexys A7-100T** (`xc7a100tcsg324-1`).
Select the FPGA part directly; no separate Digilent board-file installation
is required. These scripts target the 100T board variant.

| Exercise | Folder | Tcl script | Generated project |
| --- | --- | --- | --- |
| L8.1 Transmitter | `L8.1_TX` | `create_project.tcl` | `L8_1_TX.xpr` |
| L8.2 Receiver | `L8.2_RX` | `create_project.tcl` | `L8_2_RX.xpr` |
| L8.3 Echo | `L8.3_Echo` | `create_project.tcl` | `L8_3_Echo.xpr` |

## Generate one project in the Vivado GUI

Download or clone the complete repository. Open Vivado 2022.2, close any current project,
and enter this in the **Tcl Console**, adjusting the path:

```tcl
source {C:/Labs/Logic_design_using_HDL/Lab08/L8.3_Echo/create_project.tcl}
```

The generated project opens immediately. Click **Generate Bitstream** and
program the board with **Hardware Manager**. Each exercise's README contains
the exact controls and hardware check.

To create all three projects, with no project currently open:

```tcl
source {C:/Labs/Logic_design_using_HDL/Lab08/create_all_projects.tcl}
```

Each project is generated beneath its exercise's `build/` directory and then
closed. Open the desired `.xpr` to work with it.

## Generate a bitstream with Tcl

For the open echo project, or with no other project open:

```tcl
source {C:/Labs/Logic_design_using_HDL/Lab08/L8.3_Echo/build_bitstream.tcl}
```

This script creates/opens the project, rebuilds synthesis and implementation,
and generates `Top_Module.bit`. It does not program the board.

From a Windows Command Prompt with Vivado 2022.2 on PATH, you can also run:

```bat
vivado -mode batch -source "C:/Labs/Logic_design_using_HDL/Lab08/L8.3_Echo/create_project.tcl"
vivado -mode batch -source "C:/Labs/Logic_design_using_HDL/Lab08/L8.3_Echo/build_bitstream.tcl"
```

Use forward slashes in the Vivado Tcl Console and braces around paths
containing spaces. Scripts locate their own sources independently of the
current working directory. Keep the repository folder in place while using
its generated projects.

## Hardware setup

- Connect the **PROG/UART** USB port and power on the board.
- Program the selected design, then press and release **BTNR** to reset it.
- Configure the serial terminal for **9600 baud, 8N1, no flow control**.
- For echo, disable the terminal's local echo.
- **BTNC** sends the switch byte in L8.1; **BTNR** resets all three designs.
- `RxD` uses FPGA pin **C4**; `TxD` uses FPGA pin **D4**.

The original design uses four rightmost seven-segment digits. Its segment
order is `a_to_g[6:0] = {A,B,C,D,E,F,G}`.

## Scope and verification

The original RTL is retained, including `clkdiv`, the 25 MHz / approximately
190 Hz divided clocks, the existing UART state machines, asynchronous control
style, and 9600-baud counters. No simulation sources or simulation tasks are
included. See `SOURCE_NOTES.md` for the echo-source check and slide correction.

RTL parsing/elaboration, synthesis checks, pin assignments, and Tcl file
references were checked during packaging. Vivado 2022.2 and an FPGA board are
not available in the preparation environment, so Vivado implementation,
bitstream generation, and on-board operation must be checked locally.

## Sources

- [Original L8 laboratory sources](https://irh.inf.unideb.hu/~onigai/LDuHDL/src/L8/)
- [Original L8.3 source archive](https://irh.inf.unideb.hu/~onigai/LDuHDL/src/L8/L8.3/L8.3.srcs.rar)
- [Digilent Nexys4 DDR master constraints](https://github.com/Digilent/digilent-xdc/blob/master/Nexys-4-DDR-Master.xdc)
- [Vivado 2022.2 Tcl: create_project](https://docs.amd.com/r/2022.2-English/ug835-vivado-tcl-commands/create_project)
