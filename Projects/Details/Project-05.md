# Project 05 — Traffic Intersection with Pedestrian Crossings and VGA Monitoring

[← Back to the project list](../README.md)

**Platform:** Nexys 4 DDR / Nexys A7-100T  
**Language:** VHDL or Verilog  
**Duration:** 4–5 weeks  
**Maximum grade:** To be determined

## Project Description

Design an FPGA-based traffic light controller for a road intersection with two vehicle directions (North–South and East–West) and pedestrian crossings. Extend the finite-state-machine traffic light controller studied in the [UA Laboratory 6 (2024)](https://irh.inf.unideb.hu/~onigai/UA/2024/L6.pdf) with pedestrian request handling and a graphical monitoring interface. The VGA monitor must show a schematic of the intersection, the current red/yellow/green signal for each vehicle direction, pedestrian red/green signals, and the remaining time until the next signal change. Students may reuse the laboratory FSM as a starting point, but must implement and explain the new pedestrian logic, countdown timing, and VGA visualization.

## Minimum Implementation Requirements

1. Control two mutually exclusive vehicle directions with safe red/yellow/green sequences and all-red transition intervals.
2. Provide pedestrian crossing requests using onboard push buttons; synchronize and debounce the inputs, and retain pending requests until served.
3. Allow pedestrian green only when the conflicting vehicle movements are stopped; provide a defined pedestrian clearance interval before returning to conflicting vehicle green.
4. Display a schematic intersection on VGA with the **actual vehicle and pedestrian signal colors** and **remaining countdown time** for the active phases.
5. Update the displayed colors and countdown synchronously with the traffic controller; prevent visual indications that contradict the traffic signals.
6. Implement a documented initialization/reset state and demonstrate both directions, pedestrian requests, transitions, and countdown rollover.
7. Verify control logic and VGA status integration through simulation and demonstrate the complete system on the FPGA.

## Suggested HDL Architecture

- Traffic-light FSM and phase timer with 1 Hz clock-enable pulse.
- Pedestrian request synchronizers, debouncers, and pending-request registers.
- Pedestrian phase/clearance controller, optionally integrated into the main FSM.
- Countdown and time-formatting logic.
- VGA synchronization and intersection graphics renderer, including traffic light indicators and numeric countdown drawing from a font ROM.
- Top-level integration and status signals shared between the FSM and the display.

## Suggested VGA Interface

The display should include two labeled vehicle directions (North–South and East–West), crossing indicators for pedestrians, colored traffic signals, and a numeric remaining-time indicator for each relevant active phase. Reuse the **1024 × 768 @ 60 Hz** timing/controller infrastructure from the course VGA laboratories if available.

## Optional Extensions

- Separate pedestrian countdown for each crossing.
- Configurable vehicle and pedestrian phase durations.
- Audible pedestrian crossing signal using PWM.
- Night mode or emergency priority with proper safety handling.

## References and Source Projects

- [UA Laboratory 6 (2024) — FSM and traffic-light controller](https://irh.inf.unideb.hu/~onigai/UA/2024/L6.pdf)
- [Course Lab 06 — VGA controller](../../Lab06/)
- [Course Lab 07 — VGA sprites and animation](../../Lab07/)
- [Digilent Nexys 4 DDR resources](https://github.com/Digilent/Nexys4DDR)
- [HDLBits — finite state machine exercises](https://hdlbits.01xz.net/wiki/Main_Page)

## Verification and Deliverables

Submit HDL files, top-level constraints, block diagram, testbenches with traffic/pedestrian request scenarios, screenshots or photographs of the VGA output, and a Vivado utilization/timing report. Explain the distinction between reused laboratory modules and the newly developed logic.

See the [general guidelines](../README.md#general-project-guidelines), [recommended schedule](../README.md#recommended-project-schedule), and [evaluation criteria](../README.md#evaluation-criteria).
