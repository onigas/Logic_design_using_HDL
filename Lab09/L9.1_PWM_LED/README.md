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
