# Project 12 — FPGA-Based FIR Digital Filter

[← Back to the project list](../README.md)

**Platform:** Nexys 4 DDR / Nexys A7-100T  
**Language:** VHDL or Verilog  
**Duration:** 4–5 weeks  
**Maximum grade:** **4/5**

## Project Description

Implement a signed fixed-point finite impulse response filter in synthesizable HDL. The design should include sample delays, configurable or constant coefficients, multiplication and accumulation, and a testbench that compares output samples with a software reference. Evaluate the impact of arithmetic precision, pipelining and filter length on FPGA resources and latency.

## Minimum Implementation Requirements

- Implement an FIR filter with at least eight taps and a documented fixed-point format.
- Verify response using impulse, sinusoidal and multitone input samples.
- Compare RTL results with Python/MATLAB reference outputs.
- Present FPGA DSP/LUT utilization, timing, and numerical error.

## Optional Extensions

- Programmable coefficients or multiple filter modes
- Pipelined vs serial MAC comparison
- Audio PWM or UART input/output demonstration

## References and Source Projects

- Xilinx DSP Primer — instructor-provided archive (separate from The Zynq Book)
- [16-tap Verilog FIR reference](https://github.com/rombarak/FIR-Filter)
- [Pipelined FIR HDL example](https://github.com/Mounika2198/fpga-projects/tree/main/03_fir_filter)
- [Adam Taylor projects](https://www.hackster.io/adam-taylor/projects)

## Deliverables

HDL source code, relevant constraints and testbench files, architectural block diagram, simulation evidence, working FPGA demonstration, resource utilization report, and a brief technical explanation of any reused reference design.

See the [general project guidelines](../../README.md#general-project-guidelines), [recommended schedule](../../README.md#recommended-project-schedule), and [evaluation criteria](../../README.md#evaluation-criteria).
