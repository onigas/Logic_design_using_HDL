`timescale 1ns/1ps
`default_nettype none
module tb_hex7seg8;
    reg clk = 1'b0;
    reg [7:0] data = 8'hFE;
    wire [6:0] seg;
    wire [7:0] an;
    wire dp;
    always #5 clk = ~clk;
    hex7seg8 #(.SCAN_DIVISOR(4)) dut(.clk(clk), .data(data), .seg(seg), .an(an), .dp(dp));
    initial begin
        #1;
        if (an !== 8'hFE || seg !== 7'b0000110 || dp !== 1'b1) $fatal(1, "Expected E at AN0");
        repeat (4) @(posedge clk); #1;
        if (an !== 8'hFD || seg !== 7'b0001110 || dp !== 1'b1) $fatal(1, "Expected F at AN1");
        $display("L5.2 DISPLAY TEST PASSED: FE");
        $finish;
    end
endmodule
`default_nettype wire
