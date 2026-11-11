`timescale 1ns/1ps
module temperature_sequence #(parameter PERIOD=100000000)(
    input clk, rst, done, nack, input [7:0] received,
    output reg start, output reg [2:0] command, output reg [7:0] tx_byte,
    output reg signed [12:0] temperature, output reg valid
);
    localparam START=0, WRITE=1, READ_ACK=2, READ_NACK=3, STOP=4;
    localparam IDLE=0, ISSUE=1, WAIT_DONE=2;
    reg [1:0] state;
    reg [2:0] step;
    reg [31:0] timer;
    reg failed;
    reg [7:0] msb, lsb;
    always @* begin
        command=STOP;
        tx_byte=0;
        case (step)
            0,3: command=START;
            1: begin command=WRITE; tx_byte=8'h96; end
            2: begin command=WRITE; tx_byte=8'h00; end
            4: begin command=WRITE; tx_byte=8'h97; end
            5: command=READ_ACK;
            6: command=READ_NACK;
            7: command=STOP;
        endcase
    end
    always @(posedge clk) begin
        start <= 0;
        valid <= 0;
        if (rst) begin
            state <= IDLE;
            timer <= PERIOD-1;
            temperature <= 0;
        end else begin
            if (timer!=0) timer <= timer-1'b1;
            case (state)
                IDLE: if (timer==0) begin
                    timer <= PERIOD-1;
                    step <= 0;
                    failed <= 0;
                    state <= ISSUE;
                end
                ISSUE: begin start <= 1; state <= WAIT_DONE; end
                WAIT_DONE: if (done) begin
                    if (step==5) msb <= received;
                    if (step==6) lsb <= received;
                    if (step==7) begin
                        if (!failed) begin
                            temperature <= {msb,lsb[7:3]};
                            valid <= 1;
                        end
                        state <= IDLE;
                    end else begin
                        if (command==WRITE && nack) begin
                            failed <= 1;
                            step <= 7;
                        end else step <= step+1'b1;
                        state <= ISSUE;
                    end
                end
            endcase
        end
    end
endmodule
