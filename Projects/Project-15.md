# Project 15 — FPGA-Based Robotic Arm Controller

[← Back to the project list](README.md)

**Platform:** Digilent Nexys 4 DDR / Nexys A7-100T  
**Language:** VHDL or Verilog  
**Duration:** 4–5 weeks  
**Maximum grade:** 5/5 (proposed)

## Project Description

Design and implement an HDL-based controller for a small robotic arm using the Nexys 4 DDR FPGA board. The design should independently control the positions of multiple servo motors by generating correctly timed control pulses. Joint angles should be adjustable using onboard switches/buttons or an optional UART interface. A finite state machine should coordinate manual operation, safe initialization, and execution of a predefined movement sequence. The mechanical design and the number of joints may be adapted to the robotic arm available to the student. The student must explain the PWM/servo pulse generation, joint position registers, and control logic.

## Minimum Implementation Requirements

- Control at least three servo-driven joints with independently adjustable positions.
- Generate servo-compatible periodic control pulses with configurable pulse widths (typically around 1–2 ms in a ~20 ms frame, subject to servo specifications).
- Provide user controls for selecting a joint and adjusting its target angle.
- Implement safe startup positions, travel limits, and an emergency stop/disable function.
- Execute at least one predefined multi-joint movement sequence.
- Simulate pulse timing and demonstrate real hardware motion.

## Optional Extensions

- Record and replay a sequence of arm positions.
- Adjustable movement speed and interpolation between positions.
- UART command interface or predefined pick-and-place routine.
- Position feedback if supported by the actuators.

## Suggested HDL Modules

Servo pulse generator, joint position registers, user input controller, manual/automatic FSM, joint limit protection, movement sequencer.

## References and Source Projects

- [3DOF Robotic Arm FPGA — Nexys 4 DDR (Verilog project)](https://github.com/ZaidAkhtar/3DOF_RoboticArmFPGA)
- [Course Lab 09 — PWM](../Lab09/)
- [Digilent Nexys 4 DDR Resources](https://github.com/Digilent/Nexys4DDR)

## Technical Notes

**Hardware safety:** Motors must use a suitable independent power supply and a common ground with the FPGA interface where applicable. Do not power servo motors from FPGA I/O pins. Confirm connector voltage levels and provide proper interfacing and emergency-stop provisions.

See the [general project guidelines](../README.md#general-project-guidelines) and [evaluation criteria](../README.md#evaluation-criteria).
