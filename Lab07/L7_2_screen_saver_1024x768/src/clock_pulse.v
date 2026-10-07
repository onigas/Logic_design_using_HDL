`timescale 1ns / 1ps
module clock_pulse(input wire inp,input wire clk,input wire clr,output reg outp);
parameter integer DEBOUNCE_COUNT=1300000; reg sync_ff1,sync_ff2,stable_state; reg [20:0] debounce_cnt;
always @(posedge clk or posedge clr) begin
 if(clr) begin sync_ff1<=0;sync_ff2<=0;stable_state<=0;debounce_cnt<=0;outp<=0;end else begin
  sync_ff1<=inp;sync_ff2<=sync_ff1;outp<=0;
  if(sync_ff2==stable_state) debounce_cnt<=0;
  else if(debounce_cnt==DEBOUNCE_COUNT-1) begin debounce_cnt<=0;stable_state<=sync_ff2;if(sync_ff2) outp<=1;end
  else debounce_cnt<=debounce_cnt+1'b1;
 end
end
endmodule
