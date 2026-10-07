# L4.1: Verilog ROM

The ROM has eight 8-bit words. The initialization constant stores these bytes
at addresses 0 through 7:

    00 C8 F9 AF 64 95 6C D4

Run create_project.tcl in Vivado 2022.2. The script sets
rom8x8_board_top as the synthesis top and tb_rom8x8 as the simulation top.
Simulation checks every address. After programming the board, SW[2:0] selects
the address and LED[7:0] shows the byte. At address 6, the LEDs show 6C in hex.

Record the synthesized LUT, distributed RAM/ROM, register, and BRAM counts.
The HDL describes a ROM; the synthesis report shows how Vivado implemented it.
