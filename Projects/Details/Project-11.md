# Project 11 — FPGA-Based Digital Logic Analyzer

[← Back to the project list](../README.md)

**Platform:** Nexys 4 DDR / Nexys A7-100T  
**Language:** VHDL or Verilog  
**Duration:** 4–5 weeks  
**Maximum grade:** **5/5**

## Project Description

Create a compact multi-channel logic analyzer using FPGA GPIO inputs. Samples captured at a programmable rate are buffered in BRAM after an edge or manual trigger and transmitted over UART to a PC for display. Students should explain acquisition timing, trigger circuits, buffer addressing and the relationship between sample rate, channel count and memory depth.

## Minimum Implementation Requirements

- Sample at least four digital channels using 3.3 V-compatible Pmod inputs.
- Implement BRAM capture memory and manual or edge triggering.
- Provide configurable capture rate and UART data transfer.
- Show captured waveforms on a PC and verify triggering in simulation.

## Optional Extensions

- Pre-trigger and post-trigger capture
- Multi-bit pattern trigger
- UART/SPI protocol decoding or sigrok-compatible export

## References and Source Projects

- [Course Lab 04 FPGA memories](../../Lab04/)
- [Course Lab 08 UART](../../Lab08/)
- [sigrok signal analysis](https://sigrok.org/wiki/Main_Page)
- [Nexys4 DDR board resources](https://github.com/Digilent/Nexys4DDR)

## Deliverables

HDL source code, relevant constraints and testbench files, architectural block diagram, simulation evidence, working FPGA demonstration, resource utilization report, and a brief technical explanation of any reused reference design.

See the [general project guidelines](../../README.md#general-project-guidelines), [recommended schedule](../../README.md#recommended-project-schedule), and [evaluation criteria](../../README.md#evaluation-criteria).
