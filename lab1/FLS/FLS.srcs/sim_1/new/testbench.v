`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/03/16 15:13:15
// Design Name: 
// Module Name: tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module tb();
    reg clk;
    reg rst;
    reg en;
    reg [6:0] d;
    wire [6:0] f;

    fls test(
        .clk(clk),
        .rst(rst),
        .en(en),
        .d(d),
        .f(f)
    );

    parameter timesep = 1;

    always #(timesep) clk = ~clk;

    initial begin
        clk = 1'b0;
        #200 $finish;
    end

    initial begin
        rst = 1'b1;
        #7 rst = 1'b0;
    end

    initial begin
        en = 1'b0;
        #2  en = 1'b1;
        #25 en = 1'b0;
        #10 en = 1'b1;
        #10 en = 1'b0;
        #10 en = 1'b1;
        #10 en = 1'b0; 
        #10 en = 1'b1;
        #10 en = 1'b0;
        #10 en = 1'b1;
        #10 en = 1'b0;
        #10 en = 1'b1;
    end

    initial begin
        d = 7'h02;
        #32 d = 7'h03;
        #20 d = 7'h04;
        #20 d = 7'h05;
        #20 d = 7'h06;
    end
endmodule
