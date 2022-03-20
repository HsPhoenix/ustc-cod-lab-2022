`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/03/16 12:15:00
// Design Name: 
// Module Name: decoder
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


module decoder(
    input en,
    input [1:0] sel,
    output ea, eb, ef
);
    assign ea = en & (sel == 2'b00);
    assign eb = en & (sel == 2'b01);
    assign ef = en & (sel == 2'b10);
endmodule
