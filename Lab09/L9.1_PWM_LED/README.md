# L9.1 - PWM LED Brightness

This exercise generates a **1 kHz PWM** signal from the 100 MHz board clock.
`SW[7:0]` sets the duty threshold and the PWM signal drives **LED0**.

Run:

```tcl
source {C:/Labs/Logic_design_using_HDL/Lab09/L9.1_PWM_LED/create_project.tcl}
```

Generate a bitstream in the GUI, or run `build_bitstream.tcl`. Program the
board, press/release **BTNC**, then change SW0-SW7 and observe LED0.

Useful checks: `SW=0` turns LED0 off; `SW=97` gives approximately 49.66%
duty. High switch values eventually saturate at 100% because the original
implementation compares `count[16:9]` directly with the eight-bit switch
value.

## Behavioral simulation

The project includes `sim/pwmsim.sv` (simulation top: `pwmsim`). Run
**Flow Navigator -> Simulation -> Run Simulation -> Run Behavioral Simulation**,
or use:

```tcl
source {C:/Labs/Logic_design_using_HDL/Lab09/L9.1_PWM_LED/run_simulation.tcl}
```

The testbench uses the real 100 MHz clock and 1 ms PWM period. It starts with
the original `SW=97` setting, then checks zero duty and the full-duty boundary.
The simulation finishes after approximately 5 ms and reports
`PASS: L9.1 PWM simulation completed` in the simulator console. Inspect
`clk`, `rst`, `duty`, `led`, and `U1/count` in the waveform window.

| SW value (decimal) | High clocks per 100000-clock period | Duty cycle |
| --- | --- | --- |
| 97 | 49664 | 49.664% |
| 0 | 0 | 0% |
| 195 | 99840 | 99.840% |
| 196 | 100000 | 100% |
| 255 | 100000 | 100% |

These values follow the original `count[16:9] < SW` comparison. The duty value
is a threshold, rather than a percentage or a value scaled over 0-255.
