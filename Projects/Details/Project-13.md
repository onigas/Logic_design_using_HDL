# Project 13 — PWM Audio Signal Processor

[← Back to the project list](../README.md)

**Platform:** Nexys 4 DDR / Nexys A7-100T  
**Language:** VHDL or Verilog  
**Duration:** 4–5 weeks  
**Maximum grade:** **4/5**

## Project Description

Implement a digital audio waveform generator and simple audio processing system on the Nexys 4 DDR. Sine-wave lookup tables or numerically controlled oscillators produce sampled signals, which are converted into an audio PWM waveform through the onboard audio output. Students should verify frequency generation, sample rate, amplitude and PWM behavior; a more ambitious version can process data from the onboard PDM microphone.

## Minimum Implementation Requirements

- Generate at least two selectable audio waveforms or musical tones.
- Implement programmable frequency and amplitude control.
- Produce sound on the Nexys 4 DDR PWM audio output.
- Verify sampling and PWM timing in simulation.

## Optional Extensions

- Multiple simultaneous tones and mixing
- Echo, distortion, or FIR filtering
- PDM microphone capture and processing

## References and Source Projects

- [Course Lab 09 PWM Audio](../../Lab09/L9.4_PWM_Audio/)
- [Digilent Nexys4 DDR GPIO demo](https://github.com/Digilent/Nexys-4-DDR-GPIO)
- [Digilent Out-of-Box audio demonstration](https://github.com/Digilent/Nexys-4-DDR-OOB)

## Deliverables

HDL source code, relevant constraints and testbench files, architectural block diagram, simulation evidence, working FPGA demonstration, resource utilization report, and a brief technical explanation of any reused reference design.

See the [general project guidelines](../../README.md#general-project-guidelines), [recommended schedule](../../README.md#recommended-project-schedule), and [evaluation criteria](../../README.md#evaluation-criteria).
