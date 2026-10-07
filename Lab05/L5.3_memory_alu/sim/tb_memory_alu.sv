`timescale 1ns/1ps
`default_nettype none
module tb_memory_alu;
    reg clk = 1'b0;
    reg [7:0] sw = 8'h00;
    wire [6:0] seg;
    wire [7:0] an;
    wire dp;
    always #5 clk = ~clk;
    memory_alu_top dut(.CLK100MHZ(clk), .SW(sw), .SEG(seg), .AN(an), .DP(dp));
    wire [3:0] operand_a = dut.stored_a;
    wire [3:0] operand_b = dut.stored_b;
    wire [7:0] result = dut.sum;
    function automatic [3:0] rom_value(input [3:0] addr);
        case (addr)
            4'h0: rom_value=4'h3; 4'h1: rom_value=4'hA;
            4'h2: rom_value=4'h1; 4'h3: rom_value=4'hC;
            4'h4: rom_value=4'h5; 4'h5: rom_value=4'hE;
            4'h6: rom_value=4'h7; 4'h7: rom_value=4'h8;
            4'h8: rom_value=4'h0; 4'h9: rom_value=4'h2;
            4'hA: rom_value=4'h4; 4'hB: rom_value=4'h6;
            4'hC: rom_value=4'h9; 4'hD: rom_value=4'hB;
            4'hE: rom_value=4'hD; 4'hF: rom_value=4'hF;
            default: rom_value=4'hx;
        endcase
    endfunction
    integer a_index,b_index,tests_passed=0;
    initial begin
      #2;
      for (a_index=0;a_index<16;a_index=a_index+1)
        for (b_index=0;b_index<16;b_index=b_index+1) begin
          sw={b_index[3:0],a_index[3:0]}; #10;
          if (result !== ({4'b0,rom_value(a_index[3:0])}+{4'b0,rom_value(b_index[3:0])})) $fatal(1,"Mismatch");
          tests_passed=tests_passed+1;
        end
      $display("L5.3 TEST PASSED: %0d checks",tests_passed);
      $finish;
    end
endmodule
`default_nettype wire
