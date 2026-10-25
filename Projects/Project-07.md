# Project 07 — Interactive VGA Graphics System

[← Back to the project list](README.md)

**Platform:** Nexys 4 DDR / Nexys A7-100T  
**Language:** VHDL or Verilog  
**Duration:** 4–5 weeks  
**Maximum grade:** proposed variants 3/5, 4/5, 5/5 — pending approval

## Project Description

Extend the VGA controller and Block ROM sprite exercises from Labs 06 and 07 into an interactive graphics application. Basic work combines several independently movable graphics objects and text with priority/overlap handling. More advanced variants implement a small pixel canvas and drawing interface, and optionally a graphics editor with multiple tools. Simply repeating stripes, a positioned ROM image or the bouncing screensaver is insufficient.

## Minimum Implementation Requirements

- Reuse the existing 1024 × 768 VGA timing system and 65 MHz pixel clock.
- Render at least three distinguishable graphical objects and a ROM-based text label.
- Provide user-controlled movement or parameter selection, not only automatic animation.
- Implement and explain object compositing/overlap priority.
- Verify positioning and boundaries in simulation and on the monitor.

## Optional Extensions and Proposed Grading Variants

- Variant A (proposed maximum 3/5): interactive sprites, text, and coordinate/status display.
- Variant B (proposed maximum 4/5): framebuffer-based Paint tool with cursor, palette and erase operation; a lower-resolution logical canvas may be scaled to VGA.
- Variant C (proposed maximum 5/5): line/rectangle tools, graphical menus, and optionally PS/2 mouse or UART save/load.

## References and Source Projects

- [Lab 06 VGA controller](../Lab06/)
- [Lab 07 VGA sprites and screen-saver](../Lab07/)
- [Digilent Nexys 4 DDR Out-of-Box demo](https://github.com/Digilent/Nexys-4-DDR-OOB)
- [Adam Taylor — Space Invaders in VHDL (graphics concepts)](https://www.hackster.io/adam-taylor/space-invaders-on-any-arty-board-using-vhdl-and-pmod-vga-1f5161)

## Deliverables

HDL source code, relevant constraints and testbench files, architectural block diagram, simulation evidence, working FPGA demonstration, resource utilization report, and a brief technical explanation of any reused reference design.

See the [general project guidelines](../README.md#general-project-guidelines), [recommended schedule](../README.md#recommended-project-schedule), and [evaluation criteria](../README.md#evaluation-criteria).
