`timescale 1ns/1ps
`default_nettype none
module tb_alu_top;
    reg [3:0] a, b;
    reg [2:0] f;
    wire [7:0] r;
    integer ai, bi, fi;
    integer checks = 0;

    alu_top dut(.a(a), .b(b), .f(f), .r(r));

    function automatic [7:0] reference(input [3:0] x, y,
                                       input [2:0] op);
        integer value;
        begin
            case (op)
                3'b000: value = x + y;
                3'b001: value = x + 1;
                3'b010: value = x - y;
                3'b011: value = x - 1;
                3'b100, 3'b101: value = x * y;
                default: value = 0;
            endcase
            reference = value & 8'hFF;
        end
    endfunction

    initial begin
        for (ai = 0; ai < 16; ai = ai + 1)
            for (bi = 0; bi < 16; bi = bi + 1)
                for (fi = 0; fi < 8; fi = fi + 1) begin
                    a = ai[3:0]; b = bi[3:0]; f = fi[2:0];
                    #1;
                    if (r !== reference(a, b, f))
                        $fatal(1, "a=%0d b=%0d f=%03b expected=%02h got=%02h",
                               a, b, f, reference(a, b, f), r);
                    checks = checks + 1;
                end
        $display("L5.1 TEST PASSED: %0d ALU combinations", checks);
        $finish;
    end
endmodule
`default_nettype wire
