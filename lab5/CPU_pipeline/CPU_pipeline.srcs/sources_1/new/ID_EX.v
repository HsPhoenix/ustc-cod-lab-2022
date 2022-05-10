`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/05/08 23:28:38
// Design Name: 
// Module Name: ID_EX
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


module id_ex(
    input             clk,
    input             rst,
    input             clr,
    input      [31:0] IFID_pc,
    input      [31:0] IFID_pc_next,
    input      [31:0] reg_1,
    input      [31:0] reg_2,
    input      [31:0] imm,
    input      [4:0]  rs_1,
    input      [4:0]  rs_2,
    input      [4:0]  rd,
    input      [31:0] ctrl,
    output reg [31:0] IDEX_pc,
    output reg [31:0] IDEX_pc_next,
    output reg [31:0] IDEX_reg_1,
    output reg [31:0] IDEX_reg_2,
    output reg [31:0] IDEX_imm,
    output reg [4:0]  IDEX_rs_1,
    output reg [4:0]  IDEX_rs_2,
    output reg [4:0]  IDEX_rd,
    output reg [31:0] IDEX_ctrl
);
    always @(posedge clk or posedge rst) begin
        if (rst | clr) begin
            IDEX_pc      <= 32'h0;
            IDEX_pc_next <= 32'h0;
            IDEX_reg_1   <= 32'h0;
            IDEX_reg_2   <= 32'h0;
            IDEX_imm     <= 32'h0;
            IDEX_rs_1    <= 5'h0;
            IDEX_rs_2    <= 5'h0;
            IDEX_rd      <= 5'h0;
            IDEX_ctrl    <= 32'h0;
        end
        else begin
            IDEX_pc      <= IFID_pc;
            IDEX_pc_next <= IFID_pc_next;
            IDEX_reg_1   <= reg_1;
            IDEX_reg_2   <= reg_2;
            IDEX_imm     <= imm;
            IDEX_rs_1    <= rs_1;
            IDEX_rs_2    <= rs_2;
            IDEX_rd      <= rd;
            IDEX_ctrl    <= ctrl;
        end
    end
endmodule
