`timescale 1ns/1ps
`default_nettype none
module tb_dist_rom16;
    logic [3:0] address;
    wire  [7:0] data;
    int i;

    // Simulate the generated core, not the board wrapper.
    dist_rom16 dut (.a(address), .spo(data));

    function automatic logic [7:0] expected(input logic [3:0] a);
        case (a)
            4'd0:  expected = 8'h00;
            4'd1:  expected = 8'hC8;
            4'd2:  expected = 8'hF9;
            4'd3:  expected = 8'hAF;
            4'd4:  expected = 8'h64;
            4'd5:  expected = 8'h95;
            4'd6:  expected = 8'h6C;
            4'd7:  expected = 8'hD4;
            4'd8:  expected = 8'h39;
            4'd9:  expected = 8'hE7;
            4'd10: expected = 8'h5A;
            4'd11: expected = 8'h96;
            4'd12: expected = 8'h84;
            4'd13: expected = 8'h37;
            4'd14: expected = 8'h28;
            4'd15: expected = 8'h4C;
        endcase
    endfunction

    initial begin
        address = 4'd0;
        for (i = 0; i < 16; i++) begin
            address = i[3:0];
            #10;  // Allow the combinational output to settle.
            if (data !== expected(address))
                $fatal(1, "L4.2 address %0d: expected %02h, got %02h",
                       address, expected(address), data);
        end
        $display("L4.2 TEST PASSED: all 16 addresses");
        $finish;
    end
endmodule
`default_nettype wire
