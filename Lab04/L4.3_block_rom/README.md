# L4.3: Block ROM and seven-segment display

The project script creates a native, single-port Block Memory Generator ROM
named block_rom8x16. Its eight 16-bit words come from
data/block_rom8x16.coe: 0000, 1111, ..., 7777.

The script disables both optional Port A output registers and selects
Always Enabled, so the generated interface used here is clka, addra[2:0],
and douta[15:0]. Check Total Port A Read Latency on the IP Summary tab.
The provided testbench checks the one-cycle configuration: it sets the address
at a falling edge and checks the output just after the next rising edge.

Run create_project.tcl in Vivado 2022.2. The synthesis top is
block_rom_board_top; the default simulation top is tb_block_rom8x16.
For an additional fast display test, set tb_sevenseg_hex as simulation top
and run behavioral simulation again.

On the board, SW[2:0] selects a 16-bit word shown as four hexadecimal
digits. The four unused digit anodes remain disabled. The display logic
uses CLK100MHZ as its only clock and a counter enable for digit scanning.
Its default scan rate selects a new digit every 250 us, giving each
digit a 1 kHz refresh rate.

To test personalized data, load a new 8 x 16 COE into the IP, regenerate
output products, and update expected() in the ROM testbench. Record
BRAM and LUT usage from Report Utilization.
