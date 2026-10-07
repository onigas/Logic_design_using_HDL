`timescale 1ns / 1ps

module pwm_dcmotor(
    input clk,
    input rst,
    input [7:0] SW,
    output reg en1,
    output reg en2
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
        if (count[16:9] < SW) begin
            en1 <= 1;
            en2 <= 1;
        end else begin
            en1 <= 0;
            en2 <= 0;
        end

endmodule
