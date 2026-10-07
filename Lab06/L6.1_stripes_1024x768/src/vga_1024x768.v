`timescale 1ns / 1ps
module vga_1024x768 (
    input wire clk, input wire clr,
    output reg hsync, output reg vsync,
    output reg [10:0] hc, output reg [10:0] vc,
    output reg vidon
);
localparam [10:0] H_TOTAL=11'd1344, H_SYNC=11'd136, H_ACTIVE_START=11'd296, H_ACTIVE_END=11'd1320;
localparam [10:0] V_TOTAL=11'd806, V_SYNC=11'd6, V_ACTIVE_START=11'd35, V_ACTIVE_END=11'd803;
reg vsenable;
always @(posedge clk or posedge clr) begin
 if (clr) begin hc<=0; vsenable<=0; end
 else if (hc==H_TOTAL-1'b1) begin hc<=0; vsenable<=1; end
 else begin hc<=hc+1'b1; vsenable<=0; end
end
always @(*) hsync=(hc<H_SYNC)?1'b0:1'b1;
always @(posedge clk or posedge clr) begin
 if (clr) vc<=0;
 else if (vsenable) begin if (vc==V_TOTAL-1'b1) vc<=0; else vc<=vc+1'b1; end
end
always @(*) vsync=(vc<V_SYNC)?1'b0:1'b1;
always @(*) vidon=(hc>=H_ACTIVE_START)&&(hc<H_ACTIVE_END)&&(vc>=V_ACTIVE_START)&&(vc<V_ACTIVE_END);
endmodule
