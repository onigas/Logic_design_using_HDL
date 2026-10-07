`timescale 1ns / 1ps
module vga_ScreenSaver(input wire clk,input wire clr,input wire vidon,input wire [10:0] hc,input wire [10:0] vc,input wire [11:0] M,input wire [10:0] C1,input wire [10:0] R1,output wire [15:0] rom_addr16,output reg [3:0] red,output reg [3:0] green,output reg [3:0] blue);
parameter [10:0] hbp=296,vbp=35,W=240,H=160; wire [10:0] xpix=hc-hbp-C1,ypix=vc-vbp-R1; wire [16:0] y_ext={6'b0,ypix},x_ext={6'b0,xpix}; wire [16:0] rom_addr1=(y_ext<<7)+(y_ext<<6)+(y_ext<<5)+(y_ext<<4),rom_addr2=rom_addr1+x_ext; wire sprite_now=vidon&&(hc>=hbp+C1)&&(hc<hbp+C1+W)&&(vc>=vbp+R1)&&(vc<vbp+R1+H); reg sprite_d;
assign rom_addr16=sprite_now?rom_addr2[15:0]:16'd0; always @(posedge clk or posedge clr) if(clr)sprite_d<=0;else sprite_d<=sprite_now;
always @(*) begin red=0;green=0;blue=0;if(sprite_d) begin red=M[11:8];green=M[7:4];blue=M[3:0];end end
endmodule
