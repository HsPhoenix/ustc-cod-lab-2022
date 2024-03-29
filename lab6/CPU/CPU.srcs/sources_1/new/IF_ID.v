`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/05/22 15:59:37
// Design Name: 
// Module Name: IF_ID
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


module if_id(
    input             clk,
    input             rst,
    input             en,
    input             clr,
    input      [31:0] pc,
    input      [31:0] pc_next,
    input             btb_hit,
    input      [31:0] inst,
    output reg [31:0] IFID_pc,
    output reg [31:0] IFID_pc_next,
    output reg        IFID_btb_hit,
    output reg [31:0] IFID_inst
);
    always @(posedge clk or posedge rst) begin
        if (rst | clr) begin
            IFID_pc      <= 32'h0;
            IFID_pc_next <= 32'h0;
            IFID_btb_hit <= 1'h0;
            IFID_inst    <= 32'h0;
        end
        else if (en) begin
            IFID_pc      <= pc;
            IFID_pc_next <= pc_next;
            IFID_btb_hit <= btb_hit;
            IFID_inst    <= inst;
        end
    end
endmodule
