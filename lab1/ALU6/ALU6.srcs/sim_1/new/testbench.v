`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/03/16 12:51:20
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
    parameter timesep = 100;
    parameter timesep_clk = 10;
    parameter width = 6;

    reg clk, en;
    reg [1:0] sel;
    reg [width-1:0] x;

    wire [width-1:0] y;
    wire z;

    main #(.WIDTH(width)) testbench(
        .clk(clk),
        .en(en),
        .sel(sel),
        .x(x),
        .y(y),
        .z(z)
    );
    always #(timesep_clk) clk = ~clk;
    initial begin
        clk = 1'b0;
        en = 1'b0;
        sel = 2'b11;
        x = 6'h00;
        #(timesep)
        en = 1'b1;
        #(timesep)
        sel = 2'b10;
        x = 6'h00;
        #(timesep)
        sel = 2'b00;
        x = 6'h14;
        #(timesep)
        sel = 2'b01;
        x = 6'h08;
        #(timesep)
        sel = 2'b10;
        x = 6'h01;
        #(timesep)
        $finish;
    end
endmodule
