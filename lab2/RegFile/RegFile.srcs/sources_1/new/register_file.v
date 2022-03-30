`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/03/22 22:26:38
// Design Name: 
// Module Name: register_file
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

// 32 * WIDTH Register File
module register_file #(
    parameter WIDTH = 32
) (
    input  clk,             // Clock (posedge)
    input  [4:0] ra0,       // Read address 0
    input  [4:0] ra1,       // Read address 1
    input  [4:0] wa,        // Write address
    input  we,              // Write enable
    input  [WIDTH-1:0] wd,  // Write data
    output [WIDTH-1:0] rd0, // Read data 0
    output [WIDTH-1:0] rd1  // Read data 1
);
    reg [WIDTH-1:0] regfile [0:31];
    assign rd0 = regfile[ra0];
    assign rd1 = regfile[ra1];
    always @(posedge clk) begin
        if (we) regfile[wa] <= wd;
    end
endmodule  //register_file
