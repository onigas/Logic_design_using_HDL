`timescale 1ns/1ps
`default_nettype none
module tb_alu4_top;
    reg clk = 1'b0;
    reg [7:0] sw = 8'h00;
    reg [2:0] f = 3'b000;
    wire [6:0] seg;
    wire [7:0] an;
    wire dp;
    always #5 clk = ~clk;
    alu4_top dut(.CLK100MHZ(clk), .SW(sw), .F(f),
                 .SEG(seg), .AN(an), .DP(dp));

    initial begin
        sw[3:0] = 4'd10;
        sw[7:4] = 4'd12;
        f = 3'b010;
        #1;
        if (dut.result !== 8'hFE) $fatal(1, "Expected FE");
        if (an !== 8'hFE || seg !== 7'b0000110 || dp !== 1'b1)
            $fatal(1, "Expected low digit E at AN0");
        $display("L5.2 TOP TEST PASSED: a=10, b=12, subtraction=FE");
        $finish;
    end
endmodule
`default_nettype wire
