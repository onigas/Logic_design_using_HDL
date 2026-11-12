`timescale 1ns / 1ps
module rgb_pwm_tb;
    reg CLK100MHZ = 0;
    always #5 CLK100MHZ = ~CLK100MHZ;
    reg BTNC = 1;
    reg [15:0] SW = 0;
    wire [5:0] led;
    rgb_pwm dut (.CLK100MHZ(CLK100MHZ), .BTNC(BTNC), .SW(SW),
        .LED16_R(led[2]), .LED16_G(led[1]), .LED16_B(led[0]),
        .LED17_R(led[5]), .LED17_G(led[4]), .LED17_B(led[3]));
    integer counts [0:5];
    integer expected [0:5];
    integer i, j, color;

    task check_color(input [15:0] word);
        begin
            @(negedge CLK100MHZ) SW = word;
            // Allow synchronizers and frame latch to settle, independent of phase.
            repeat (520) @(negedge CLK100MHZ);
            expected[0] = (word[1:0] * 127) / 3;
            expected[1] = (word[4:2] * 127) / 7;
            expected[2] = (word[7:5] * 127) / 7;
            expected[3] = (word[9:8] * 127) / 3;
            expected[4] = (word[12:10] * 127) / 7;
            expected[5] = (word[15:13] * 127) / 7;
            for (j = 0; j < 6; j = j + 1) counts[j] = 0;
            repeat (256) begin
                @(negedge CLK100MHZ);
                if (^led === 1'bx) $fatal(1, "Unknown output");
                for (j = 0; j < 6; j = j + 1) counts[j] = counts[j] + led[j];
            end
            for (j = 0; j < 6; j = j + 1)
                if (counts[j] != expected[j])
                    $fatal(1, "SW=%h channel=%0d actual=%0d expected=%0d",
                           word, j, counts[j], expected[j]);
        end
    endtask

    initial begin
        repeat (4) @(negedge CLK100MHZ);
        if (led !== 0) $fatal(1, "Reset must blank all channels");
        BTNC = 0;
        // Every RGB332 word on each LED, independently (other LED off),
        // then complementary words to exercise all six channels together.
        for (color = 0; color < 256; color = color + 1) begin
            check_color({8'b0, color[7:0]});
            check_color({color[7:0], 8'b0});
            check_color({~color[7:0], color[7:0]});
        end
        check_color(16'hffff);
        // Reset during active PWM, away from a clock edge.
        wait (led == 6'b111111);
        #2 BTNC = 1;
        repeat (4) @(negedge CLK100MHZ);
        if (led !== 0) $fatal(1, "Reset during PWM failed");
        repeat (300) begin
            @(negedge CLK100MHZ);
            if (led !== 0) $fatal(1, "Outputs active while reset held");
        end
        BTNC = 0;
        check_color(16'hffff);
        check_color(16'h0000);
        $display("PASS: L9.5 all RGB332 levels, independent channels, reset and recovery");
        $finish;
    end
    initial begin
        #10000000;
        $fatal(1, "Simulation timeout");
    end
endmodule
