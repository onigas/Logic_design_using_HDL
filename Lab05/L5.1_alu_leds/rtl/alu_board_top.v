`default_nettype none
module alu_board_top(input wire [7:0] SW, input wire [2:0] F,
                     output wire [7:0] LED);
    // XDC maps F[0:2] to physical switches SW13:SW15.
    alu_top u_alu(.a(SW[3:0]), .b(SW[7:4]), .f(F), .r(LED));
endmodule
`default_nettype wire
