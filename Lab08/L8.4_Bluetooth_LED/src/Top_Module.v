`timescale 1ns / 1ps

// L8.4: HC-06 UART echo with ASCII digit-controlled onboard LEDs.
// Nexys4 DDR / Nexys A7-100T: HC-06 TX -> JB4/H14 (RxD),
// HC-06 RX <- JB3/G16 (TxD), common GND, 3.3 V logic.
// Sending '1'..'9' selects LED1..LED9 (one LED active at a time).
// Sending '0' switches every LED off. All received bytes are echoed.
module Top_Module(
    input wire mclk,
    input wire [3:0] btn,
    input wire RxD,
    output wire TxD,
    output wire [6:0] a_to_g,
    output wire dp,
    output wire [3:0] an,
    output reg [9:1] LED
);
    wire clk25, clk190, clr, tdre, ready;
    wire rdrf, rdrf_clr, FE;
    wire [7:0] rx_data;

    assign clr = btn[3];  // BTNR: active-high reset

    clkdiv U1(.clk(mclk), .clr(clr), .clk190(clk190), .clk25(clk25));
    uart_rx U2(.RxD(RxD), .clk(clk25), .clr(clr),
               .rdrf_clr(rdrf_clr), .rdrf(rdrf),
               .rx_data(rx_data), .FE(FE));
    uart_tx U3(.clk(clk25), .clr(clr), .tx_data(rx_data),
               .ready(ready), .tdre(tdre), .TxD(TxD));
    test_rx_ctrl U4(.clk(clk25), .clr(clr), .rdrf(rdrf),
                    .rdrf_clr(rdrf_clr));
    test_tx_ctrl U5(.clk(clk25), .clr(clr), .go(rdrf_clr),
                    .tdre(tdre), .ready(ready));
    x7segb U6(.x(rx_data), .cclk(clk190), .clr(clr),
              .a_to_g(a_to_g), .an(an), .dp(dp));

    // In the existing RX controller, rdrf_clr is a one-clk25-cycle
    // acknowledgement pulse generated after reception of one byte.
    // Use that event, not the continuously held rx_data value.
    // Ignore bytes flagged with a framing error.
    always @(posedge clk25 or posedge clr) begin
        if (clr) begin
            LED <= 9'b0;
        end else if (rdrf_clr && !FE) begin
            case (rx_data)
                8'h30: LED <= 9'b000000000; // '0' -> all off
                8'h31: LED <= 9'b000000001; // '1' -> LED1
                8'h32: LED <= 9'b000000010; // '2' -> LED2
                8'h33: LED <= 9'b000000100; // '3' -> LED3
                8'h34: LED <= 9'b000001000; // '4' -> LED4
                8'h35: LED <= 9'b000010000; // '5' -> LED5
                8'h36: LED <= 9'b000100000; // '6' -> LED6
                8'h37: LED <= 9'b001000000; // '7' -> LED7
                8'h38: LED <= 9'b010000000; // '8' -> LED8
                8'h39: LED <= 9'b100000000; // '9' -> LED9
                default: ;                    // Other bytes, e.g. CR/LF: no change
            endcase
        end
    end
endmodule
