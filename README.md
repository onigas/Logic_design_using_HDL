# Logic Design using HDL

Laboratory materials for the **Logic Design using HDL** course at the University of Debrecen, Faculty of Informatics.

The current laboratories target the **Nexys4 DDR / Nexys A7-100T** FPGA board and **AMD/Xilinx Vivado 2022.2**. The repository contains source files, constraints, simulation testbenches where required, memory initialization data, and Tcl scripts that recreate the Vivado projects from source.

## Repository structure

```text
Logic_design_using_HDL/
├── Lab04/
├── Lab05/
├── Lab06/
├── Lab07/
├── Lab08/
│   ├── L8.1_TX/
│   ├── L8.2_RX/
│   ├── L8.3_Echo/
│   └── README.md
├── Lab09/
│   ├── L9.1_PWM_LED/
│   ├── L9.2_DC_Motor/
│   ├── L9.3_Knight_Rider/
│   ├── L9.4_PWM_Audio/
│   ├── create_all_projects.tcl
│   └── README.md
├── .gitignore
└── README.md
```

## Laboratories

| Laboratory | Topic | Main exercises |
| --- | --- | --- |
| [Lab04](Lab04/) | FPGA memories | HDL ROM, Distributed ROM, Block ROM |
| [Lab05](Lab05/) | Arithmetic Logic Unit | ALU with LEDs, seven-segment display, memory + ALU |
| [Lab06](Lab06/) | VGA controller | 1024x768 timing, color stripes, character sprite from PROM |
| [Lab07](Lab07/) | VGA sprites and animation | Image ROM, sprite display, screen-saver animation |
| [Lab08](Lab08/) | UART serial communication | Transmitter, receiver, raw-byte echo |
| [Lab09](Lab09/) | Pulse Width Modulation | LED brightness and simulation, DC motor control, Knight Rider LED effect, PWM audio |

## Recreating a Vivado project

Each exercise is self-contained and has its own `create_project.tcl` file. No generated Vivado project files are stored in the repository.

From **Vivado 2022.2 -> Window -> Tcl Console**:

```tcl
cd <path-to-the-exercise-folder>
source create_project.tcl
```

For Labs 04-07, the script creates a new `vivado_project/` directory, adds the required HDL and constraint files, generates any required Vivado IP, and selects the correct top module. Labs 08-09 create their projects under each exercise's `build/` directory and provide `build_bitstream.tcl` scripts. Lab08 contains no simulation tasks. Lab09 includes a behavioral simulation and `run_simulation.tcl` for L9.1; L9.4 recreates its sine-wave ROM IP from the supplied initialization data.

You can also run a script from a terminal where Vivado is available in `PATH`, for example:

```text
vivado -mode batch -source create_project.tcl
```

## Target hardware and software

- Nexys4 DDR / Nexys A7-100T
- FPGA: XC7A100T-1CSG324C
- Vivado 2022.2
- Verilog/SystemVerilog and VHDL

> Check the FPGA device fitted to the physical board before generating a bitstream. The supplied Tcl scripts use `xc7a100tcsg324-1`.

## Repository policy

Only source material required to reproduce the exercises is version-controlled. Generated Vivado files such as `.Xil/`, `vivado_project/`, `build/`, run directories, logs, journals, bitstreams, and cached IP products are intentionally excluded.
