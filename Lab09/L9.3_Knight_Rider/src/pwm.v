`timescale 1ns / 1ps

module pwm(
    input clk,
    input rst,
    input [7:0] duty,
    output reg led
    );

    reg [16:0] count = 0;
    reg [16:0] period = 17'd99999;

    always @(posedge clk or posedge rst)
        if (rst == 1)
            count <= 0;
        else if (count < period)
            count <= count + 1;
        else
            count <= 0;

    always @(*)
        if (count[16:9] < duty)
            led <= 1;
        else
            led <= 0;

endmodule
