`timescale 1ns / 1ps
module vga_1024x768(input wire clk,input wire clr,output reg hsync,output reg vsync,output reg [10:0] hc,output reg [10:0] vc,output reg vidon);
localparam [10:0] H_TOTAL=1344,H_SYNC=136,H_ACTIVE_START=296,H_ACTIVE_END=1320,V_TOTAL=806,V_SYNC=6,V_ACTIVE_START=35,V_ACTIVE_END=803;
reg vsenable;
always @(posedge clk or posedge clr) begin if(clr) begin hc<=0;vsenable<=0;end else if(hc==H_TOTAL-1) begin hc<=0;vsenable<=1;end else begin hc<=hc+1;vsenable<=0;end end
always @(*) hsync=(hc<H_SYNC)?0:1;
always @(posedge clk or posedge clr) begin if(clr) vc<=0; else if(vsenable) begin if(vc==V_TOTAL-1) vc<=0; else vc<=vc+1; end end
always @(*) vsync=(vc<V_SYNC)?0:1;
always @(*) vidon=(hc>=H_ACTIVE_START)&&(hc<H_ACTIVE_END)&&(vc>=V_ACTIVE_START)&&(vc<V_ACTIVE_END);
endmodule
