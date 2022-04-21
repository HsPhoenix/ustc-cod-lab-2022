`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/04/17 17:03:03
// Design Name: 
// Module Name: alu
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
    input       [31:0] op1,
    input       [31:0] op2,
    input       [1:0]  funct,
    output  reg [31:0] result,
    output  reg        br_tk
);
    always @(*) begin
        if (funct[1]) begin
            case (funct[0])
            1'b0: br_tk = (op1 == op2);
            1'b1: br_tk = (op1 <  op2);
            endcase
            result = 32'h0;
        end else begin
            case (funct[0])
            1'b0: result = op1 + op2;
            1'b1: result = op1 - op2;
            endcase
            br_tk = 1'b0;
        end
    end
endmodule
