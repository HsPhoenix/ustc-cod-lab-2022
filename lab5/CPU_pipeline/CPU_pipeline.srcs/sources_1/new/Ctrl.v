`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/05/08 22:05:25
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


module control (
    input   [6:0] inst,
    output        jump,
    output        branch,
    output        mem_read,
    output        mem_write,
    output        alu_op,
    output        alu_src,
    output  [1:0] reg_src,
    output        reg_write
);
    wire add;
    wire addi;
    wire lw;
    wire sw;
    wire beq;
    wire jal;
    assign add  = (inst == 7'b0110011);
    assign addi = (inst == 7'b0010011);
    assign lw   = (inst == 7'b0000011);
    assign sw   = (inst == 7'b0100011);
    assign beq  = (inst == 7'b1100011);
    assign jal  = (inst == 7'b1101111);
    
    assign jump      = jal;
    assign branch    = beq;
    assign mem_read  = lw;
    assign mem_write = sw; 
    assign alu_op    = add | addi | lw | sw | beq;
    assign alu_src   = addi | lw | sw;
    assign reg_src   = {jal, lw};
    assign reg_write = add | addi | lw;
endmodule
