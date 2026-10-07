`default_nettype none
module memory_alu_top(input wire CLK100MHZ, input wire [7:0] SW,
                      output wire [6:0] SEG, output wire [7:0] AN,
                      output wire DP);
    wire [3:0] stored_a, stored_b;
    wire [7:0] sum;
    rom16x4 u_rom_a(.addr(SW[3:0]), .data(stored_a));
    rom16x4 u_rom_b(.addr(SW[7:4]), .data(stored_b));
    add4 u_add(.i0(stored_a), .i1(stored_b), .sum(sum));
    hex7seg8 u_display(.clk(CLK100MHZ), .data(sum), .seg(SEG), .an(AN), .dp(DP));
endmodule
`default_nettype wire
