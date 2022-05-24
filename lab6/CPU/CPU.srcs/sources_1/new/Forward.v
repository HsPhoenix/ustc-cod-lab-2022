`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/05/22 15:59:37
// Design Name: 
// Module Name: Forward
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


module forward(
    input      [4:0]  IDEX_rs_1,
    input      [4:0]  IDEX_rs_2,
    input             EXMEM_reg_write,
    input      [4:0]  EXMEM_rd,
    input             MEMWB_reg_write,
    input      [4:0]  MEMWB_rd,
    output reg [1:0]  forward_1,
    output reg [1:0]  forward_2
);
    always @(*) begin
        if (EXMEM_reg_write & (EXMEM_rd != 5'h0) & (EXMEM_rd == IDEX_rs_1)) 
            forward_1 = 2'b10;
        else if (MEMWB_reg_write & (MEMWB_rd != 5'h0) & (MEMWB_rd == IDEX_rs_1))
            forward_1 = 2'b01;
        else
            forward_1 = 2'b00;
    end
    always @(*) begin
        if (EXMEM_reg_write & (EXMEM_rd != 5'h0) & (EXMEM_rd == IDEX_rs_2)) 
            forward_2 = 2'b10;
        else if (MEMWB_reg_write & (MEMWB_rd != 5'h0) & (MEMWB_rd == IDEX_rs_2))
            forward_2 = 2'b01;
        else
            forward_2 = 2'b00;
    end
endmodule
