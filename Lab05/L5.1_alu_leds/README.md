# L5.1: ALU on eight LEDs

Run create_project.tcl from Vivado 2022.2. The synthesis top is
alu_board_top; the simulation top is tb_alu_top. The testbench covers all
16 x 16 operand pairs and all eight function codes (2,048 checks).

Set A with SW0..3, B with SW4..7 and F2 F1 F0 with SW15 SW14 SW13.
LED0..7 show the result as an eight-bit pattern. Try A=3, B=2, then
A=10, B=12. For subtraction A=10, B=12, the LEDs show FE.

The output selector uses F2 F1. F0 chooses B or 1 for addition and
subtraction. Both 100 and 101 mean A x B. Values 110 and 111 return 00.
Record the result for the five function settings in the assignment and
explain the representation of a negative result.
