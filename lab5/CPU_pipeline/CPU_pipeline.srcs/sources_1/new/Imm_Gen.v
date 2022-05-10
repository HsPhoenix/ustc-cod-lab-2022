`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/05/08 22:11:28
// Design Name: 
// Module Name: Imm_Gen
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


module imm_gen(
    input      [31:0] inst,
    output reg [31:0] imm
);
    always @(*) begin
        case (inst[6:0])
            7'b0000011,
            7'b0010011: // lw, addi
                imm = {{21{inst[31]}}, inst[30:20]}; 
            7'b0100011: // sw
                imm = {{21{inst[31]}}, inst[30:25], inst[11:7]}; 
            7'b1100011: // beq
                imm = {{20{inst[31]}}, inst[7], inst[30:25], inst[11:8], 1'b0};
            7'b1101111: // jal
                imm = {{12{inst[31]}}, inst[19:12], inst[20], inst[30:21], 1'b0};
            default:
                imm = 31'h0;
        endcase
    end
endmodule
