# Project 14 — FPGA-Based Digital Piano with Recording and Playback

[← Back to the project list](README.md)

**Platform:** Digilent Nexys 4 DDR / Nexys A7-100T  
**Language:** VHDL or Verilog  
**Duration:** 4–5 weeks  
**Maximum grade:** 5/5

## Project Description

Develop a digital piano that can record the sequence of notes played by the user and reproduce the recorded performance on demand. The design must include a tone generator, key-event detection, a recording controller, event storage using FPGA block RAM, and a playback controller. Each recorded event should store the note identity and its timing information, including note duration and silent intervals, so the rhythm of the recorded melody is preserved. The recorded tune is played through the onboard PWM audio output. The student may adapt the implementation of the simpler digital piano but must explain the additional memory and control architecture.

## Minimum Implementation Requirements

- All essential functions of the basic digital piano, including at least eight notes.
- Record a sequence of at least 64 key events using BRAM.
- Preserve note durations and rests during recording and playback.
- Implement record, stop, play, and clear operations using board controls.
- Indicate recording and playback state using LEDs or seven-segment output.
- Verify memory addressing, recording FSM, and playback timing in simulation.
- Demonstrate repeated playback of an original recorded melody on the FPGA.

## Optional Extensions

- Multi-note/chord event recording.
- Tempo-adjustable playback, looping, and pause/resume.
- UART export and import of melodies.
- VGA piano interface or note timeline.

## Suggested HDL Modules

Key-event decoder, tone generator, PWM audio output, recording FSM, BRAM event buffer, timing counter, playback FSM, status display.

## References and Source Projects

- [Course Lab 09 — PWM Audio](../Lab09/L9.4_PWM_Audio/)
- [Course Lab 04 — FPGA Memories](../Lab04/)
- [Digilent Nexys 4 DDR GPIO Demo](https://github.com/Digilent/Nexys-4-DDR-GPIO)
- [Digilent Nexys 4 DDR Out-of-Box Demo](https://github.com/Digilent/Nexys-4-DDR-OOB)

## Technical Notes

The Nexys 4 DDR PWM audio output can be used for audible tone generation. Timebase accuracy and audio output levels should be checked on the physical board.

See the [general project guidelines](../README.md#general-project-guidelines) and [evaluation criteria](../README.md#evaluation-criteria).
