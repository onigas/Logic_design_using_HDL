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
        // TODO 1: decode steps 0..7. See the combined transaction in the handout.
        // Drive tx_byte for each WRITE. START serves both S and Sr.
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
                    // TODO 2: capture the two received bytes in their proper steps.
                    // TODO 3: handle a write NACK by marking failure and issuing STOP.
                    // TODO 4: after a successful STOP, commit the signed 13-bit
                    // result and pulse valid for one clock. Otherwise advance step.
                    state <= IDLE; // replace this placeholder
                end
            endcase
        end
    end
endmodule
