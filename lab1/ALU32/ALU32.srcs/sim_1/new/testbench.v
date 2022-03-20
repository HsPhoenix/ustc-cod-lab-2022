`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/03/19 15:44:57
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
    parameter clk_sep = 1;
    parameter sep = 10;
    reg clk;
    reg [31:0] a;
    reg [31:0] b;
    reg [2:0] f;
    wire [31:0] y;
    wire z;
    main test(
        .clk(clk),
        .a(a),
        .b(b),
        .f(f),
        .y(y),
        .z(z)
    );
    initial begin
       clk = 1'b0;
       a = 32'ha5a5a5a5;
       b = 32'h5a5aa5a5;
       f = 3'b000;
    end
    always #(clk_sep) clk = ~clk;
    initial begin
        #(sep) f = 3'b001;
        #(sep) f = 3'b010;
        #(sep) f = 3'b011;
        #(sep) f = 3'b100;
        #(sep) f = 3'b101;
        #(sep) f = 3'b110;
        #(sep) f = 3'b111;
        #(sep) $finish;
    end
endmodule
