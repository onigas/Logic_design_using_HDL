`timescale 1ns / 1ps
module vga_1024x768(input wire clk,input wire clr,output reg hsync,output reg vsync,output reg [10:0] hc,output reg [10:0] vc,output wire vidon);
localparam H_SYNC=136,H_BP=160,H_DISP=1024,H_TOTAL=1344,V_SYNC=6,V_BP=29,V_DISP=768,V_TOTAL=806;
localparam H_ACTIVE_START=H_SYNC+H_BP,H_ACTIVE_END=H_SYNC+H_BP+H_DISP,V_ACTIVE_START=V_SYNC+V_BP,V_ACTIVE_END=V_SYNC+V_BP+V_DISP;
always @(posedge clk or posedge clr) begin if(clr) begin hc<=0;vc<=0;end else if(hc==H_TOTAL-1) begin hc<=0;if(vc==V_TOTAL-1)vc<=0;else vc<=vc+1'b1;end else hc<=hc+1'b1;end
always @(*) begin hsync=(hc<H_SYNC)?0:1;vsync=(vc<V_SYNC)?0:1;end
assign vidon=(hc>=H_ACTIVE_START)&&(hc<H_ACTIVE_END)&&(vc>=V_ACTIVE_START)&&(vc<V_ACTIVE_END); endmodule
