`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/05/08 22:11:28
// Design Name: 
// Module Name: ALU
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


module alu(
    input  [31:0] in_1,
    input  [31:0] in_2,
    input         op,
    output [31:0] out,
    output        eq
);
    assign out = (op == 1'b0) ? 32'h0 : in_1 + in_2;
    assign eq  = (op == 1'b0) ? 1'b0  : (in_1 == in_2);
endmodule
