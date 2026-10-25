# Project 13 — FPGA-Based Digital Piano

[← Back to the project list](README.md)

**Platform:** Digilent Nexys 4 DDR / Nexys A7-100T  
**Language:** VHDL or Verilog  
**Duration:** 4–5 weeks  
**Maximum grade:** 4/5

## Project Description

Design a playable digital piano using VHDL or Verilog on the Nexys 4 DDR board. The piano must produce distinct musical notes when the user presses the assigned buttons or keys. Sound is generated through programmable tone counters or a direct digital synthesis module and reproduced using the onboard PWM audio output. The system should display the current note and support a selectable octave or a simple melody mode. A connected external keypad or USB keyboard may be used only if the required interface is available and documented; the default implementation uses onboard controls.

## Minimum Implementation Requirements

- Generate at least eight distinct notes with appropriate frequencies.
- Select notes using onboard buttons and/or switches.
- Produce sound using the onboard PWM audio output.
- Display the active note or its index using LEDs or the seven-segment display.
- Implement clean key transitions and silence when no key is pressed.
- Simulate tone timing and demonstrate the circuit on the FPGA.

## Optional Extensions

- Polyphonic generation of at least two simultaneous notes.
- Adjustable octave, instrument tone, or volume.
- External keyboard input with a dedicated interface.

## Suggested HDL Modules

Note decoder, button synchronizer/debouncer, tone/NCO generator, PWM audio output, note display controller.

## References and Source Projects

- [Course Lab 09 — PWM Audio](../Lab09/L9.4_PWM_Audio/)
- [Digilent Nexys 4 DDR GPIO Demo](https://github.com/Digilent/Nexys-4-DDR-GPIO)
- [Digilent Nexys 4 DDR Out-of-Box Demo](https://github.com/Digilent/Nexys-4-DDR-OOB)

## Technical Notes

The Nexys 4 DDR PWM audio output can be used for audible tone generation. Timebase accuracy and audio output levels should be checked on the physical board.

See the [general project guidelines](../README.md#general-project-guidelines) and [evaluation criteria](../README.md#evaluation-criteria).
