`timescale 1ns / 1ps
// Boci, boci, tarka: 24 notes, C major, 2/4, quarter = 100 BPM.
// One 100 MHz clock domain; enables for milliseconds and PWM frames.
module melody_player (
    input wire CLK100MHZ,
    input wire BTNC,
    input wire [0:0] SW,
    output wire AUD_PWM,
    output wire AUD_SD
);
    (* ASYNC_REG = "TRUE" *) reg [1:0] reset_pipe = 2'b11;
    (* ASYNC_REG = "TRUE" *) reg [1:0] play_pipe = 0;
    always @(posedge CLK100MHZ or posedge BTNC)
        if (BTNC) reset_pipe <= 2'b11;
        else reset_pipe <= {reset_pipe[0], 1'b0};
    wire reset = reset_pipe[1];
    always @(posedge CLK100MHZ)
        if (reset) play_pipe <= 0;
        else play_pipe <= {play_pipe[0], SW[0]};
    wire playing = play_pipe[1] && !reset;

    reg [16:0] ms_counter = 0;
    reg [9:0] elapsed_ms = 0;
    reg [4:0] note_index = 0;
    wire long_note = (note_index == 4 || note_index == 5 ||
                      note_index == 10 || note_index == 11 ||
                      note_index == 16 || note_index == 17 ||
                      note_index >= 22);
    wire [9:0] duration_ms = long_note ? 10'd600 : 10'd300;
    // Last 30 ms of each note is silent, making repeated pitches distinct.
    // Index 24 is a 600 ms rest before repeating the melody.
    wire sounding = playing && note_index < 24 && elapsed_ms < duration_ms - 10'd30;
    always @(posedge CLK100MHZ) begin
        if (!playing) begin
            ms_counter <= 0;
            elapsed_ms <= 0;
            note_index <= 0;
        end else if (ms_counter == 17'd99999) begin
            ms_counter <= 0;
            if (elapsed_ms == duration_ms - 1'b1) begin
                elapsed_ms <= 0;
                note_index <= (note_index == 24) ? 0 : note_index + 1'b1;
            end else elapsed_ms <= elapsed_ms + 1'b1;
        end else ms_counter <= ms_counter + 1'b1;
    end

    // 24-bit DDS phase increment, updated at the PWM frame rate 390625 Hz.
    function [23:0] note_step;
        input [4:0] index;
        begin
            case (index)
                5'd0: note_step = 24'd11237; // C4, 261.626 Hz
                5'd1: note_step = 24'd14157; // E4, 329.628 Hz
                5'd2: note_step = 24'd11237; // C4, 261.626 Hz
                5'd3: note_step = 24'd14157; // E4, 329.628 Hz
                5'd4: note_step = 24'd16836; // G4, 391.995 Hz
                5'd5: note_step = 24'd16836; // G4, 391.995 Hz
                5'd6: note_step = 24'd11237; // C4, 261.626 Hz
                5'd7: note_step = 24'd14157; // E4, 329.628 Hz
                5'd8: note_step = 24'd11237; // C4, 261.626 Hz
                5'd9: note_step = 24'd14157; // E4, 329.628 Hz
                5'd10: note_step = 24'd16836; // G4, 391.995 Hz
                5'd11: note_step = 24'd16836; // G4, 391.995 Hz
                5'd12: note_step = 24'd22473; // C5, 523.251 Hz
                5'd13: note_step = 24'd21212; // B4, 493.883 Hz
                5'd14: note_step = 24'd18898; // A4, 440.000 Hz
                5'd15: note_step = 24'd16836; // G4, 391.995 Hz
                5'd16: note_step = 24'd14999; // F4, 349.228 Hz
                5'd17: note_step = 24'd18898; // A4, 440.000 Hz
                5'd18: note_step = 24'd16836; // G4, 391.995 Hz
                5'd19: note_step = 24'd14999; // F4, 349.228 Hz
                5'd20: note_step = 24'd14157; // E4, 329.628 Hz
                5'd21: note_step = 24'd12613; // D4, 293.665 Hz
                5'd22: note_step = 24'd11237; // C4, 261.626 Hz
                5'd23: note_step = 24'd11237; // C4, 261.626 Hz
                default: note_step = 0;
            endcase
        end
    endfunction

    // 32-point sine ROM, midpoint 128, amplitude 32 (moderate volume).
    function [7:0] sine_sample;
        input [4:0] address;
        begin
            case (address)
                5'd0: sine_sample = 8'd128;
                5'd1: sine_sample = 8'd134;
                5'd2: sine_sample = 8'd140;
                5'd3: sine_sample = 8'd146;
                5'd4: sine_sample = 8'd151;
                5'd5: sine_sample = 8'd155;
                5'd6: sine_sample = 8'd158;
                5'd7: sine_sample = 8'd159;
                5'd8: sine_sample = 8'd160;
                5'd9: sine_sample = 8'd159;
                5'd10: sine_sample = 8'd158;
                5'd11: sine_sample = 8'd155;
                5'd12: sine_sample = 8'd151;
                5'd13: sine_sample = 8'd146;
                5'd14: sine_sample = 8'd140;
                5'd15: sine_sample = 8'd134;
                5'd16: sine_sample = 8'd128;
                5'd17: sine_sample = 8'd122;
                5'd18: sine_sample = 8'd116;
                5'd19: sine_sample = 8'd110;
                5'd20: sine_sample = 8'd105;
                5'd21: sine_sample = 8'd101;
                5'd22: sine_sample = 8'd98;
                5'd23: sine_sample = 8'd97;
                5'd24: sine_sample = 8'd96;
                5'd25: sine_sample = 8'd97;
                5'd26: sine_sample = 8'd98;
                5'd27: sine_sample = 8'd101;
                5'd28: sine_sample = 8'd105;
                5'd29: sine_sample = 8'd110;
                5'd30: sine_sample = 8'd116;
                5'd31: sine_sample = 8'd122;
                default: sine_sample = 128;
            endcase
        end
    endfunction

    reg [23:0] phase = 0;
    reg [7:0] pwm_counter = 0;
    reg [7:0] sample = 128;
    reg pwm_high = 0;
    always @(posedge CLK100MHZ) begin
        if (reset) begin
            phase <= 0;
            pwm_counter <= 0;
            sample <= 128;
            pwm_high <= 0;
        end else begin
            pwm_counter <= pwm_counter + 1'b1;
            pwm_high <= (pwm_counter < sample);
            if (pwm_counter == 8'hff) begin
                if (sounding) begin
                    phase <= phase + note_step(note_index);
                    sample <= sine_sample(phase[23:19]);
                end else begin
                    phase <= 0;
                    sample <= 128;
                end
            end
        end
    end
    // Nexys4 DDR/A7 audio input MUST be open drain: 0 or Z, never driven 1.
    assign AUD_PWM = (!playing || pwm_high) ? 1'bz : 1'b0;
    assign AUD_SD = playing;
endmodule
