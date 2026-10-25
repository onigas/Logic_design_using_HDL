# Project 07 — Interactive VGA Graphics and Text Display

[← Back to the project list](../README.md)

**Platform:** Nexys 4 DDR / Nexys A7-100T  
**Language:** VHDL or Verilog  
**Duration:** 4–5 weeks  
**Maximum grade:** **3/5**

## Project Description

Design an interactive VGA graphics display that combines multiple geometric objects, bitmap sprites, and text. Reuse the video timing controller developed in Lab 06 and extend the sprite renderer from Lab 07. Users must control graphics properties and movement using onboard buttons and switches. Unlike the laboratory exercises, the design must compose several independent graphics layers and report object coordinates or states.

## Minimum Implementation Requirements

1. Generate 1024 × 768 @ 60 Hz VGA output using a 65 MHz pixel clock.
2. Display at least three independent, distinguishable graphics objects simultaneously.
3. Move at least two objects using user controls; include boundary checks.
4. Display a fixed or dynamic text label using a character bitmap ROM.
5. Handle overlapping objects with explicitly implemented priority rules.
6. Provide simulation and an FPGA demonstration showing input response and graphics composition.

## Optional Extensions

- Selectable object colors and sizes.
- Status panel showing coordinates or active object.
- UART control for selecting and moving objects.

## Suggested HDL Architecture

Clocking / pixel enable, VGA timing, pixel coordinates, graphics renderer or framebuffer controller, input debouncer, cursor / drawing FSM, and any project-specific text ROM, object priority or shape rasterization units.

## References and Source Projects

- [Course Lab 06 — VGA controller](../../Lab06/)
- [Course Lab 07 — sprites and screen-saver](../../Lab07/)
- [Digilent Nexys 4 DDR resources](https://github.com/Digilent/Nexys4DDR)
- [Adam Taylor — Space Invaders graphics concepts](https://www.hackster.io/adam-taylor/space-invaders-on-any-arty-board-using-vhdl-and-pmod-vga-1f5161)

## Deliverables

HDL source, XDC constraints, architectural block diagram, testbenches and simulations, working FPGA demonstration, Vivado utilization/timing reports, and documentation of reused modules.

**Important:** Reproduction of Lab 06 color stripes or Lab 07 single-sprite bounce alone does not satisfy the requirements for this project.

See the [general guidelines](../../README.md#general-project-guidelines) and [evaluation criteria](../../README.md#evaluation-criteria).
