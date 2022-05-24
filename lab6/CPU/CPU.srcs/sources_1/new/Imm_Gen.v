`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/05/22 15:59:37
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
            7'b0110111, // lui
            7'b0010111: // auipc
                imm = {inst[31:12], 12'h0000};
            
            7'b1101111: // jal
                imm = {{12{inst[31]}}, inst[19:12], inst[20], inst[30:21], 1'b0};
            
            7'b1100011: // branch
                imm = {{20{inst[31]}}, inst[7], inst[30:25], inst[11:8], 1'b0};

            7'b1100111, // jalr
            7'b0000011: // load
                imm = {{21{inst[31]}}, inst[30:20]};

            7'b0010011: // imm arithmetic
                imm = (inst[13:12] == 2'b01) ? 
                      {27'h0, inst[24:20]} :
                      {{21{inst[31]}}, inst[30:20]};

            7'b0100011: // store
                imm = {{21{inst[31]}}, inst[30:25], inst[11:7]}; 

            default:
                imm = 32'h0;
        endcase
    end
endmodule
