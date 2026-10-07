`timescale 1ns / 1ps
module vga_bsprite(input wire clk,input wire clr,input wire vidon,input wire [10:0] hc,input wire [10:0] vc,input wire [7:0] sw,input wire [11:0] M,output wire [15:0] rom_addr16,output reg [3:0] red,output reg [3:0] green,output reg [3:0] blue);
parameter [10:0] hbp=11'd296,vbp=11'd35,W=11'd240,H=11'd160;
wire [10:0] C1={2'b00,sw[3:0],5'b00000}; wire [10:0] R1={2'b00,sw[7:4],5'b00000};
wire [10:0] xpix=hc-hbp-C1, ypix=vc-vbp-R1;
wire [16:0] y_ext={6'b000000,ypix},x_ext={6'b000000,xpix};
wire [16:0] rom_addr1=(y_ext<<7)+(y_ext<<6)+(y_ext<<5)+(y_ext<<4); wire [16:0] rom_addr2=rom_addr1+x_ext;
wire sprite_now=vidon&&(hc>=hbp+C1)&&(hc<hbp+C1+W)&&(vc>=vbp+R1)&&(vc<vbp+R1+H); reg sprite_d;
assign rom_addr16=sprite_now?rom_addr2[15:0]:16'd0;
always @(posedge clk or posedge clr) if(clr) sprite_d<=0; else sprite_d<=sprite_now;
always @(*) begin red=0;green=0;blue=0; if(sprite_d) begin red=M[11:8];green=M[7:4];blue=M[3:0];end end
endmodule
