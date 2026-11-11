`timescale 1ns/1ps
// Mode 0, MSB first. The transmit frame is left-aligned.
module spi_frame #(parameter HALF = 50)(
    input clk, rst, start, input [63:0] frame, input [6:0] length,
    input miso, output reg cs_n, sclk, output mosi,
    output reg [63:0] received, output reg done
);
    localparam IDLE=0, RISE=1, FALL=2, RELEASE_CS=3;
    reg [1:0] state;
    reg [15:0] divider;
    reg [6:0] remaining;
    reg [63:0] tx;
    assign mosi = tx[63];
    always @(posedge clk) begin
        done <= 0;
        if (rst) begin
            state <= IDLE;
            cs_n <= 1;
            sclk <= 0;
            tx <= 0;
            received <= 0;
            divider <= 0;
        end else if (state == IDLE) begin
            if (start) begin
                tx <= frame;
                received <= 0;
                remaining <= length;
                cs_n <= 0;
                divider <= HALF-1;
                state <= RISE;
            end
        end else if (divider != 0) divider <= divider-1'b1;
        else begin
            divider <= HALF-1;
            case (state)
                RISE: begin
                    sclk <= 1;
                    received <= {received[62:0],miso};
                    state <= FALL;
                end
                FALL: begin
                    sclk <= 0;
                    tx <= tx << 1;
                    remaining <= remaining-1'b1;
                    state <= (remaining == 1) ? RELEASE_CS : RISE;
                end
                RELEASE_CS: begin
                    cs_n <= 1;
                    done <= 1;
                    state <= IDLE;
                end
            endcase
        end
    end
endmodule
