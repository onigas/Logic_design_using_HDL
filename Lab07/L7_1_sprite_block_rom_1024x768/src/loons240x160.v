`timescale 1ns / 1ps
module loons240x160(input wire clka,input wire [15:0] addra,output reg [11:0] douta);
(* rom_style = "block" *) reg [11:0] rom [0:38399];
initial begin $readmemh("loons240x160.mem",rom); end
always @(posedge clka) douta<=rom[addra];
endmodule
