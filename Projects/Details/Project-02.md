# Project 02 — Digital Alarm Clock with UART Interface

[← Back to the project list](../README.md)

**Platform:** Nexys 4 DDR / Nexys A7-100T  
**Language:** VHDL or Verilog  
**Duration:** 4–5 weeks  
**Maximum grade:** 4/5 (on a 1–5 scale)

## Project Description

Design and implement a digital clock and alarm system using HDL. The clock must display hours, minutes, and seconds on the onboard seven-segment display, supporting both 12-hour (AM/PM) and 24-hour formats. **The current time and alarm settings must be configured from a PC terminal through the UART interface**, rather than through onboard switches or buttons. Implement an UART receiver, command parser, timekeeping circuit, alarm registers, and status transmitter. The system must provide at least one programmable alarm, with an LED or PWM audio alarm indicator.

## Minimum Implementation Requirements

1. HH:MM:SS timekeeping with correct rollover and selectable 12/24-hour display.
2. Multiplexed seven-segment display of the current time (and AM/PM status where applicable).
3. UART RX/TX communication with a PC terminal (e.g., PuTTY), using a documented baud rate and command format.
4. **Set current time via UART.**
5. **Set alarm time, enable/disable the alarm, and view alarm status via UART.**
6. Notify the user when the alarm is triggered using an LED or PWM audio output; provide a way to stop the alarm.
7. Return acknowledgements or error messages for valid and invalid UART commands.
8. Simulate and demonstrate the UART command interface, timekeeping logic, and alarm operation on the FPGA.

## Example UART Commands

The following human-readable command format is suggested; an equivalent documented protocol is acceptable.

| Command | Operation |
| --- | --- |
| `TIME 14:35:00` | Set current time to 14:35:00 |
| `ALARM 06:30` | Configure the alarm time |
| `ALARM ON` | Enable the alarm |
| `ALARM OFF` | Disable the alarm |
| `ALARM STOP` | Stop an active alarm |
| `FORMAT 12` | Select 12-hour display mode |
| `FORMAT 24` | Select 24-hour display mode |
| `STATUS` | Report current time, format, alarm time, and alarm state |

All commands should be terminated by Enter (CR, LF, or CRLF, as documented). Invalid times and unsupported commands must be rejected without modifying existing settings.

## Suggested HDL Modules

- Clock-enable generator and timekeeping counters
- Seven-segment display controller
- UART receiver and transmitter
- UART command buffer and parser FSM
- Time and alarm configuration registers
- 12/24-hour format converter
- Alarm comparator and alarm control FSM
- LED indicator or PWM audio generator

## Optional Extensions

- UART command to configure alarm sound duration or snooze time.
- Automatic periodic status messages to the terminal.
- Multiple alarms or weekday scheduling.
- VGA output or stopwatch function.

## Reference Projects

- [Course Lab 08 — UART TX, RX, Echo](../../Lab08/)
- [Course Lab 09 — PWM Audio](../../Lab09/L9.4_PWM_Audio/)
- [Verilog Digital Clock — Nexys4DDR](https://github.com/nnyilun/VerilogDigitalClock)
- [FPGA Digital Alarm Clock with Stopwatch and UART](https://github.com/ft-rohan/fpga-digital-alarm-clock-verilog)
- [Digilent Nexys 4 DDR Out-of-Box Demo](https://github.com/Digilent/Nexys-4-DDR-OOB)
- [Earlier course projects](https://irh.inf.unideb.hu/~onigai/LDuHDL/2023/)

## Verification and Demonstration

Demonstrate UART configuration of both **current time and alarm settings**, correct rollover and 12/24-hour conversion, alarm triggering/stopping, and rejection of invalid UART commands. Submit the HDL source, testbenches, block diagram, Vivado resource utilization report, and brief technical explanation.

The time is not retained across power loss without additional hardware.

See the [general project guidelines](../../README.md#general-project-guidelines) and [evaluation criteria](../../README.md#evaluation-criteria).
