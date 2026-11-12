`timescale 1ns / 1ps
// Two independent RGB332 words; a single 100 MHz / 256 PWM timebase.
module rgb_pwm (
    input wire CLK100MHZ,
    input wire BTNC,
    input wire [15:0] SW,
    output reg LED16_R, LED16_G, LED16_B,
    output reg LED17_R, LED17_G, LED17_B
);
    // Asynchronous assertion, synchronous release; initialized for FPGA startup.
    (* ASYNC_REG = "TRUE" *) reg [1:0] reset_pipe = 2'b11;
    always @(posedge CLK100MHZ or posedge BTNC)
        if (BTNC) reset_pipe <= 2'b11;
        else reset_pipe <= {reset_pipe[0], 1'b0};
    wire reset = reset_pipe[1];

    // Each switch is synchronized independently. Mechanical transitions may
    // briefly show intermediate colors; this is not a debounced word transfer.
    (* ASYNC_REG = "TRUE" *) reg [15:0] sw_meta, sw_sync;
    always @(posedge CLK100MHZ) begin
        if (reset) begin
            sw_meta <= 16'b0;
            sw_sync <= 16'b0;
        end else begin
            sw_meta <= SW;
            sw_sync <= sw_meta;
        end
    end

    // floor(level * 127 / maximum): LUTs avoid arithmetic dividers.
    function [7:0] duty3;
        input [2:0] level;
        begin
            case (level)
                0: duty3 = 0;
                1: duty3 = 18;
                2: duty3 = 36;
                3: duty3 = 54;
                4: duty3 = 72;
                5: duty3 = 90;
                6: duty3 = 108;
                7: duty3 = 127;
                default: duty3 = 0;
            endcase
        end
    endfunction
    function [7:0] duty2;
        input [1:0] level;
        begin
            case (level)
                0: duty2 = 0;
                1: duty2 = 42;
                2: duty2 = 84;
                3: duty2 = 127;
                default: duty2 = 0;
            endcase
        end
    endfunction

    reg [7:0] pwm_counter;
    reg [15:0] frame_color;
    always @(posedge CLK100MHZ) begin
        if (reset) begin
            pwm_counter <= 0;
            frame_color <= 0;
            {LED17_R, LED17_G, LED17_B, LED16_R, LED16_G, LED16_B} <= 0;
        end else begin
            pwm_counter <= pwm_counter + 1'b1;
            // Apply a new color only between frames, avoiding partial pulses.
            if (pwm_counter == 8'hff) frame_color <= sw_sync;
            // Registered active-high outputs; all six share the same phase.
            LED16_R <= pwm_counter < duty3(frame_color[7:5]);
            LED16_G <= pwm_counter < duty3(frame_color[4:2]);
            LED16_B <= pwm_counter < duty2(frame_color[1:0]);
            LED17_R <= pwm_counter < duty3(frame_color[15:13]);
            LED17_G <= pwm_counter < duty3(frame_color[12:10]);
            LED17_B <= pwm_counter < duty2(frame_color[9:8]);
        end
    end
endmodule
