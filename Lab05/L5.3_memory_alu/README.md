# L5.3: Individual task, ROM plus ALU

This project demonstrates a complete solution to the individual exercise.
The same 16 x 4 ROM is read twice using separate addresses. SW0..3 select
the first address; SW4..7 select the second. The two ROM data outputs feed
the add4 arithmetic unit. Two hexadecimal seven-segment digits show the
eight-bit sum. No ALU function switches are needed for this exercise.

The ROM is initialized at addresses 0..15 with:

    3 A 1 C 5 E 7 8 0 2 4 6 9 B D F

Examples: addresses 0 and 1 read 3 and A, so the result is 0D;
addresses 5 and 7 read E and 8, so the result is 16.

Run create_project.tcl from Vivado 2022.2. The synthesis top is
memory_alu_top. The testbench tb_memory_alu checks all 256 address pairs.
To personalize the design, change INIT in rom16x4.v while retaining
16 four-bit words; update the testbench's rom_value table accordingly.
Record the inferred ROM resources, the display result for two selected
address pairs, and the latency you observe after moving a switch.
