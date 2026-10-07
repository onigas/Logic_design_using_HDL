`timescale 1ns / 1ps

module test_tx_ctrl(input wire clk, // clock, synchronize communication
                    input wire clr, // reset
                    input wire go, // indikálja az adatküldést, értéke attól függ, hogy történt-e gombnyomás
                                    // ~go ideig a wtgo állapotban tartózkodunk, go-ra lépünk át
                    input wire tdre, //addig maradunk a wttdre (lásd lejjebb a paramter deklarálásnál) állapotban, míg tdre állapota ~tdre
                    output reg ready //Megmondja, hogy az uart_tx befejezte-e az adatok továbbítását
                   );
                    
    reg[1:0] state; // az aktuális állapotot tárolja. Mivel 4 = 2^2 állapotunk lesz, ezért elég egy 2 bites változó
                    
    //A modulban elõforduló lehetséges állapotok
    parameter wtgo = 2'b00, wttdre = 2'b01, load = 2'b10, wtngo = 2'b11;
     
    always @(posedge clk or posedge clr)
        begin
            if(clr == 1)
                begin
                    state <= wtgo;
                    ready <= 0;
                end
            else
                case(state)
                    wtgo:
                        if(go == 0)
                            begin
                                state <= wtgo;
                                ready <= 0;
                            end
                        else
                            begin
                                ready <= 0;
                                state <= wttdre;
                            end
                    wttdre:
                        if(tdre == 0)
                            begin
                                state <= wttdre;
                                ready <= 0;
                            end
                        else
                            begin
                                state <= load;
                                ready <= 0;
                            end
                    load:
                        begin
                            ready <= 1;
                            state <= wtngo;
                        end
                    wtngo:
                        if(go == 1)
                            begin
                                state <= wtngo;
                                ready <= 0;
                            end
                        else
                            begin
                                ready <= 0;
                                state <= wtgo;
                            end
                endcase
        end                
endmodule
