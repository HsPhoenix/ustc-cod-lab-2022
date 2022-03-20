`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2022/03/16 10:04:00
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


module alu #(parameter WIDTH = 32)  // 数据位宽
(
    input [WIDTH - 1:0] a, b,       // 两操作数
    input [2:0] f,                  // 操作功能
    output reg [WIDTH - 1:0] y,         // 运算结果
    output z                        // 零标志
);
    assign z = (y == {WIDTH{1'h0}});
    always @(*) begin
        case (f)
            3'b000:
                y = a + b;
            3'b001:
                y = a - b;
            3'b010:
                y = a & b;
            3'b011:
                y = a | b;
            3'b100:
                y = a ^ b;
            default:
                y = {WIDTH{1'h0}};
        endcase
    end
endmodule
