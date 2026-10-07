`timescale 1ns/1ps
`default_nettype none
module tb_sevenseg_hex;
    logic clk = 1'b0;
    logic [15:0] data = 16'h1234;
    wire [6:0] seg;
    wire [7:0] an;
    wire dp;

    always #5 clk = ~clk;

    sevenseg_hex #(.SCAN_DIVISOR(4)) dut (.clk(clk), .data(data), .seg(seg), .an(an), .dp(dp));

    task automatic check_digit(input logic [7:0] want_an, input logic [6:0] want_seg);
        if (an !== want_an || seg !== want_seg || dp !== 1'b1)
            $fatal(1, "Display: an=%02h seg=%02h dp=%b; expected %02h %02h 1", an, seg, dp, want_an, want_seg);
    endtask

    initial begin
        #1;
        check_digit(8'hFE, 7'b0011001);
        repeat (4) @(posedge clk);
        #1;
        check_digit(8'hFD, 7'b0110000);
        repeat (4) @(posedge clk);
        #1;
        check_digit(8'hFB, 7'b0100100);
        repeat (4) @(posedge clk);
        #1;
        check_digit(8'hF7, 7'b1111001);
        $display("L4.3 DISPLAY TEST PASSED: four hex digits");
        $finish;
    end
endmodule
`default_nettype wire
