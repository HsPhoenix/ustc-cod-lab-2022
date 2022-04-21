`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/04/17 18:03:34
// Design Name: 
// Module Name: regfile
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


module regfile #(
    parameter WIDTH = 32
) (
    input               clk,
    input               we,
    input   [4:0]       ra1,
    input   [4:0]       ra2,
    input   [4:0]       ra3,
    input   [4:0]       wa,
    input   [WIDTH-1:0] wd,
    output  [WIDTH-1:0] rd1,
    output  [WIDTH-1:0] rd2,
    output  [WIDTH-1:0] rd3
);
    reg [WIDTH-1:0] rf [31:0];
    assign rd1 = (ra1 == 5'h0) ? 0 : rf[ra1];
    assign rd2 = (ra2 == 5'h0) ? 0 : rf[ra2];
    assign rd3 = (ra3 == 5'h0) ? 0 : rf[ra3];

    always @(posedge clk) begin
        if (we) rf[wa] <= wd;
    end
endmodule
