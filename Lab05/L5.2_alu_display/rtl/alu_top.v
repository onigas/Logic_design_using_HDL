`default_nettype none
module alu_top(input wire [3:0] a, b, input wire [2:0] f,
               output wire [7:0] r);
    wire [3:0] add_operand, sub_operand;
    wire [7:0] add_out, sub_out, mul_out;

    mux2_4 u_add_mux(.i0(b), .i1(4'd1), .sel(f[0]), .out(add_operand));
    mux2_4 u_sub_mux(.i0(b), .i1(4'd1), .sel(f[0]), .out(sub_operand));
    add4 u_add(.i0(a), .i1(add_operand), .sum(add_out));
    sub4 u_sub(.i0(a), .i1(sub_operand), .diff(sub_out));
    mul4 u_mul(.i0(a), .i1(b), .prod(mul_out));
    mux3_8 u_result(.i0(add_out), .i1(sub_out), .i2(mul_out),
                    .sel(f[2:1]), .out(r));
endmodule
`default_nettype wire
