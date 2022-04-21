`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/04/17 17:26:32
// Design Name: 
// Module Name: alu_control
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


module alu_control(
    input               funct7,
    input       [2:0]   funct3,
    input       [1:0]   opcode,
    output reg  [1:0]   funct
);
    always @(*) begin
        if (opcode[1]) begin
            funct = {1'b1, funct3[2]};
        end else if (opcode[0]) begin
            funct = {1'b0, funct7};
        end else    
            funct = 2'b00;
    end
endmodule
