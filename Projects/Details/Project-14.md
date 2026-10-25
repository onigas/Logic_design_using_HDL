# Project 14 — Digital Security System with Access Code

[← Back to the project list](../README.md)

**Platform:** Nexys 4 DDR / Nexys A7-100T  
**Language:** VHDL or Verilog  
**Duration:** 4–5 weeks  
**Maximum grade:** **3/5**

## Project Description

Develop an HDL-based access control system with a programmable or predefined code entered through FPGA switches and push buttons. A finite state machine manages digit entry, code verification, access grant, error indication, failed-attempt counting and lockout. Seven-segment digits and LEDs show the interface state; no real door actuator is needed.

## Minimum Implementation Requirements

- Support a four-symbol access code and explicit entry/confirmation.
- Debounce input controls and implement code-verification FSM.
- Indicate access granted/denied and lock after three failed attempts.
- Support reset, timeout or lock release, with functional testbenches.

## Optional Extensions

- Change code through a protected programming state
- UART user interface and status logging
- Multiple users or a countdown during temporary lockout

## References and Source Projects

- [Course Lab 05 ALU and display modules](../../Lab05/)
- [Course Lab 08 UART](../../Lab08/)
- [Digilent Nexys4 DDR GPIO demo](https://github.com/Digilent/Nexys-4-DDR-GPIO)
- [HDLBits FSM exercises](https://hdlbits.01xz.net/wiki/Main_Page)

## Deliverables

HDL source code, relevant constraints and testbench files, architectural block diagram, simulation evidence, working FPGA demonstration, resource utilization report, and a brief technical explanation of any reused reference design.

See the [general project guidelines](../../README.md#general-project-guidelines), [recommended schedule](../../README.md#recommended-project-schedule), and [evaluation criteria](../../README.md#evaluation-criteria).
