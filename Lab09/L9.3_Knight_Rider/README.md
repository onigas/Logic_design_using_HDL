# L9.3 - Knight Rider LED Light

Eight PWM instances drive LED0-LED7 with changing duty values.

- **BTNC**: reset
- **SW0=0**: run the Knight Rider animation
- **SW0=1**: hold/pause current brightness values
- **SW1**: select the original alternate fade timing behavior

The SW0 pause is made deterministic by tying the legacy undriven `inc` and
`dec` signals low. No other animation timing or PWM logic is changed.

Create the project with:

```tcl
source {C:/Labs/Logic_design_using_HDL/Lab09/L9.3_Knight_Rider/create_project.tcl}
```

Generate the bitstream in the GUI or with `build_bitstream.tcl`, program the
board, set SW0 low, and press/release BTNC.
