`timescale 1ns / 1ps

module knightrider(
    input clk,
    input rst,
    input [1:0] mode,
    output [7:0] led
    );

parameter [20:0] speed=21'd2_097_100;
parameter [14:0] delay1=15'd19_512;
parameter [14:0] delay2=15'd15_512;
parameter [7:0] limit=8'd128;

wire inc = 1'b0;
wire dec = 1'b0;
reg [7:0] data0=8'b0;
reg [7:0] data1=8'b0;
reg [7:0] data2=8'b0;
reg [7:0] data3=8'b0;
reg [7:0] data4=8'b0;
reg [7:0] data5=8'b0;
reg [7:0] data6=8'b0;
reg [7:0] data7=8'b0;
reg [20:0] krt_cnt=21'd0;
reg [14:0] del_cnt=15'd0;
reg [7:0] active=8'd1;
reg direction=1;
reg direction_block=1;
reg [7:0] slow=8'd0;

wire kr_tick=(speed==krt_cnt);
wire del_tick=mode[1]?(delay1==del_cnt):(delay2==del_cnt);
wire [15:0] disp_data;

pwm pwm_0 (.clk(clk),.rst(rst),.duty(data0),.led(led[0]));
pwm pwm_1 (.clk(clk),.rst(rst),.duty(data1),.led(led[1]));
pwm pwm_2 (.clk(clk),.rst(rst),.duty(data2),.led(led[2]));
pwm pwm_3 (.clk(clk),.rst(rst),.duty(data3),.led(led[3]));
pwm pwm_4 (.clk(clk),.rst(rst),.duty(data4),.led(led[4]));
pwm pwm_5 (.clk(clk),.rst(rst),.duty(data5),.led(led[5]));
pwm pwm_6 (.clk(clk),.rst(rst),.duty(data6),.led(led[6]));
pwm pwm_7 (.clk(clk),.rst(rst),.duty(data7),.led(led[7]));

always @(posedge clk)
begin
    if(rst|kr_tick)
        krt_cnt<=krt_cnt^krt_cnt;
    else
        krt_cnt<=krt_cnt+1;
end

always @(posedge clk)
begin
    if(rst)
    begin
        data0<=data0^data0;
        data1<=data1^data1;
        data2<=data2^data2;
        data3<=data3^data3;
        data4<=data4^data4;
        data5<=data5^data5;
        data6<=data6^data6;
        data7<=data7^data7;
        active<=8'd1;
        direction<=1;
        direction_block<=1;
        del_cnt<=del_cnt^del_cnt;
        slow<=slow^slow;
    end
    else if(mode[0])
    begin
        if(inc)
        begin
            data0<=data0+1; data1<=data1+1; data2<=data2+1; data3<=data3+1;
            data4<=data4+1; data5<=data5+1; data6<=data6+1; data7<=data7+1;
        end
        else if(dec)
        begin
            data0<=data0-1; data1<=data1-1; data2<=data2-1; data3<=data3-1;
            data4<=data4-1; data5<=data5-1; data6<=data6-1; data7<=data7-1;
        end
    end
    else
    begin
        if(kr_tick)
        begin
            if(direction) active<=active<<1;
            else active<=active>>1;
            if(((active==8'b0000_0010)|(active==8'b0100_0000))&~direction_block)
            begin
                direction_block<=~direction_block;
                direction<=~direction;
            end
            else if(active==8'b0001_0000)
                direction_block<=~direction_block;
            case(active)
                8'd1: data0<=8'hFF;
                8'd2: data1<=8'hFF;
                8'd4: data2<=8'hFF;
                8'd8: data3<=8'hFF;
                8'd16: data4<=8'hFF;
                8'd32: data5<=8'hFF;
                8'd64: data6<=8'hFF;
                8'd128: data7<=8'hFF;
            endcase
        end
        else
        begin
            if(del_tick)
            begin
                del_cnt<=del_cnt^del_cnt;
                if(|data0) begin if(data0>=limit | (slow[0]|mode[1])) data0<=data0-1; if(data0<limit) slow[0]<=~slow[0]; end
                if(|data1) begin if(data1>=limit | (slow[1]|mode[1])) data1<=data1-1; if(data1<limit) slow[1]<=~slow[1]; end
                if(|data2) begin if(data2>=limit | (slow[2]|mode[1])) data2<=data2-1; if(data2<limit) slow[2]<=~slow[2]; end
                if(|data3) begin if(data3>=limit | (slow[3]|mode[1])) data3<=data3-1; if(data3<limit) slow[3]<=~slow[3]; end
                if(|data4) begin if(data4>=limit | (slow[4]|mode[1])) data4<=data4-1; if(data4<limit) slow[4]<=~slow[4]; end
                if(|data5) begin if(data5>=limit | (slow[5]|mode[1])) data5<=data5-1; if(data5<limit) slow[5]<=~slow[5]; end
                if(|data6) begin if(data6>=limit | (slow[6]|mode[1])) data6<=data6-1; if(data6<limit) slow[6]<=~slow[6]; end
                if(|data7) begin if(data7>=limit | (slow[7]|mode[1])) data7<=data7-1; if(data7<limit) slow[7]<=~slow[7]; end
            end
            else
                del_cnt<=del_cnt+1;
        end
    end
end

endmodule
