# Logic Design using HDL

Laboratory materials for the **Logic Design using HDL** course at the University of Debrecen, Faculty of Informatics.

The current laboratories target the **Nexys4 DDR / Nexys A7-100T** FPGA board and **AMD/Xilinx Vivado 2022.2**. The repository contains source files, constraints, simulation testbenches where required, memory initialization data, and Tcl scripts that recreate the Vivado projects from source.

## Student projects

The [Projects](Projects/README.md) folder contains the proposed 4–5 week FPGA projects, their assignment pages, and grade-specific variants.

## General Project Guidelines

Students may reproduce and adapt existing open-source FPGA projects, reference designs, or tutorials. The primary objective is to understand digital hardware architectures and develop practical HDL design skills.

Each project should include:

- A functional HDL implementation running on the Nexys 4 DDR board.
- An explanation of the main design modules, datapath, control logic, and finite state machines, where applicable.
- Functional verification through simulation and hardware testing.
- A brief technical report including design architecture, simulation results, and FPGA resource utilization.
- At least one modification or extension of the reference implementation, whenever feasible.

The use of MicroBlaze or other embedded processors is not required. The focus is on digital hardware design.

## Recommended Project Schedule

| Week | Activities | Expected Deliverables |
| --- | --- | --- |
| 1 | Study the selected project, review reference designs, identify hardware modules, and prepare the architecture. | Block diagram and implementation plan |
| 2 | Implement or adapt HDL modules, develop testbenches, and perform functional simulations. | HDL source files and simulation results |
| 3 | Integrate the design, run synthesis and implementation, and test it on the Nexys 4 DDR. | Working FPGA prototype |
| 4 | Debug the system, validate its functionality, and measure FPGA resource utilization. | Functional demonstration and technical results |
| 5 | Implement optional extensions, finalize documentation, and present the project. | Final report, source code, and demonstration |

For four-week projects, the validation and final presentation activities may be combined.

## Evaluation Criteria

| Criterion | Weight |
| --- | ---: |
| Functional implementation on FPGA | 35% |
| Understanding and explanation of the HDL architecture | 25% |
| Simulation and hardware verification | 15% |
| Project documentation | 15% |
| Modifications or extensions | 10% |
| **Total** | **100%** |

Reproducing a reference design is acceptable, provided that students can explain its operation, identify the important modules, demonstrate the system, and document the implementation. Original improvements are encouraged but should not dominate the evaluation.

For project variants with maximum grades of **3/5, 4/5, and 5/5**, the rubric above is used to evaluate performance **within the selected variant**; it does not override that variant's maximum grade.

## Laboratories

### Lab 04 — FPGA memories

| Project | Topic |
| --- | --- |
| [L4.1_hdl_rom](Lab04/L4.1_hdl_rom/) | An 8 × 8 ROM described in HDL, with output on LEDs |
| [L4.2_distributed_rom](Lab04/L4.2_distributed_rom/) | A 16 × 8 ROM using Distributed Memory Generator |
| [L4.3_block_rom](Lab04/L4.3_block_rom/) | An 8 × 16 Block ROM with hexadecimal seven-segment display |

### Lab 05 — Arithmetic Logic Unit

| Project | Topic |
| --- | --- |
| [L5.1_alu_leds](Lab05/L5.1_alu_leds/) | Four-bit ALU with results displayed on LEDs |
| [L5.2_alu_display](Lab05/L5.2_alu_display/) | Four-bit ALU with hexadecimal seven-segment display |
| [L5.3_memory_alu](Lab05/L5.3_memory_alu/) | Two ROM reads, four-bit addition, and hexadecimal display |

### Lab 06 — VGA controller

| Project | Topic |
| --- | --- |
| [L6.1_stripes_1024x768](Lab06/L6.1_stripes_1024x768/) | VGA timing and alternating red/green horizontal stripes |
| [L6.2_letters_1024x768](Lab06/L6.2_letters_1024x768/) | Character bitmap from ROM, positioned using switches |

### Lab 07 — VGA sprites and animation

| Project | Topic |
| --- | --- |
| [L7_1_sprite_block_rom_1024x768](Lab07/L7_1_sprite_block_rom_1024x768/) | Display a 240 × 160 image from Block ROM at a selectable position |
| [L7_2_screen_saver_1024x768](Lab07/L7_2_screen_saver_1024x768/) | Animated sprite that bounces at the screen boundaries |

### Lab 08 — UART serial communication

| Project | Topic |
| --- | --- |
| [L8.1_TX](Lab08/L8.1_TX/) | Transmit switch data over UART |
| [L8.2_RX](Lab08/L8.2_RX/) | Receive UART bytes and display the received value |
| [L8.3_Echo](Lab08/L8.3_Echo/) | Receive a UART byte and transmit it back |

### Lab 09 — Pulse Width Modulation

| Project | Topic |
| --- | --- |
| [L9.1_PWM_LED](Lab09/L9.1_PWM_LED/) | LED brightness control with PWM and behavioral simulation |
| [L9.2_DC_Motor](Lab09/L9.2_DC_Motor/) | DC motor speed and direction control using Pmod DHB1 |
| [L9.3_Knight_Rider](Lab09/L9.3_Knight_Rider/) | Knight Rider LED animation with PWM brightness control |
| [L9.4_PWM_Audio](Lab09/L9.4_PWM_Audio/) | Sine-wave audio generation using ROM and PWM |

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
