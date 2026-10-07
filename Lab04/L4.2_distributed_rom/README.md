# L4.2: Distributed ROM

The project script creates a Vivado Distributed Memory Generator instance named
dist_rom16. Its ROM is 16 x 8, initialized by data/dist_rom16.coe. The
unregistered spo output reads asynchronously; the generated instance has
a[3:0] and spo[7:0] and no clock port.

Run create_project.tcl in Vivado 2022.2. The script configures and generates
the IP, selects dist_rom_board_top for synthesis, and selects tb_dist_rom16 for
behavioral simulation. The testbench checks all 16 initialized bytes.

On the board, SW[3:0] is the address and LED[7:0] is the stored byte. Example
checks: SW = 0 displays 00, SW = 6 displays 6C, SW = 15 displays 4C.

To test personalized data, load the new 16 x 8 COE in the IP customization,
regenerate its output products, and update the expected() function in the
testbench. Check the synthesis utilization and inspect the distributed ROM
resources. Generated IP files are written by Vivado in vivado_project/.
