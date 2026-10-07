`default_nettype none
module alu4_top(input wire CLK100MHZ, input wire [7:0] SW,
                input wire [2:0] F,
                output wire [6:0] SEG, output wire [7:0] AN,
                output wire DP);
    wire [7:0] result;
    alu_top u_alu(.a(SW[3:0]), .b(SW[7:4]),
                  .f(F), .r(result));
    hex7seg8 u_display(.clk(CLK100MHZ), .data(result),
                       .seg(SEG), .an(AN), .dp(DP));
endmodule
`default_nettype wire
