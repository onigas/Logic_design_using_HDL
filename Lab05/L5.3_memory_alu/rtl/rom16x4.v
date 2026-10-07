`default_nettype none
module rom16x4 #(
    parameter [63:0] INIT = 64'h3A1C5E7802469BDF
) (input wire [3:0] addr, output wire [3:0] data);
    reg [3:0] mem [0:15];
    integer i;
    initial begin
        for (i = 0; i < 16; i = i + 1)
            mem[i] = INIT[63 - i*4 -: 4];
    end
    assign data = mem[addr];
endmodule
`default_nettype wire
