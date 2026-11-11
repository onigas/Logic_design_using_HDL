// Single-controller, open-drain I2C primitives. Inputs are synchronized pin levels.
`timescale 1ns/1ps
module i2c_engine #(parameter QUARTER=250)(
    input clk, rst, start, input [2:0] command, input [7:0] tx_byte,
    input scl_in, sda_in, output reg scl_low, sda_low,
    output reg done, nack, output reg [7:0] received
);
    localparam START=0, WRITE=1, READ_ACK=2, READ_NACK=3, STOP=4;
    reg active;
    reg [2:0] op;
    reg [1:0] phase;
    reg [3:0] slot;
    reg [7:0] data;
    reg [15:0] timer;
    always @(posedge clk) begin
        done <= 0;
        if (rst) begin
            active <= 0;
            scl_low <= 0;
            sda_low <= 0;
            received <= 0;
            nack <= 0;
        end else if (!active) begin
            if (start) begin
                op <= command;
                data <= tx_byte;
                active <= 1;
                slot <= 0;
                phase <= 0;
                nack <= 0;
                timer <= QUARTER-1;
            end
        end else if (timer!=0) timer <= timer-1'b1;
        else begin
            timer <= QUARTER-1;
            // Wait for the released clock to reach high before sampling.
            if (phase!=2 || scl_in) begin
                phase <= phase+1'b1;
                case (phase)
                    0: begin
                        case (op)
                            START: sda_low <= 0;
                            STOP: sda_low <= 1;
                            WRITE: sda_low <= slot<8 && !data[7];
                            default: sda_low <= slot==8 && op==READ_ACK;
                        endcase
                    end
                    1: begin
                        scl_low <= 0;
                        // Allow bus rise and the Standard-mode START/STOP setup interval.
                        if (op==START || op==STOP) timer <= 3*QUARTER-1;
                    end
                    2: case (op)
                        START: begin sda_low <= 1; timer <= 2*QUARTER-1; end
                        STOP: sda_low <= 0;
                        WRITE: if (slot==8) nack <= sda_in;
                        default: if (slot<8) received <= {received[6:0],sda_in};
                    endcase
                    3: begin
                        scl_low <= op!=STOP;
                        if (op==START || op==STOP || slot==8) begin
                            done <= 1;
                            active <= 0;
                        end else begin
                            slot <= slot+1'b1;
                            data <= data << 1;
                        end
                    end
                endcase
            end
        end
    end
endmodule
