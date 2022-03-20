`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/03/16 12:30:38
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


module main #(parameter WIDTH = 6)
(
    input clk,
    input en,
    input [1:0] sel,
    input [WIDTH - 1:0] x,
    output reg [WIDTH - 1:0] y,
    output reg z
);
    // wire mapping
    wire ef, ea, eb;
    wire alu_z;
    wire [WIDTH - 1:0] alu_y;
    reg [2:0] f;
    reg [WIDTH - 1:0] a, b;
    decoder dec(
        .en(en),
        .sel(sel),
        .ef(ef),
        .ea(ea),
        .eb(eb)
    );
    alu #(.WIDTH(WIDTH)) alu1
    (
        .a(a),
        .b(b),
        .f(f),
        .y(alu_y),
        .z(alu_z)
    );
    // registers
    always @(posedge clk) begin    
        if (ef) f <= x[2:0];
        if (ea) a <= x;
        if (eb) b <= x;
        y <= alu_y;
        z <= alu_z;
    end
endmodule
