`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/05/08 23:31:12
// Design Name: 
// Module Name: hazard
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
    input       pc_src,
    input [4:0] IDEX_rd,
    input [1:0] IDEX_reg_src,
    output reg  enable,
    output      IFID_flush,
    output      IDEX_flush
);
    always @(*) begin
        if ((IDEX_reg_src == 2'b01) & 
            (IDEX_rd != 5'h0) & 
            (IDEX_rd == rs_1 | IDEX_rd == rs_2)
        ) 
            enable = 1'b0;
        else
            enable = 1'b1;
    end
    assign IFID_flush = pc_src;
    assign IDEX_flush = ~enable | pc_src;
endmodule
