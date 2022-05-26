`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/05/22 15:59:37
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
    input             jump,
    input             branch,
    input      [3:0]  alu_funct,
    input      [1:0]  alu_1_src,
    input             alu_2_src,
    input             pc_add_src,
    input             mem_read,
    input             mem_write,
    input      [1:0]  reg_src,
    input             reg_write,
    input      [31:0] IFID_pc,
    input      [31:0] IFID_pc_next,
    input             IFID_btb_hit,
    input      [2:0]  funct3,
    input      [31:0] reg_1,
    input      [31:0] reg_2,
    input      [31:0] imm,
    input      [4:0]  rs_1,
    input      [4:0]  rs_2,
    input      [4:0]  rd,
    output reg        IDEX_jump,
    output reg        IDEX_branch,
    output reg [3:0]  IDEX_alu_funct,
    output reg [1:0]  IDEX_alu_1_src,
    output reg        IDEX_alu_2_src,
    output reg        IDEX_pc_add_src,
    output reg        IDEX_mem_read,
    output reg        IDEX_mem_write,
    output reg [1:0]  IDEX_reg_src,
    output reg        IDEX_reg_write,
    output reg [31:0] IDEX_pc,
    output reg [31:0] IDEX_pc_next,
    output reg        IDEX_btb_hit,
    output reg [2:0]  IDEX_funct3,
    output reg [31:0] IDEX_reg_1,
    output reg [31:0] IDEX_reg_2,
    output reg [31:0] IDEX_imm,
    output reg [4:0]  IDEX_rs_1,
    output reg [4:0]  IDEX_rs_2,
    output reg [4:0]  IDEX_rd
);
    always @(posedge clk or posedge rst) begin
        if (rst | clr) begin
            IDEX_jump       <= 1'h0;
            IDEX_branch     <= 1'h0;
            IDEX_alu_funct  <= 4'h0;
            IDEX_alu_1_src  <= 2'h0;
            IDEX_alu_2_src  <= 1'h0;
            IDEX_pc_add_src <= 1'h0;
            IDEX_mem_read   <= 1'h0;
            IDEX_mem_write  <= 1'h0;
            IDEX_reg_src    <= 2'h0;
            IDEX_reg_write  <= 1'h0;
            IDEX_pc         <= 32'h0;
            IDEX_pc_next    <= 32'h0;
            IDEX_btb_hit    <= 1'h0;
            IDEX_funct3     <= 3'h0;
            IDEX_reg_1      <= 32'h0;
            IDEX_reg_2      <= 32'h0;
            IDEX_imm        <= 32'h0;
            IDEX_rs_1       <= 5'h0;
            IDEX_rs_2       <= 5'h0;
            IDEX_rd         <= 5'h0;
        end
        else begin
            IDEX_jump       <= jump;
            IDEX_branch     <= branch;
            IDEX_alu_funct  <= alu_funct;
            IDEX_alu_1_src  <= alu_1_src;
            IDEX_alu_2_src  <= alu_2_src;
            IDEX_pc_add_src <= pc_add_src;
            IDEX_mem_read   <= mem_read;
            IDEX_mem_write  <= mem_write;
            IDEX_reg_src    <= reg_src;
            IDEX_reg_write  <= reg_write;
            IDEX_pc         <= IFID_pc;
            IDEX_pc_next    <= IFID_pc_next;
            IDEX_btb_hit    <= IFID_btb_hit;
            IDEX_funct3     <= funct3;
            IDEX_reg_1      <= reg_1;
            IDEX_reg_2      <= reg_2;
            IDEX_imm        <= imm;
            IDEX_rs_1       <= rs_1;
            IDEX_rs_2       <= rs_2;
            IDEX_rd         <= rd;
        end
    end
endmodule

