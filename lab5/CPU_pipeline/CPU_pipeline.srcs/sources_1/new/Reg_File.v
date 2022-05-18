`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/05/08 22:11:28
// Design Name: 
// Module Name: Reg_File
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


module regfile (
    input             clk,
    input             we,
    input      [4:0]  ra1,
    input      [4:0]  ra2,
    input      [4:0]  ra3,
    input      [4:0]  wa,
    input      [31:0] wd,
    output reg [31:0] rd1,
    output reg [31:0] rd2,
    output reg [31:0] rd3
);
    reg [31:0] rf [31:0];

    always @(posedge clk) begin
        if (we) rf[wa] <= wd;
    end

    always @(*) begin
        if (ra1 == 5'h0)    rd1 = 32'h0;
        else if (ra1 == wa) rd1 = wd;
        else                rd1 = rf[ra1];
    end

    always @(*) begin
        if (ra2 == 5'h0)    rd2 = 32'h0;
        else if (ra2 == wa) rd2 = wd;
        else                rd2 = rf[ra2];
    end

    always @(*) begin
        if (ra3 == 5'h0)    rd3 = 32'h0;
        else if (ra3 == wa) rd3 = wd;
        else                rd3 = rf[ra3];
    end
endmodule
