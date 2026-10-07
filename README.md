# Logic Design using HDL

Laboratory materials for the **Logic Design using HDL** course at the University of Debrecen, Faculty of Informatics.

The current laboratories target the **Nexys4 DDR / Nexys A7-100T** FPGA board and **AMD/Xilinx Vivado 2022.2**. The repository contains source files, constraints, simulation testbenches, memory initialization data, and Tcl scripts that recreate the Vivado projects from source.

## Repository structure

```text
Logic_design_using_HDL/
├── Lab04/
│   ├── L4.1_hdl_rom/
│   ├── L4.2_distributed_rom/
│   ├── L4.3_block_rom/
│   ├── tools/
│   └── README.md
├── Lab05/
│   ├── L5.1_alu_leds/
│   ├── L5.2_alu_display/
│   ├── L5.3_memory_alu/
│   └── README.md
├── Lab06/
│   ├── L6.1_stripes_1024x768/
│   ├── L6.2_letters_1024x768/
│   └── README.md
├── Lab07/
│   ├── L7_1_sprite_block_rom_1024x768/
│   ├── L7_2_screen_saver_1024x768/
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

## Recreating a Vivado project

Each exercise is self-contained and has its own `create_project.tcl` file. No generated Vivado project files are stored in the repository.

From **Vivado 2022.2 -> Window -> Tcl Console**:

```tcl
cd <path-to-the-exercise-folder>
source create_project.tcl
```

The script creates a new `vivado_project/` directory, adds the required HDL and constraint files, generates any required Vivado IP, and selects the correct top module.

You can also run a script from a terminal where Vivado is available in `PATH`, for example:

```text
vivado -mode batch -source create_project.tcl
```

## Target hardware and software

- Nexys4 DDR / Nexys A7-100T
- FPGA: XC7A100T-1CSG324C
- Vivado 2022.2
- Verilog/SystemVerilog

> Check the FPGA device fitted to the physical board before generating a bitstream. The supplied Tcl scripts use `xc7a100tcsg324-1`.

## Repository policy

Only source material required to reproduce the exercises is version-controlled. Generated Vivado files such as `.Xil/`, `vivado_project/`, run directories, logs, journals, bitstreams, and cached IP products are intentionally excluded.
