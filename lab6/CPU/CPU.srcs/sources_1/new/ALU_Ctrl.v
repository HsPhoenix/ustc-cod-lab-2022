`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/05/22 17:38:38
// Design Name: 
// Module Name: alu_control
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// alu_funct controls alu operation. alu_funct[2:0] = funct3 
// 4'b0000 | add                    | equal            |
// 4'b0001 | shift left logical     | not equal        |
// 4'b0010 | set less than          | -                |
// 4'b0011 | set less than unsigned | -                |
// 4'b0100 | xor                    | less             |
// 4'b0101 | shift right logical    | greater & equal  |
// 4'b0110 | or                     | less unsigned    |
// 4'b0111 | and                    | greater unsigned |
// 4'b1000 | sub                    | -                |
// 4'b1101 | shift right arithmetic | -                |
// 4'b1111 | add                    | -                |
//
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module alu_control(
    input      [1:0] alu_op,
    input      [2:0] funct3,
    input            funct7,
    output reg [3:0] alu_funct
);
    always @(*) begin
        case (alu_op)
            2'b00:   alu_funct = 4'b1111;
            2'b01:   alu_funct = {funct7, funct3};
            2'b10:   alu_funct = {((funct3 == 3'b101) & funct7), funct3};
            2'b11:   alu_funct = {1'b0, funct3}; 
            default: alu_funct = 4'b1111;
        endcase
    end
endmodule
