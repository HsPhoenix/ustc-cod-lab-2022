`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/05/22 15:59:37
// Design Name: 
// Module Name: MEM_WB
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


module mem_wb(
    input             clk,
    input             rst,
    input      [1:0]  EXMEM_reg_src,
    input             EXMEM_reg_write,
    input      [31:0] mem_out,
    input      [31:0] EXMEM_pc_next,
    input      [31:0] EXMEM_alu_out,
    input      [4:0]  EXMEM_rd,
    output reg [1:0]  MEMWB_reg_src,
    output reg        MEMWB_reg_write,
    output reg [31:0] MEMWB_mem_out,
    output reg [31:0] MEMWB_pc_next,
    output reg [31:0] MEMWB_alu_out,
    output reg [4:0]  MEMWB_rd
);
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            MEMWB_reg_src   <= 2'h0;
            MEMWB_reg_write <= 1'h0;
            MEMWB_mem_out   <= 32'h0;
            MEMWB_pc_next   <= 32'h0;
            MEMWB_alu_out   <= 32'h0;
            MEMWB_rd        <= 5'h0;
        end
        else begin
            MEMWB_reg_src   <= EXMEM_reg_src;
            MEMWB_reg_write <= EXMEM_reg_write;
            MEMWB_mem_out   <= mem_out;
            MEMWB_pc_next   <= EXMEM_pc_next;
            MEMWB_alu_out   <= EXMEM_alu_out;
            MEMWB_rd        <= EXMEM_rd;
        end
    end
endmodule
