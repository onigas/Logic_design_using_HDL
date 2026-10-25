# Project 08 — FPGA VGA Drawing Application

[← Back to the project list](README.md)

**Platform:** Nexys 4 DDR / Nexys A7-100T  
**Language:** VHDL or Verilog  
**Duration:** 4–5 weeks  
**Maximum grade:** **4/5**

## Project Description

Develop a simple interactive FPGA Paint application on a VGA monitor. Reuse the Lab 06 video timing logic but add a writable framebuffer in block RAM, a movable drawing cursor, a palette, and user commands to draw or erase pixels. The internal drawing resolution may be smaller than the video resolution (for example, 128 × 96), scaled to the 1024 × 768 display. Students must separate the video read path from the user-controlled memory update path.

## Minimum Implementation Requirements

1. Display a VGA graphics interface at 1024 × 768 @ 60 Hz.
2. Implement a movable cursor controlled by board buttons/switches.
3. Implement a persistent pixel canvas in BRAM using at least two distinguishable drawing colors plus background.
4. Support draw, erase, color selection, and clear-canvas operations.
5. Resolve simultaneous framebuffer read/write access and explain the memory design.
6. Simulate cursor limits and drawing-state transitions; demonstrate drawings surviving cursor movement.

## Optional Extensions

- Simple line drawing or brush size selection.
- UART command input for cursor movement or palette selection.
- On-screen help or toolbar using font ROM.

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
