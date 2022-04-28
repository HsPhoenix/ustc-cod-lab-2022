`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/04/17 23:16:37
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
    reg         clk;
    reg         btn;
    reg   [7:0] sw;
    wire  [7:0] led;
    wire  [2:0] an;
    wire  [3:0] d;

    main test(
        .clk(clk),
        .btn(btn),
        .sw(sw),
        .led(led),
        .an(an),
        .d(d)
    );

    initial begin
        clk = 0;
        btn = 0;
        sw  = 8'b10000000;
        #2 sw[7:6] = 2'b01;
        #200 $finish;
    end
    always #1 clk = ~clk;
    always #8 sw[5] = ~sw[5];
endmodule