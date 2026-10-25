# Project 03 — Advanced Digital Clock with VGA Display and Multiple Alarms

[← Back to the project list](../README.md)

**Platform:** Nexys 4 DDR / Nexys A7-100T  
**Language:** VHDL or Verilog  
**Duration:** 4–5 weeks  
**Maximum grade:** 5/5 (on a 1–5 scale)

## Project description

Implement a fully configurable digital clock with 12/24-hour display, time and date/weekday settings, a VGA 640×480 interface, seven-segment display, and at least three independently programmable weekday-scheduled alarms. Provide audible alarm output; UART configuration and analog-style clock graphics are optional extensions.

## Suggested HDL modules

clock/date core, weekday scheduler, multiple alarm storage and comparators, font ROM/VGA controller, seven-segment interface, PWM audio.

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

See [general project guidelines](../../README.md#general-project-guidelines) and [evaluation criteria](../../README.md#evaluation-criteria).
