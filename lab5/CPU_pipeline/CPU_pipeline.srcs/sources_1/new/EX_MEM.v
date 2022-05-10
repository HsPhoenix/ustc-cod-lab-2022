`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/05/08 23:28:38
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
    input      [31:0] alu_out,
    input      [31:0] IDEX_pc_next,
    input      [31:0] EX_reg_2,
    input      [4:0]  IDEX_rd,
    input      [31:0] IDEX_ctrl,
    output reg [31:0] EXMEM_alu_out,
    output reg [31:0] EXMEM_pc_next,
    output reg [31:0] EXMEM_reg_2,
    output reg [4:0]  EXMEM_rd,
    output reg [31:0] EXMEM_ctrl
);
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            EXMEM_alu_out <= 32'h0;
            EXMEM_pc_next <= 32'h0;
            EXMEM_reg_2   <= 32'h0;
            EXMEM_rd      <= 5'h0;
            EXMEM_ctrl    <= 32'h0;
        end 
        else begin
            EXMEM_alu_out <= alu_out;
            EXMEM_pc_next <= IDEX_pc_next;
            EXMEM_reg_2   <= EX_reg_2;
            EXMEM_rd      <= IDEX_rd;
            EXMEM_ctrl    <= IDEX_ctrl;
        end
    end
endmodule
