`timescale 1ns / 1ps
module bounce(input wire clk,input wire clr,input wire go,input wire frame_tick,output reg [10:0] c1,output reg [10:0] r1);
parameter [10:0] C1max=11'd784,R1max=11'd608,STEP=11'd2; reg running,dir_x,dir_y;
always @(posedge clk or posedge clr) begin
 if(clr) begin c1<=80;r1<=140;dir_x<=1;dir_y<=0;running<=0;end else begin
  if(go) running<=1;
  if(frame_tick&&(running||go)) begin
   if(dir_x) begin if(c1>=C1max-STEP) begin c1<=C1max;dir_x<=0;end else c1<=c1+STEP; end
   else begin if(c1<=STEP) begin c1<=0;dir_x<=1;end else c1<=c1-STEP; end
   if(dir_y) begin if(r1>=R1max-STEP) begin r1<=R1max;dir_y<=0;end else r1<=r1+STEP; end
   else begin if(r1<=STEP) begin r1<=0;dir_y<=1;end else r1<=r1-STEP; end
  end
 end
end
endmodule
