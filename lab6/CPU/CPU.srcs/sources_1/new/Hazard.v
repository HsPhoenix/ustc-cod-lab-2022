`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/05/22 15:59:37
// Design Name: 
// Module Name: Hazard
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


module hazard(
    input [4:0] rs_1,
    input [4:0] rs_2,
    input       btb_fail,
    input       IDEX_jump,
    input [4:0] IDEX_rd,
    input       IDEX_mem_read,
    output reg  enable,
    output      IFID_flush,
    output      IDEX_flush
);
    always @(*) begin
        if ((IDEX_mem_read) & (IDEX_rd != 5'h0) & 
            (IDEX_rd == rs_1 | IDEX_rd == rs_2)
        ) 
            enable = 1'b0;
        else
            enable = 1'b1;
    end
    assign IFID_flush = btb_fail | IDEX_jump;
    assign IDEX_flush = ~enable | btb_fail | IDEX_jump;
endmodule

