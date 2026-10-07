`timescale 1ns / 1ps

// 100 MHz clock and original L9.1 DUT; no accelerated hardware timing.
module pwmsim;
    reg clk = 1'b0;
    reg rst = 1'b1;
    reg [7:0] duty = 8'd97;
    wire led;

    pwm_led U1(.clk(clk), .rst(rst), .SW(duty), .led(led));
    always #5 clk = ~clk;

    task check_duty(input [7:0] setting);
        integer high_cycles;
        integer expected_high;
        begin
            @(negedge clk);
            rst = 1'b1;
            duty = setting;
            repeat (2) @(negedge clk);
            if (U1.count !== 17'd0)
                $fatal(1, "Reset did not clear the PWM counter");
            rst = 1'b0;
            high_cycles = 0;

            // Observe one full 100000-clock (1 ms) PWM period.
            repeat (100000) begin
                @(posedge clk);
                #1;
                if (led === 1'b1)
                    high_cycles = high_cycles + 1;
                else if (led !== 1'b0)
                    $fatal(1, "PWM output is unknown");
            end
            if (U1.count !== 17'd0)
                $fatal(1, "PWM period is not 100000 clocks");

            // The retained design compares count[16:9] with SW.
            expected_high = setting * 512;
            if (expected_high > 100000)
                expected_high = 100000;
            if (high_cycles != expected_high)
                $fatal(1, "SW=%0d: expected %0d high clocks, observed %0d",
                       setting, expected_high, high_cycles);
            $display("PASS SW=%0d: %0d/100000 high clocks, duty=%0.3f%%",
                     setting, high_cycles, 100.0 * high_cycles / 100000);
        end
    endtask

    initial begin
        check_duty(8'd97);   // Original simulation setting: 49.664%.
        check_duty(8'd0);    // Output always low.
        check_duty(8'd195);  // Last setting below full duty: 99.840%.
        check_duty(8'd196);  // First setting that saturates at 100%.
        check_duty(8'd255);  // Maximum switch value also gives 100%.
        $display("PASS: L9.1 PWM simulation completed");
        $finish;
    end

    initial begin
        #6000000;
        $fatal(1, "Simulation timeout");
    end
endmodule
