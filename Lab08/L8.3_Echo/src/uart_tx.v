`timescale 1ns / 1ps

module uart_tx( input wire clk, // clock, synchronize communication
                input wire clr, // reset
                input wire[7:0] tx_data, // Az adat, melyet a modulnak továbbítania kell a soros porton 
                input wire ready, // mikor a változó értéke HIGH, az adat (tx_data) továbbítódik a TxD-n keresztül, az LSB-vel kezdõdõen
                output reg tdre, //A regiszter jelzi (HIGH), mikor fejezõdött be az adatátvitel
                output reg TxD // Az átvitel akkor kezdõdik, mikor a TxD 1 bitidõ hosszan HIGH állapotból LOW állapotba megy át. Függ a baud rate-tõl
              );
    
    // A tervezési mintát legeffektívebben állapotgépekkel tudjuk elkészíteni
    reg[2:0] state; // jelöli, hogy épp melyik állapotban járunk 
                    // 5 állapotunk van, mely 2^3-1 féle lehetõség kombinációja, ezért 3 bitesre választottuk a változót.
                    
    // A lehetséges állapotok
    parameter mark = 3'b000, start = 3'b001, delay = 3'b010, shift = 3'b011, stop = 3'b100;
    
    reg[7:0] txbuff; // a továbbítandó adat, amely 8 bit hosszú
    reg[11:0] baud_count; // órajel ciklus számlálásra használjuk, amíg el nem éri a bitidõt.
                          //minden bit elküldése után nullázódik az értéke, és újrakezdi a számlálást
    reg[3:0] bit_count; // számlálja, hány bitet küldtünk át
    parameter bit_time = 12'hA28; // baud 9600
    
    always @(posedge clk or posedge clr)
        begin // begin 1
            if(clr == 1) // if clr 
                begin // begin 2
                    state <= mark;
                    txbuff <= 0;
                    baud_count <= 0;
                    bit_count <= 0;
                    TxD <= 1;
                end // begin 2 end
            else // if clr else
                case(state)
                    mark:
                        begin // begin mark
                            bit_count <= 0;
                            tdre <= 1;
                            if(ready == 0) // if ready
                                begin // begin ready
                                    state <= mark;
                                    txbuff <= tx_data;
                                end // begin end ready
                            else // if ready else
                                begin
                                    baud_count <= 0;
                                    state <= start;
                                end
                        end
                    start:
                        begin
                            baud_count <= 0;
                            TxD <= 0;
                            tdre <= 0;
                            state <= delay;
                        end
                    delay:
                        begin
                            tdre <= 0;
                            if(baud_count >= bit_time)
                                begin
                                    baud_count <= 0;
                                    if(bit_count < 8)
                                        state <= shift;
                                    else
                                        state <= stop;
                                end
                            else
                                begin
                                    baud_count <= baud_count+1;
                                    state <= delay;
                                end
                            end
                     shift:
                        begin
                            tdre <= 0;
                            TxD <= txbuff[0];
                            txbuff[6:0] <= txbuff[7:1];
                            bit_count <= bit_count+1;
                            state <= delay;
                        end
                     stop:
                        begin
                            tdre <= 0;
                            TxD <= 1;
                            if(baud_count >= bit_time)
                                begin
                                    baud_count <= 0;
                                    state <= mark;
                                end
                            else
                                begin
                                    baud_count <= baud_count+1;
                                    state <= stop;
                                end
                         end
                 endcase
         end 
    
endmodule