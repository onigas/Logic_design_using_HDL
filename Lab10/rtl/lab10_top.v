`timescale 1ns/1ps
module lab10_top #(
    parameter POWER_WAIT=1000000, CONFIG_WAIT=100000, PERIOD=10000000,
    parameter SPI_HALF=50, UART_BIT=868
)(
    input CLK100MHZ, CPU_RESETN, ACL_MISO,
    output ACL_MOSI, ACL_SCLK, ACL_CSN, UART_RXD_OUT
);
    (* ASYNC_REG="TRUE" *) reg [1:0] reset_pipe = 2'b11;
    always @(posedge CLK100MHZ or negedge CPU_RESETN)
        if (!CPU_RESETN) reset_pipe <= 2'b11;
        else reset_pipe <= {reset_pipe[0],1'b0};
    wire rst = reset_pipe[1];
    localparam DELAY=0, ISSUE=1, TRANSFER=2;
    localparam SOFT_RESET=0, FILTER=1, MEASURE=2, READ_XYZ=3;
    reg [1:0] state, operation;
    reg [31:0] timer;
    reg [63:0] frame;
    always @* begin
        case (operation)
            SOFT_RESET: frame = 64'h0a1f520000000000;
            FILTER:     frame = 64'h0a2c030000000000;
            MEASURE:    frame = 64'h0a2d020000000000;
            default:    frame = 64'h0b0e000000000000;
        endcase
    end
    wire [63:0] rx;
    wire done;
    spi_frame #(SPI_HALF) spi(CLK100MHZ,rst,state==ISSUE,frame,
        operation==READ_XYZ ? 7'd64 : 7'd24,ACL_MISO,ACL_CSN,ACL_SCLK,ACL_MOSI,rx,done);
    reg signed [11:0] x,y,z;
    reg report;
    ascii_report #(UART_BIT) formatter(CLK100MHZ,rst,report,x,y,z,UART_RXD_OUT);
    always @(posedge CLK100MHZ) begin
        report <= 0;
        if (rst) begin
            state <= DELAY;
            operation <= SOFT_RESET;
            timer <= POWER_WAIT-1;
            x <= 0;
            y <= 0;
            z <= 0;
        end else begin
            if (timer != 0) timer <= timer-1'b1;
            case (state)
                DELAY: if (timer==0) state <= ISSUE;
                ISSUE: begin
                    if (operation==READ_XYZ) timer <= PERIOD-2;
                    state <= TRANSFER;
                end
                TRANSFER: if (done) begin
                    state <= DELAY;
                    if (operation==READ_XYZ) begin
                        // Received payload in wire order: XL XH YL YH ZL ZH
                        x <= {rx[35:32],rx[47:40]};
                        y <= {rx[19:16],rx[31:24]};
                        z <= {rx[3:0],rx[15:8]};
                        report <= 1;
                    end else begin
                        timer <= (operation==MEASURE ? PERIOD : CONFIG_WAIT)-1;
                        operation <= operation+1'b1;
                    end
                end
            endcase
        end
    end
endmodule
