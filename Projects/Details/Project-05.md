# Project 05 — Intelligent Traffic Light Controller

[← Back to the project list](../README.md)

**Platform:** Nexys 4 DDR / Nexys A7-100T  
**Language:** VHDL or Verilog  
**Duration:** 4–5 weeks  
**Maximum grade:** To be defined

## Project Description

Implement an HDL finite-state-machine controller for a two-road intersection with pedestrian crossings. LEDs represent traffic lights, buttons simulate pedestrian requests, and the seven-segment display shows the remaining phase time. The student must design safe light sequences, synchronize and debounce requests, and verify that conflicting traffic directions can never receive green simultaneously.

## Minimum Implementation Requirements

- Two coordinated traffic directions and safe red/yellow/green phases.
- Pedestrian button request with controlled crossing phase.
- Configurable phase timing and seven-segment countdown.
- Reset and simulation tests covering conflicting requests and safe startup.

## Optional Extensions

- Priority for emergency vehicles
- Adaptive green duration based on simulated traffic sensors
- VGA traffic-intersection visualization

## References and Source Projects

- [Course laboratory modules](../../README.md#laboratories)
- [HDLBits FSM exercises](https://hdlbits.01xz.net/wiki/Main_Page)
- [Hackster FPGA traffic-light projects](https://www.hackster.io/search?i=projects&q=FPGA%20traffic%20light)

## Deliverables

HDL source code, relevant constraints and testbench files, architectural block diagram, simulation evidence, working FPGA demonstration, resource utilization report, and a brief technical explanation of any reused reference design.

See the [general project guidelines](../../README.md#general-project-guidelines), [recommended schedule](../../README.md#recommended-project-schedule), and [evaluation criteria](../../README.md#evaluation-criteria).
