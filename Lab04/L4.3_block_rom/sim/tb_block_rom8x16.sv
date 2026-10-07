`timescale 1ns/1ps
`default_nettype none
module tb_block_rom8x16;
    logic clk = 1'b0;
    logic [2:0] address = 3'd0;
    wire [15:0] data;
    int i;

    always #5 clk = ~clk;
    block_rom8x16 dut (.clka(clk), .addra(address), .douta(data));

    function automatic logic [15:0] expected(input logic [2:0] a);
        case (a)
            3'd0: expected = 16'h0000;
            3'd1: expected = 16'h1111;
            3'd2: expected = 16'h2222;
            3'd3: expected = 16'h3333;
            3'd4: expected = 16'h4444;
            3'd5: expected = 16'h5555;
            3'd6: expected = 16'h6666;
            3'd7: expected = 16'h7777;
        endcase
    endfunction

    initial begin
        for (i = 0; i < 8; i++) begin
            @(negedge clk);
            address = i[2:0];
            @(posedge clk);
            #1;
            if (data !== expected(address))
                $fatal(1, "L4.3 address %0d: expected %04h, got %04h", address, expected(address), data);
        end
        $display("L4.3 ROM TEST PASSED: all eight addresses");
        $finish;
    end
endmodule
`default_nettype wire
