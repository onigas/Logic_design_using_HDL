# Project 04 — Multichannel PWM Generator

[← Back to the project list](README.md)

**Platform:** Nexys 4 DDR / Nexys A7-100T  
**Language:** VHDL or Verilog  
**Duration:** 4–5 weeks  
**Maximum grade:** To be defined

## Project Description

Develop an HDL-based multi-channel pulse-width modulation generator to control the onboard RGB LEDs. Each channel should have an independently adjustable duty cycle, with a shared or programmable PWM frequency. Students must design counters, comparators and configuration registers, validate frequency and duty-cycle timing in simulation, and demonstrate smooth brightness or color changes on the FPGA.

## Minimum Implementation Requirements

- Generate three independent PWM channels with at least 8-bit resolution.
- Set channel duty cycles using board switches or buttons.
- Demonstrate RGB color mixing and verify PWM timing in simulation.
- Report resource usage and explain the synchronous architecture.

## Optional Extensions

- Independent frequency adjustment
- Gamma-corrected brightness and smooth fades
- UART configuration of channels

## References and Source Projects

- [Course Lab09 PWM LED](../Lab09/L9.1_PWM_LED/)
- [Course Lab09 Knight Rider PWM](../Lab09/L9.3_Knight_Rider/)
- [Digilent Nexys 4 DDR GPIO demo](https://github.com/Digilent/Nexys-4-DDR-GPIO)

## Deliverables

HDL source code, relevant constraints and testbench files, architectural block diagram, simulation evidence, working FPGA demonstration, resource utilization report, and a brief technical explanation of any reused reference design.

See the [general project guidelines](../README.md#general-project-guidelines), [recommended schedule](../README.md#recommended-project-schedule), and [evaluation criteria](../README.md#evaluation-criteria).
