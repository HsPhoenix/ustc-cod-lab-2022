`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/05/22 15:59:37
// Design Name: 
// Module Name: ALU
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// alu_funct controls alu operation.
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
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module alu(
    input      [31:0] in_1,
    input      [31:0] in_2,
    input      [3:0]  funct,
    output reg [31:0] arithmetic,
    output reg        comparision
);
    always @(*) begin
        case (funct)
            4'b0000: arithmetic = in_1 + in_2;
            4'b0001: arithmetic = in_1 << in_2; 
            4'b0010: arithmetic = $signed(in_1) < $signed(in_2);
            4'b0011: arithmetic = in_1 < in_2;
            4'b0100: arithmetic = in_1 ^ in_2;
            4'b0101: arithmetic = in_1 >> in_2;
            4'b0110: arithmetic = in_1 | in_2;
            4'b0111: arithmetic = in_1 & in_2;
            4'b1000: arithmetic = in_1 - in_2;
            4'b1101: arithmetic = $signed(in_1) >>> in_2;
            4'b1111: arithmetic = in_1 + in_2;
            default: arithmetic = 32'h0;
        endcase
    end

    always @(*) begin
        case (funct)
            4'b0000: comparision = in_1 == in_2;
            4'b0001: comparision = in_1 != in_2;
            4'b0100: comparision = $signed(in_1) < $signed(in_2);
            4'b0101: comparision = $signed(in_1) >= $signed(in_2);
            4'b0110: comparision = in_1 < in_2;
            4'b0111: comparision = in_1 >= in_2;
            default: comparision = 1'b0;
        endcase
    end
endmodule
