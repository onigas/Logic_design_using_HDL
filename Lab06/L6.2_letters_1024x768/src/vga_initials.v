`timescale 1ns / 1ps
module vga_initials(input wire vidon,input wire [10:0] hc,vc,input wire [0:31] M,input wire [7:0] sw,input wire BTNL,output wire [3:0] rom_addr4,output reg [3:0] red,output reg [3:0] green,output reg [3:0] blue);
parameter [10:0] hbp=11'd296,vbp=11'd35,W=11'd32,H=11'd16;
wire [10:0] C1,R1,rom_addr,rom_pix; reg spriteon,R,G,B;
assign C1={2'b00,sw[3:0],5'b00011}; assign R1={2'b00,sw[7:4],5'b00011};
assign rom_addr=vc-vbp-R1; assign rom_pix=hc-hbp-C1; assign rom_addr4=rom_addr[3:0];
always @(*) begin if((hc>=C1+hbp)&&(hc<C1+hbp+W)&&(vc>=R1+vbp)&&(vc<R1+vbp+H)) spriteon=1; else spriteon=0; end
always @(*) begin red=0;green=0;blue=0; if(spriteon&&vidon) begin R=M[rom_pix];G=M[rom_pix];B=M[rom_pix];red={4{R}};green={4{G}};blue={4{B}};end end
endmodule
