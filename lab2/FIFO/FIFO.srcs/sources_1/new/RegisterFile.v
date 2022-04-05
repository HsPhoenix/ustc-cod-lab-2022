`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/03/23 18:27:32
// Design Name: 
// Module Name: reg_file
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

// A 8*16 register file
module reg_file (
    input  clk,         // clock (posedge)
    input  [2:0] ra0,   // read address 0
    input  [2:0] ra1,   // read address 1
    input  we,          // write enable
    input  [2:0] wa,    // write address
    input  [3:0] wd,    // write data
    output [3:0] rd0,   // read data 0
    output [3:0] rd1    // read data 1
);
    reg [3:0] regfile [0:7];
    assign rd0 = regfile[ra0];
    assign rd1 = regfile[ra1];
    always @(posedge clk) begin
        if (we) regfile[wa] = wd;
    end
endmodule  //reg_file
