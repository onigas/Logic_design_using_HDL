`default_nettype none
module rom8x8_board_top (
    input  wire [2:0] SW,
    output wire [7:0] LED
);
    rom8x8 u_rom (
        .address(SW),
        .data(LED)
    );
endmodule
`default_nettype wire
