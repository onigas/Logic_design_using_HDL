`timescale 1ns / 1ps
module vga_1024x768(input wire clk,input wire clr,output reg hsync,output reg vsync,output reg [10:0] hc,output reg [10:0] vc,output wire vidon);
localparam H_SYNC=11'd136,H_BP=11'd160,H_DISP=11'd1024,H_FP=11'd24,H_TOTAL=11'd1344;
localparam V_SYNC=11'd6,V_BP=11'd29,V_DISP=11'd768,V_FP=11'd3,V_TOTAL=11'd806;
localparam H_ACTIVE_START=H_SYNC+H_BP,H_ACTIVE_END=H_SYNC+H_BP+H_DISP,V_ACTIVE_START=V_SYNC+V_BP,V_ACTIVE_END=V_SYNC+V_BP+V_DISP;
always @(posedge clk or posedge clr) begin
 if(clr) begin hc<=0;vc<=0;end else begin
  if(hc==H_TOTAL-1) begin hc<=0; if(vc==V_TOTAL-1) vc<=0; else vc<=vc+1'b1; end
  else hc<=hc+1'b1;
 end
end
always @(*) begin hsync=(hc<H_SYNC)?1'b0:1'b1; vsync=(vc<V_SYNC)?1'b0:1'b1; end
assign vidon=(hc>=H_ACTIVE_START)&&(hc<H_ACTIVE_END)&&(vc>=V_ACTIVE_START)&&(vc<V_ACTIVE_END);
endmodule
