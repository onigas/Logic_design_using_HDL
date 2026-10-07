`timescale 1ns / 1ps

module top_module(
    input clk,
    input rst,
    input [7:0] SW,
    input sw_dir1,
    input sw_dir2,
    output en1,
    output en2,
    output dir1,
    output dir2
    );

    assign dir1 = sw_dir1;
    assign dir2 = sw_dir2;

    pwm_dcmotor U1(.clk(clk), .rst(rst), .SW(SW), .en1(en1), .en2(en2));

endmodule
