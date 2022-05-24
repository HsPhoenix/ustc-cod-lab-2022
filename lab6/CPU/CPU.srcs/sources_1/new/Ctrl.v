`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/05/22 15:59:37
// Design Name: 
// Module Name: Ctrl
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


module control(
    input  [6:0] inst,
    output       jump,
    output       branch,
    output [1:0] alu_op,     // 2'b11 for branch, 2'b10 for imm, 2'b01 for reg
    output [1:0] alu_1_src,  // 2'b10 for auipc, 2'b01 for lui
    output       alu_2_src,
    output       pc_add_src, // 1'b1 for jalr
    output       mem_read,
    output       mem_write,
    output [1:0] reg_src,
    output       reg_write
);
    wire lui;
    wire auipc;
    wire load;
    wire store;
    wire reg_arith;
    wire imm_arith;
    assign lui       = (inst == 7'b0110111);
    assign auipc     = (inst == 7'b0010111);
    assign load      = (inst == 7'b0000011);
    assign store     = (inst == 7'b0100011);
    assign reg_arith = (inst == 7'b0110011);
    assign imm_arith = (inst == 7'b0010011);

    assign jump       = (inst == 7'b1101111) | (inst == 7'b1100111);
    assign branch     = (inst == 7'b1100011);
    assign alu_op     = {(imm_arith | branch), (reg_arith | branch)};
    assign alu_1_src  = {auipc, lui};
    assign alu_2_src  = (imm_arith | load | store | lui | auipc);
    assign pc_add_src = (inst == 7'b1100111);
    assign mem_read   = (load);
    assign mem_write  = (store);
    assign reg_src    = {jump, load};
    assign reg_write  = (reg_arith | imm_arith | load | auipc | lui | jump);
endmodule
