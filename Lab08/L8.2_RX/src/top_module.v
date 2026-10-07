`timescale 1ns / 1ps

module Top_Module(  input wire mclk, 
                    input wire[3:0] btn, 
                    input wire RxD, 
                    output wire[6:0] a_to_g, 
                    output wire dp, 
                    output wire[3:0] an
                  );
                    
   wire clk25, clk190, clr;
   wire rdrf, rdrf_clr, FE;
   wire [7:0] rx_data;

   
   assign clr = btn[3];
   
   clkdiv U1(.clk(mclk), .clr(clr), .clk190(clk190), .clk25(clk25) );
   uart_rx U2 (.RxD(RxD), .clk(clk25), .clr(clr), .rdrf_clr(rdrf_clr), .rdrf(rdrf), .rx_data(rx_data), .FE(FE) );
   test_rx_ctrl U3 (.clk(clk25), .clr(clr), .rdrf(rdrf), .rdrf_clr(rdrf_clr) );
   x7segb U4 ( .x(rx_data), .cclk(clk190), .clr(clr), .a_to_g(a_to_g), .an(an), .dp(dp) );
         
endmodule
