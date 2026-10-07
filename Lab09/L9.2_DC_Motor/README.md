# L9.2 - DC Motor Control with Pmod DHB1

- **SW0-SW7**: common PWM duty / motor speed
- **SW15**: motor 1 direction
- **SW14**: motor 2 direction
- **BTNC**: reset
- **Pmod JA**: JA1=EN1, JA2=DIR1, JA7=EN2, JA8=DIR2

Connect the motor supply to the DHB1 **J4 (VM/GND)** motor-voltage connector.

Before changing direction, set **SW0-SW7 all OFF**, change SW15/SW14, then
restore the desired speed. This keeps EN low while DIR changes.

Create the project with:

```tcl
source {C:/Labs/Logic_design_using_HDL/Lab09/L9.2_DC_Motor/create_project.tcl}
```

Generate the bitstream in the GUI or with `build_bitstream.tcl`, program the
board, press/release BTNC, and begin testing with a low duty setting.
