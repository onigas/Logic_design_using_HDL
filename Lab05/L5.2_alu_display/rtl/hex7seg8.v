`default_nettype none
module hex7seg8 #(
    parameter integer SCAN_DIVISOR = 25000
) (
    input wire clk, input wire [7:0] data,
    output reg [6:0] seg, output reg [7:0] an, output wire dp
);
    reg [14:0] count = 15'd0;
    reg digit = 1'b0;
    reg [3:0] nibble;
    assign dp = 1'b1;

    always @(posedge clk) begin
        if (count == SCAN_DIVISOR - 1) begin
            count <= 15'd0;
            digit <= ~digit;
        end else begin
            count <= count + 15'd1;
        end
    end

    always @* begin
        nibble = digit ? data[7:4] : data[3:0];
        an = digit ? 8'b1111_1101 : 8'b1111_1110;
        case (nibble)
            4'h0: seg = 7'b1000000;
            4'h1: seg = 7'b1111001;
            4'h2: seg = 7'b0100100;
            4'h3: seg = 7'b0110000;
            4'h4: seg = 7'b0011001;
            4'h5: seg = 7'b0010010;
            4'h6: seg = 7'b0000010;
            4'h7: seg = 7'b1111000;
            4'h8: seg = 7'b0000000;
            4'h9: seg = 7'b0010000;
            4'hA: seg = 7'b0001000;
            4'hB: seg = 7'b0000011;
            4'hC: seg = 7'b1000110;
            4'hD: seg = 7'b0100001;
            4'hE: seg = 7'b0000110;
            4'hF: seg = 7'b0001110;
            default: seg = 7'b1111111;
        endcase
    end
endmodule
`default_nettype wire
