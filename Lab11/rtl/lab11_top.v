`timescale 1ns/1ps
module lab11_top #(parameter PERIOD=100000000, QUARTER=250, BIT_CLOCKS=868)(
    input CLK100MHZ, CPU_RESETN, inout TMP_SCL, TMP_SDA, output UART_RXD_OUT
);
    (* ASYNC_REG="TRUE" *) reg [1:0] reset_pipe=2'b11;
    (* ASYNC_REG="TRUE" *) reg [1:0] scl_sync=2'b11, sda_sync=2'b11;
    always @(posedge CLK100MHZ or negedge CPU_RESETN)
        if (!CPU_RESETN) reset_pipe <= 2'b11;
        else reset_pipe <= {reset_pipe[0],1'b0};
    always @(posedge CLK100MHZ) begin
        scl_sync <= {scl_sync[0],TMP_SCL};
        sda_sync <= {sda_sync[0],TMP_SDA};
    end
    wire scl_low,sda_low,start,done,nack,valid;
    wire [2:0] command;
    wire [7:0] tx_byte,received;
    wire signed [12:0] temperature;
    assign TMP_SCL=scl_low ? 1'b0 : 1'bz;
    assign TMP_SDA=sda_low ? 1'b0 : 1'bz;
    temperature_sequence #(PERIOD) controller(CLK100MHZ,reset_pipe[1],done,nack,
        received,start,command,tx_byte,temperature,valid);
    i2c_engine #(QUARTER) bus(CLK100MHZ,reset_pipe[1],start,command,tx_byte,
        scl_sync[1],sda_sync[1],scl_low,sda_low,done,nack,received);
    temperature_report #(BIT_CLOCKS) formatter(CLK100MHZ,reset_pipe[1],valid,
        temperature,UART_RXD_OUT);
endmodule
