# L9.3 - Knight Rider LED Light

Eight PWM instances drive LED0-LED7 with changing duty values.

- **BTNC**: reset
- **SW0=0**: run the Knight Rider animation
- **SW0=1**: hold/pause current brightness values
- **SW1=1**: fast fading
- **SW1=0**: slow fading

The SW0 pause is made deterministic by tying the legacy undriven `inc` and
`dec` signals low. Only the two fade-delay constants are changed so the SW1 effect is clearly visible. The Knight Rider movement timing and PWM logic are unchanged.

Create the project with:

```tcl
source {C:/Labs/Logic_design_using_HDL/Lab09/L9.3_Knight_Rider/create_project.tcl}
```

Generate the bitstream in the GUI or with `build_bitstream.tcl`, program the
board, set SW0 low, and press/release BTNC.


The selected fade times are deliberately well separated: approximately **20 ms** for SW1=1 and **115 ms** for SW1=0, so the difference is easy to observe on the board.
