`default_nettype none
module sevenseg_hex #(
    parameter integer SCAN_DIVISOR = 25000
) (
    input  wire       clk,
    input  wire [15:0] data,
    output reg  [6:0] seg,
    output reg  [7:0] an,
    output wire       dp
);
    reg [14:0] divider = 15'd0;
    reg [1:0]  selection = 2'd0;
    reg [3:0]  nibble;

    assign dp = 1'b1;

    always @(posedge clk) begin
        if (divider == SCAN_DIVISOR - 1) begin
            divider <= 15'd0;
            selection <= selection + 2'd1;
        end else begin
            divider <= divider + 15'd1;
        end
    end

    always @* begin
        case (selection)
            2'd0: begin nibble = data[3:0];   an = 8'b1111_1110; end
            2'd1: begin nibble = data[7:4];   an = 8'b1111_1101; end
            2'd2: begin nibble = data[11:8];  an = 8'b1111_1011; end
            2'd3: begin nibble = data[15:12]; an = 8'b1111_0111; end
            default: begin nibble = 4'h0;    an = 8'hFF; end
        endcase

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
