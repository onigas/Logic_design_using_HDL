# L5.2: ALU result on seven-segment digits

Run create_project.tcl from Vivado 2022.2. The synthesis top is alu4_top.
The default simulation top tb_alu4_top checks A=10, B=12 and F=010;
change the simulation top to tb_hex7seg8 for a separate scanning test.
tb_alu_top is also included for complete ALU coverage.

SW0..3 select A, SW4..7 select B, physical SW13..15 select F0..F2.
The two rightmost digits (AN0 and AN1) show the eight-bit result in hex.
The six other digits and decimal point are off. The display driver uses
the 100 MHz clock and a counter enable, not a separate generated clock.

For A=3 and B=2, the displayed values for F=000,001,010,011,100 are
05, 04, 01, 02 and 06. For A=10, B=12 and F=010, FE is the expected
eight-bit bit pattern for -2, so the display reads FE.
