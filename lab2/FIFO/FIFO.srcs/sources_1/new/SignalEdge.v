`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/03/27 14:21:40
// Design Name: 
// Module Name: get_edge
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


module sig_edge(
    input  clk, // clock (100 MHz, posedge)
    input  a,   // input signal
    output s,   // sychronized signal
    output p    // signal edge
);
    reg a_reg_0;
    reg a_reg_1;
    reg a_reg_2;
    always @(posedge clk) begin
        a_reg_0 <= a;
        a_reg_1 <= a_reg_0;
        a_reg_2 <= a_reg_1;
    end
    assign s = a_reg_1;
    assign p = a_reg_1 & ~a_reg_2;
endmodule
