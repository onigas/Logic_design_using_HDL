// Round to the nearest centidegree (ties away from zero) and serialize ASCII.
`timescale 1ns/1ps
module temperature_report #(parameter BIT_CLOCKS=868)(
    input clk, rst, valid, input signed [12:0] temperature, output tx
);
    localparam IDLE=0, SCALE=1, CONVERT=2, PRINT=3;
    reg [1:0] state;
    reg negative;
    reg [12:0] magnitude;
    reg [15:0] binary;
    reg [19:0] bcd, adjusted;
    reg [4:0] remaining;
    reg [3:0] index;
    reg [7:0] character;
    reg send;
    wire busy;
    uart_tx #(BIT_CLOCKS) serial(clk,rst,send,character,tx,busy);
    integer i;
    always @* begin
        adjusted=bcd;
        for (i=0;i<5;i=i+1)
            if (bcd[i*4+:4]>=5) adjusted[i*4+:4]=bcd[i*4+:4]+3;
    end
    always @(posedge clk) begin
        send <= 0;
        if (rst) state <= IDLE;
        else case (state)
            IDLE: if (valid) begin
                negative <= temperature[12];
                magnitude <= temperature[12] ? -temperature : temperature;
                state <= SCALE;
            end
            SCALE: begin
                binary <= (magnitude*100+8)>>4;
                remaining <= 16;
                bcd <= 0;
                state <= CONVERT;
            end
            CONVERT: begin
                bcd <= {adjusted[18:0],binary[15]};
                binary <= binary << 1;
                remaining <= remaining-1'b1;
                if (remaining==1) begin index <= 0; state <= PRINT; end
            end
            PRINT: if (!busy && !send) begin
                send <= 1;
                index <= index+1'b1;
                case (index)
                    0: character <= "T";
                    1: character <= "=";
                    2: begin
                        character <= negative ? "-" : "+";
                        if (bcd[19:16]==0) index <= 4;
                    end
                    3: character <= "0"+bcd[19:16];
                    4: character <= "0"+bcd[15:12];
                    5: character <= "0"+bcd[11:8];
                    6: character <= ".";
                    7: character <= "0"+bcd[7:4];
                    8: character <= "0"+bcd[3:0];
                    9: character <= " ";
                    10: character <= "C";
                    11: character <= 13;
                    12: begin character <= 10; state <= IDLE; end
                endcase
            end
        endcase
    end
endmodule
