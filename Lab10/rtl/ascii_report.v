`timescale 1ns/1ps
// Convert one stable snapshot into three signed decimal fields.
module ascii_report #(parameter BIT_CLOCKS=868)(
    input clk, rst, start, input signed [11:0] x, y, z, output tx
);
    localparam IDLE=0, LABEL=1, EQUALS=2, SIGN=3, DIGIT=4, SEP=5, LF=6;
    reg [2:0] state;
    reg [1:0] axis;
    wire signed [11:0] value = axis==0 ? x : axis==1 ? y : z;
    reg [11:0] magnitude, place;
    reg [3:0] digit;
    reg send;
    reg [7:0] character;
    wire busy;
    uart_tx #(BIT_CLOCKS) serial(clk,rst,send,character,tx,busy);
    always @(posedge clk) begin
        send <= 0;
        if (rst) state <= IDLE;
        else if (!busy && !send) begin
            case (state)
                IDLE: if (start) begin axis <= 0; state <= LABEL; end
                LABEL: begin character <= "X"+axis; send <= 1; state <= EQUALS; end
                EQUALS: begin character <= "="; send <= 1; state <= SIGN; end
                SIGN: begin
                    character <= value[11] ? "-" : "+";
                    magnitude <= value[11] ? (~value + 12'd1) : value;
                    place <= 1000;
                    digit <= 0;
                    send <= 1;
                    state <= DIGIT;
                end
                DIGIT: if (magnitude >= place) begin
                    magnitude <= magnitude-place;
                    digit <= digit+1'b1;
                end else begin
                    character <= "0"+digit;
                    send <= 1;
                    digit <= 0;
                    case (place)
                        1000: place <= 100;
                        100: place <= 10;
                        10: place <= 1;
                        default: state <= SEP;
                    endcase
                end
                SEP: begin
                    character <= axis==2 ? 8'h0d : " ";
                    send <= 1;
                    axis <= axis+1'b1;
                    state <= axis==2 ? LF : LABEL;
                end
                LF: begin character <= 8'h0a; send <= 1; state <= IDLE; end
            endcase
        end
    end
endmodule
