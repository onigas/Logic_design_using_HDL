`timescale 1ns / 1ps

module clkdiv(  input wire clk, 
                input wire clr, 
                output wire clk190, 
                output wire clk25, 
                output wire clk3        );

    reg [24:0] q;
    
    always @(posedge clk or posedge clr)
        begin
            if(clr == 1)
                q <= 0;
            else
                q <= q+1;
        end
        
    assign clk190 = q[18]; //190 Hz
    assign clk25 = q[1]; // 25 Mhz
    assign clk3 = q[24]; // 3 Hz

endmodule
