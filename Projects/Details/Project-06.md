# Project 06 — SPI Interface for the ADXL362 Accelerometer

[← Back to the project list](../README.md)

**Platform:** Nexys 4 DDR / Nexys A7-100T  
**Language:** VHDL or Verilog  
**Duration:** 4–5 weeks  
**Maximum grade:** To be defined

## Project Description

Build an SPI master and acquisition controller in VHDL or Verilog to communicate with the onboard ADXL362 three-axis accelerometer. The design should initialize the sensor, read X/Y/Z acceleration values at a regular interval and expose measurements using LEDs, seven-segment display or UART. Explain the SPI timing, device register transactions, signed data representation and acquisition FSM.

## Minimum Implementation Requirements

- Configure the ADXL362 through SPI with documented transactions.
- Read and display all three acceleration axes.
- Use synchronous state machines for transaction sequencing.
- Simulate SPI signaling and validate readings by tilting the board.

## Optional Extensions

- UART transmission of measured X/Y/Z acceleration values to a PC terminal.
- Orientation or motion detection with configurable thresholds and an LED alarm.
- Periodic sampling with selectable output data rate and a simple measurement history or peak-value register.
- Basic filtering or averaging of the acceleration measurements before display.

These are suggested project extensions, not verified exercises extracted from the linked L13 handout.

## References and Source Projects

- [Logic Design Using HDL (2023) — Laboratory 13 (L13.pdf), instructor course material](https://irh.inf.unideb.hu/~onigai/LDuHDL/2023/L13.pdf) *(linked as supplementary course material; its detailed content has not yet been verified)*
- [Digilent Nexys4 DDR Out-of-Box example](https://github.com/Digilent/Nexys-4-DDR-OOB)
- [Digilent VHDL top-level sensor integration](https://github.com/Digilent/Nexys-4-DDR-OOB/blob/master/src/hdl/Nexys4DdrUserDemo.vhd)
- [ADXL362 datasheet](https://www.analog.com/media/en/technical-documentation/data-sheets/adxl362.pdf)

## Deliverables

HDL source code, relevant constraints and testbench files, architectural block diagram, simulation evidence, working FPGA demonstration, resource utilization report, and a brief technical explanation of any reused reference design.

See the [general project guidelines](../../README.md#general-project-guidelines), [recommended schedule](../../README.md#recommended-project-schedule), and [evaluation criteria](../../README.md#evaluation-criteria).
