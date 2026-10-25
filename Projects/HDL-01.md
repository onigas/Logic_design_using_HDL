# HDL-01 — Digital Clock and Alarm System

[← Back to the project list](README.md)

**Platform:** Nexys 4 DDR / Nexys A7-100T  
**Language:** VHDL or Verilog  
**Duration:** 4–5 weeks

## Project description

Design an FPGA-based digital clock that maintains hours, minutes, and seconds, supports selectable **12-hour (AM/PM)** and **24-hour** formats, and allows the user to set the time using switches and/or buttons. Depending on the selected variant, the system may offer programmable alarms, a seven-segment display, UART terminal output, and VGA graphics.

## Variants and maximum grades

| Variant | Maximum grade | Requirements |
| --- | --- | --- |
| A — Basic Digital Clock | **3/5** | HH:MM:SS timekeeping, selectable 12/24-hour format, push-button/switch time setting, seven-segment output, rollover verification |
| B — Digital Alarm Clock with UART | **4/5** | Variant A plus one configurable alarm, enable/disable and stop control, alarm indicator or PWM sound, and UART time/status output |
| C — Advanced Alarm Clock with VGA | **5/5** | Core functions of A and B plus VGA display, date and weekday tracking, at least three programmable alarms with weekday scheduling, and audible alarm |

**Optional extensions:** snooze, stopwatch, UART command input, analog-style VGA clock, calendar, external RTC.

## Suggested HDL modules

Clock-enable generator, timekeeping counters, 12/24-hour formatter, button synchronizer/debouncer, setting FSM, alarm control, seven-segment driver, UART interface, VGA controller, PWM audio generator.

## Reference projects

- [Verilog Digital Clock — Nexys4DDR](https://github.com/nnyilun/VerilogDigitalClock)
- [FPGA Digital Alarm Clock with Stopwatch and UART](https://github.com/ft-rohan/fpga-digital-alarm-clock-verilog)
- [FPGA Digital Clock with Alarm — Basys 3](https://github.com/KashaanAhamad/FPGA-Digital-Clock)
- [Digilent Nexys 4 DDR Out-of-Box Demo](https://github.com/Digilent/Nexys-4-DDR-OOB)
- [Earlier course projects](https://irh.inf.unideb.hu/~onigai/LDuHDL/2023/)

## Verification and demonstration

Demonstrate clock rollover, correct 12/24-hour conversion, time setting, alarm matching, and the output interfaces required by the chosen variant. Present the architecture, simulation results, and resource utilization.

> **Note:** Time is not retained after power loss unless an external RTC or synchronization source is added.

See the [general guidelines](../README.md#general-project-guidelines) and [evaluation criteria](../README.md#evaluation-criteria).
