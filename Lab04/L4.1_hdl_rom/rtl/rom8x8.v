`default_nettype none
module rom8x8 #(
    parameter [63:0] INIT = 64'h00C8F9AF64956CD4
) (
    input  wire [2:0] address,
    output wire [7:0] data
);
    reg [7:0] rom [0:7];
    integer i;

    initial begin
        for (i = 0; i < 8; i = i + 1)
            rom[i] = INIT[63 - i*8 -: 8];
    end

    assign data = rom[address];
endmodule
`default_nettype wire
