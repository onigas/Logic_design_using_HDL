# Project 09 — Advanced FPGA VGA Graphics Editor

[← Back to the project list](README.md)

**Platform:** Nexys 4 DDR / Nexys A7-100T  
**Language:** VHDL or Verilog  
**Duration:** 4–5 weeks  
**Maximum grade:** **5/5**

## Project Description

Design a more advanced FPGA-based graphics editor with multiple interactive drawing tools. The design should extend an editable framebuffer canvas with line and rectangle primitives, a visual toolbar/menu, tool selection and a color palette. An FSM or dedicated drawing engine must rasterize shapes into memory without a processor. Students should document the memory architecture, video pipeline, input state machines and resource usage.

## Minimum Implementation Requirements

1. Generate 1024 × 768 @ 60 Hz VGA video with a framebuffer-based canvas.
2. Provide interactive cursor, pixel painting, erasing, and clear operations.
3. Implement at least two geometric drawing tools beyond single-pixel painting: line and rectangle.
4. Display a graphical toolbar/menu and indicate the active tool and color.
5. Implement shape rasterization with synthesizable HDL control/datapath, e.g. line-drawing algorithm and rectangle edge generation.
6. Test tool state transitions and boundary conditions in simulation and demonstrate the complete editor.

## Optional Extensions

- Filled primitives or simple flood fill with a bounded work queue.
- PS/2 mouse control if compatible external hardware is available.
- UART picture save/load or single-step Undo using additional memory.

## Suggested HDL Architecture

Clocking / pixel enable, VGA timing, pixel coordinates, graphics renderer or framebuffer controller, input debouncer, cursor / drawing FSM, and any project-specific text ROM, object priority or shape rasterization units.

## References and Source Projects

- [Course Lab 06 — VGA controller](../Lab06/)
- [Course Lab 07 — sprites and screen-saver](../Lab07/)
- [Digilent Nexys 4 DDR resources](https://github.com/Digilent/Nexys4DDR)
- [Adam Taylor — Space Invaders graphics concepts](https://www.hackster.io/adam-taylor/space-invaders-on-any-arty-board-using-vhdl-and-pmod-vga-1f5161)

## Deliverables

HDL source, XDC constraints, architectural block diagram, testbenches and simulations, working FPGA demonstration, Vivado utilization/timing reports, and documentation of reused modules.

**Important:** Reproduction of Lab 06 color stripes or Lab 07 single-sprite bounce alone does not satisfy the requirements for this project.

See the [general guidelines](../README.md#general-project-guidelines) and [evaluation criteria](../README.md#evaluation-criteria).
