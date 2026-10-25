# Project 01 — Digital Clock with Seven-Segment Display

[← Back to the project list](README.md)

**Platform:** Nexys 4 DDR / Nexys A7-100T  
**Language:** VHDL or Verilog  
**Duration:** 4–5 weeks  
**Maximum grade:** 3/5 (on a 1–5 scale)

## Project description

Develop a digital clock with HH:MM:SS timekeeping, switch/button adjustment, selectable 12-hour (AM/PM) and 24-hour formats, and seven-segment output. Implement correct time rollover and verification testbenches.

## Suggested HDL modules

clock-enable generator, timekeeping counters, time-format conversion, input synchronizer/debouncer, time-setting FSM, seven-segment controller.

## Minimum deliverables

A working FPGA demonstration, an architectural block diagram, functional simulation and testbench results, implementation/resource reports, and a short explanation of reused or adapted code.

## Reference projects

- [Verilog Digital Clock — Nexys4DDR](https://github.com/nnyilun/VerilogDigitalClock)
- [FPGA Digital Alarm Clock with Stopwatch and UART](https://github.com/ft-rohan/fpga-digital-alarm-clock-verilog)
- [FPGA Digital Clock with Alarm — Basys 3](https://github.com/KashaanAhamad/FPGA-Digital-Clock)
- [Digilent Nexys 4 DDR Out-of-Box Demo](https://github.com/Digilent/Nexys-4-DDR-OOB)
- [Earlier course projects](https://irh.inf.unideb.hu/~onigai/LDuHDL/2023/)


## Verification and demonstration

Show correct 12/24-hour conversion and rollover, time setting and the specific output and alarm functionality of this project. The clock does not retain time after power loss without additional hardware.

See [general project guidelines](../README.md#general-project-guidelines) and [evaluation criteria](../README.md#evaluation-criteria).
