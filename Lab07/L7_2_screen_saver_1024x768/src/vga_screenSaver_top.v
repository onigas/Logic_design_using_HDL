`timescale 1ns / 1ps
module vga_screenSaver_top(input wire CLK100MHZ,input wire BTNC,input wire BTNL,output wire VGA_HS,output wire VGA_VS,output wire [3:0] VGA_R,output wire [3:0] VGA_G,output wire [3:0] VGA_B);
wire clk65,clr,hsync_raw,vsync_raw,vidon;wire [10:0] hc,vc,C1,R1;wire [11:0] M;wire [15:0] rom_addr16;wire go,frame_tick;reg hsync_d,vsync_d;assign clr=BTNC;assign frame_tick=(hc==1343)&&(vc==805);
clk_65mhz U1(.clk_in1(CLK100MHZ),.reset(clr),.clk_out1(clk65));
vga_1024x768 U2(.clk(clk65),.clr(clr),.hsync(hsync_raw),.vsync(vsync_raw),.hc(hc),.vc(vc),.vidon(vidon));
vga_ScreenSaver U3(.clk(clk65),.clr(clr),.vidon(vidon),.hc(hc),.vc(vc),.M(M),.C1(C1),.R1(R1),.rom_addr16(rom_addr16),.red(VGA_R),.green(VGA_G),.blue(VGA_B));
loons240x160 U4(.clka(clk65),.addra(rom_addr16),.douta(M)); clock_pulse U5(.inp(BTNL),.clk(clk65),.clr(clr),.outp(go)); bounce U6(.clk(clk65),.clr(clr),.go(go),.frame_tick(frame_tick),.c1(C1),.r1(R1));
always @(posedge clk65 or posedge clr) begin if(clr) begin hsync_d<=1;vsync_d<=1;end else begin hsync_d<=hsync_raw;vsync_d<=vsync_raw;end end
assign VGA_HS=hsync_d;assign VGA_VS=vsync_d;endmodule
