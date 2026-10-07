`timescale 1ns/1ps
`default_nettype none
module tb_rom8x8;
    logic [2:0] address;
    wire  [7:0] data;
    int i;

    rom8x8 dut (.address(address), .data(data));

    function automatic logic [7:0] expected(input logic [2:0] a);
        case (a)
            3'd0: expected = 8'h00;
            3'd1: expected = 8'hC8;
            3'd2: expected = 8'hF9;
            3'd3: expected = 8'hAF;
            3'd4: expected = 8'h64;
            3'd5: expected = 8'h95;
            3'd6: expected = 8'h6C;
            3'd7: expected = 8'hD4;
        endcase
    endfunction

    initial begin
        address = 3'd0;
        for (i = 0; i < 8; i++) begin
            address = i[2:0];
            #10;
            if (data !== expected(address))
                $fatal(1, "L4.1 address %0d: expected %02h, got %02h",
                       address, expected(address), data);
        end
        $display("L4.1 TEST PASSED: all eight addresses");
        $finish;
    end
endmodule
`default_nettype wire
