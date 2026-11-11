// Pin-level slave model and independent 8N1 receiver. Short simulation delays.
`timescale 1ns/1ps
module tb_lab10;
    reg clk=0, reset_n=0, miso=0;
    wire mosi,sclk,cs_n,tx;
    always #5 clk=~clk;
    lab10_top #(.POWER_WAIT(100),.CONFIG_WAIT(40),.PERIOD(5000),
        .SPI_HALF(3),.UART_BIT(8)) dut(clk,reset_n,miso,mosi,sclk,cs_n,tx);
    initial #100 reset_n=1;
    integer frames=0, bits=0, i, j, line;
    reg [63:0] request, response;
    time last_read;
    always @(negedge cs_n) begin
        bits=0;
        request=0;
        response=(frames==3) ? 64'h000000f8ff070000 : 64'h0000ffff010018fc;
        if (frames>=3) begin
            if (frames>3 && $time-last_read!=50000) $fatal(1,"Read cadence");
            last_read=$time;
        end
    end
    always @(posedge sclk) if (!cs_n) begin
        request={request[62:0],mosi};
        bits=bits+1;
    end
    always @(negedge sclk) if (!cs_n && bits<64) miso=response[63-bits];
    always @(posedge cs_n) if (reset_n) begin
        case (frames)
            0: if (bits!=24 || request!==24'h0a1f52) $fatal(1,"Reset frame");
            1: if (bits!=24 || request!==24'h0a2c03) $fatal(1,"Filter frame");
            2: if (bits!=24 || request!==24'h0a2d02) $fatal(1,"Power frame");
            default: if (bits!=64 || request!==64'h0b0e000000000000) $fatal(1,"Read frame");
        endcase
        frames=frames+1;
    end
    reg completed=0;
    reg [7:0] decoded;
    reg [8*25-1:0] expected;
    initial begin
        wait(reset_n);
        for (line=0; line<2; line=line+1) begin
            expected = line==0 ? {"X=-2048 Y=+2047 Z=+0000",16'h0d0a} :
                                 {"X=-0001 Y=+0001 Z=-1000",16'h0d0a};
            for (j=24;j>=0;j=j-1) begin
                @(negedge tx);
                #40;
                if (tx!==0) $fatal(1,"Start bit");
                for (i=0;i<8;i=i+1) begin #80; decoded[i]=tx; end
                #80;
                if (tx!==1 || decoded!==expected[j*8+:8]) $fatal(1,"UART byte %d",24-j);
            end
        end
        completed=1;
        $display("PASS: init, two SPI bursts, cadence, signed limits and 50 UART bytes");
        $finish;
    end
    initial #250000 if (!completed) $fatal(1,"Timeout");
endmodule
