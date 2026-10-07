`default_nettype none
module mux2_4(input wire [3:0] i0, i1, input wire sel, output wire [3:0] out);
    assign out = sel ? i1 : i0;
endmodule

module mux3_8(input wire [7:0] i0, i1, i2, input wire [1:0] sel,
              output reg [7:0] out);
    always @* begin
        case (sel)
            2'b00: out = i0;
            2'b01: out = i1;
            2'b10: out = i2;
            default: out = 8'h00; // 11 is reserved; drive a known value.
        endcase
    end
endmodule

module add4(input wire [3:0] i0, i1, output wire [7:0] sum);
    assign sum = {4'b0000, i0} + {4'b0000, i1};
endmodule

module sub4(input wire [3:0] i0, i1, output wire [7:0] diff);
    // The result is an 8-bit two's-complement bit pattern: 10 - 12 = FE.
    assign diff = {4'b0000, i0} - {4'b0000, i1};
endmodule

module mul4(input wire [3:0] i0, i1, output wire [7:0] prod);
    assign prod = i0 * i1; // Maximum: 15 * 15 = 225 = E1.
endmodule
`default_nettype wire
