`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/03/19 15:39:44
// Design Name: 
// Module Name: main
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


module main(
    input clk,
    input [31:0] a, b,
    input [2:0] f,
    output reg [31:0] y,
    output reg z
);
    // wire mapping
    reg [31:0] alu_a, alu_b;
    reg [2:0] alu_f;
    wire [31:0] alu_y;
    wire alu_z;
    alu #(.WIDTH(32)) alu32(
        .a(alu_a),
        .b(alu_b),
        .f(alu_f),
        .y(alu_y),
        .z(alu_z)
    );

    // registers
    always @(posedge clk) begin
        alu_a <= a;
        alu_b <= b;
        alu_f <= f;
        y <= alu_y;
        z <= alu_z;
    end
endmodule
