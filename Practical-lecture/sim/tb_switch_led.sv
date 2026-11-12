`timescale 1ns/1ps
module tb_switch_led;
    reg clk = 0;
    always #5 clk = ~clk;
    reg reset_n = 0;
    reg [15:0] sw = 0;
    wire [15:0] led;
    integer i;
    switch_led_top dut (.CLK100MHZ(clk), .CPU_RESETN(reset_n), .SW(sw), .LED(led));
    task check;
        input [15:0] pattern;
        begin
            @(negedge clk); sw = pattern;
            repeat (40) @(negedge clk);
            if (led !== pattern) $fatal(1, "FAIL SW=%h LED=%h", pattern, led);
        end
    endtask
    initial begin
        #200; reset_n = 1;
        check(16'h0000);
        for (i=0; i<16; i=i+1) check(16'h0001 << i);
        for (i=0; i<16; i=i+1) check(~(16'h0001 << i));
        check(16'hFFFF); check(16'hAAAA); check(16'h5555);
        for (i=0; i<100; i=i+1) check($random);
        @(negedge clk); reset_n = 0;
        repeat (8) @(negedge clk);
        if (led !== 0) $fatal(1, "Reset did not clear LEDs");
        reset_n = 1;
        check(16'hA55A); check(16'h0000);
        $display("PASS: individual switches, combinations, 100 random patterns and reset");
        $finish;
    end
    initial begin #100000; $fatal(1, "Timeout"); end
endmodule
