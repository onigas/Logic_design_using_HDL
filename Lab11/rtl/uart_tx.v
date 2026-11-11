`timescale 1ns/1ps
module uart_tx #(parameter BIT_CLOCKS=868)(
    input clk, rst, start, input [7:0] data,
    output tx, output busy
);
    reg [9:0] shift;
    reg [3:0] remaining;
    reg [15:0] timer;
    assign busy = remaining != 0;
    assign tx = shift[0];
    always @(posedge clk) begin
        if (rst) begin
            shift <= 10'h3ff;
            remaining <= 0;
            timer <= 0;
        end else if (!busy && start) begin
            shift <= {1'b1,data,1'b0};
            remaining <= 10;
            timer <= BIT_CLOCKS-1;
        end else if (busy && timer == 0) begin
            shift <= {1'b1,shift[9:1]};
            remaining <= remaining-1'b1;
            timer <= BIT_CLOCKS-1;
        end else if (busy) timer <= timer-1'b1;
    end
endmodule
