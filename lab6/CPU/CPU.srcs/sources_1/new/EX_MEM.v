`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/05/22 15:59:37
// Design Name: 
// Module Name: EX_MEM
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


module ex_mem(
    input             clk,
    input             rst,
    input             IDEX_mem_read,
    input             IDEX_mem_write,
    input      [1:0]  IDEX_reg_src,
    input             IDEX_reg_write,
    input      [2:0]  IDEX_funct3,
    input      [31:0] alu_out,
    input      [31:0] IDEX_pc_next,
    input      [31:0] EX_reg_2,
    input      [4:0]  IDEX_rd,
    output reg        EXMEM_mem_read,
    output reg        EXMEM_mem_write,
    output reg [1:0]  EXMEM_reg_src,
    output reg        EXMEM_reg_write,
    output reg [2:0]  EXMEM_funct3,
    output reg [31:0] EXMEM_alu_out,
    output reg [31:0] EXMEM_pc_next,
    output reg [31:0] EXMEM_reg_2,
    output reg [4:0]  EXMEM_rd
);
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            EXMEM_mem_read  <= 1'h0;
            EXMEM_mem_write <= 1'h0;
            EXMEM_reg_src   <= 2'h0;
            EXMEM_reg_write <= 1'h0;
            EXMEM_funct3    <= 3'h0;
            EXMEM_alu_out   <= 32'h0;
            EXMEM_pc_next   <= 32'h0;
            EXMEM_reg_2     <= 32'h0;
            EXMEM_rd        <= 5'h0;
        end 
        else begin
            EXMEM_mem_read  <= IDEX_mem_read;
            EXMEM_mem_write <= IDEX_mem_write;
            EXMEM_reg_src   <= IDEX_reg_src;
            EXMEM_reg_write <= IDEX_reg_write;
            EXMEM_funct3    <= IDEX_funct3;
            EXMEM_alu_out   <= alu_out;
            EXMEM_pc_next   <= IDEX_pc_next;
            EXMEM_reg_2     <= EX_reg_2;
            EXMEM_rd        <= IDEX_rd;
        end
    end
endmodule
