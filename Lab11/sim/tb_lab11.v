`timescale 1ns/1ps
module tb_lab11;
    reg clk=0, reset_n=0, sensor_low=0;
    tri1 scl,sda;
    wire tx;
    assign sda=sensor_low ? 1'b0 : 1'bz;
    always #5 clk=~clk;
    lab11_top #(.PERIOD(5000),.QUARTER(8),.BIT_CLOCKS(10)) dut(clk,reset_n,scl,sda,tx);
    initial #100 reset_n=1;
    integer starts=0,stops=0,commits=0;
    always @(negedge sda) if (scl===1 && reset_n) starts=starts+1;
    always @(posedge sda) if (scl===1 && reset_n) stops=stops+1;
    always @(posedge clk) if (dut.valid) begin
        commits=commits+1;
        if (stops!=commits+1) $fatal(1,"Unexpected result after NACK or before STOP");
    end
    task await_start;
        begin
            @(negedge sda);
            while (scl!==1) @(negedge sda);
            @(negedge scl);
        end
    endtask
    task expect_write(input [7:0] expected,input acknowledge);
        integer bit_index;
        reg [7:0] observed;
        begin
            for (bit_index=7;bit_index>=0;bit_index=bit_index-1) begin
                @(posedge scl); observed[bit_index]=sda; @(negedge scl);
            end
            if (observed!==expected) $fatal(1,"Wrong controller byte %h, expected %h",observed,expected);
            sensor_low=acknowledge;
            @(posedge scl);
            if (sda!==!acknowledge) $fatal(1,"Write ACK ownership");
            @(negedge scl); sensor_low=0;
        end
    endtask
    task send_byte(input [7:0] value,input expected_nack);
        integer bit_index;
        begin
            for (bit_index=7;bit_index>=0;bit_index=bit_index-1) begin
                sensor_low=!value[bit_index];
                @(posedge scl);
                if (sda!==value[bit_index]) $fatal(1,"Read data contention");
                @(negedge scl);
            end
            sensor_low=0;
            @(posedge scl);
            if (sda!==expected_nack) $fatal(1,"Wrong ACK on received byte");
            @(negedge scl);
        end
    endtask
    task await_stop;
        begin
            @(posedge sda);
            while (scl!==1) @(posedge sda);
        end
    endtask
    task sample(input [15:0] raw);
        begin
            await_start;
            expect_write(8'h96,1);
            expect_write(0,1);
            await_start;
            expect_write(8'h97,1);
            send_byte(raw[15:8],0);
            send_byte(raw[7:0],1);
            await_stop;
        end
    endtask
    initial begin
        wait(reset_n);
        await_start;
        expect_write(8'h96,0); // disconnected target on the first request
        await_stop;
        sample(16'h0c80);       // +25.00
        sample(16'hfac0);       // -10.50
    end
    task expect_line(input [95:0] expected);
        integer b,k;
        reg [7:0] observed;
        begin
            for (b=11;b>=0;b=b-1) begin
                @(negedge tx); #50;
                if (tx!==0) $fatal(1,"UART start");
                for (k=0;k<8;k=k+1) begin #100; observed[k]=tx; end
                #100;
                if (tx!==1 || observed!==expected[8*b+:8]) $fatal(1,"Unexpected UART byte %h",observed);
            end
        end
    endtask
    reg finished=0;
    initial begin
        wait(reset_n);
        expect_line({"T=+25.00 C",16'h0d0a});
        expect_line({"T=-10.50 C",16'h0d0a});
        if (starts!=5 || stops!=3 || commits!=2) $fatal(1,"Transaction counts");
        finished=1;
        $display("PASS: NACK recovery, two repeated START reads, ACK ownership and signed UART output");
        $finish;
    end
    initial #250000 if (!finished) $fatal(1,"Timeout: inspect transaction FSM and SDA/SCL");
endmodule
