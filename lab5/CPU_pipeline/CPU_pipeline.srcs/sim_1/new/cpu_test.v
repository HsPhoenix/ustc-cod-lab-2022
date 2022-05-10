`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/05/10 15:59:28
// Design Name: 
// Module Name: cpu_test
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


module tb();
    reg         clk;
    reg         rst;
    reg  [7:0]  dbg_addr;
    reg  [31:0] io_din;
    wire [7:0]  io_addr;
    wire [31:0] io_dout;
    wire        io_we;
    wire [31:0] rf_data;
    wire [31:0] m_data;
    wire [31:0] pc;
    wire [31:0] pc_in;
    wire [31:0] IFID_pc;
    wire [31:0] IFID_inst;
    wire [31:0] IDEX_pc;
    wire [31:0] IDEX_reg_1;
    wire [31:0] IDEX_reg_2;
    wire [31:0] IDEX_imm;
    wire [4:0]  IDEX_rd;
    wire [31:0] IDEX_ctrl;
    wire [31:0] EXMEM_alu_out;
    wire [31:0] EXMEM_reg_2;
    wire [4:0]  EXMEM_rd;
    wire [31:0] EXMEM_ctrl;
    wire [31:0] MEMWB_alu_out;
    wire [31:0] MEMWB_mem_out;
    wire [4:0]  MEMWB_rd;
    wire [31:0] MEMWB_ctrl;

    initial begin
        clk      <= 1'b0;
        rst      <= 1'b1;
        dbg_addr <= 8'h06;
        io_din   <= 32'h0;
        #2
        rst      <= 1'b0;
    end
    always #1 clk = ~clk;
    
    cpu CPU (
        .clk            (clk),
        .rst            (rst),
        .dbg_addr       (dbg_addr),
        .io_addr        (io_addr),
        .io_din         (io_din),
        .io_dout        (io_dout),
        .io_we          (io_we),
        .rf_data        (rf_data),
        .m_data         (m_data),
        .pc             (pc),
        .pc_in          (pc_in),
        .IFID_pc        (IFID_pc),
        .IFID_inst      (IFID_inst),
        .IDEX_pc        (IDEX_pc),
        .IDEX_reg_1     (IDEX_reg_1),
        .IDEX_reg_2     (IDEX_reg_2),
        .IDEX_imm       (IDEX_imm),
        .IDEX_rd        (IDEX_rd),
        .IDEX_ctrl      (IDEX_ctrl),
        .EXMEM_alu_out  (EXMEM_alu_out),
        .EXMEM_reg_2    (EXMEM_reg_2),
        .EXMEM_rd       (EXMEM_rd),
        .EXMEM_ctrl     (EXMEM_ctrl),
        .MEMWB_alu_out  (MEMWB_alu_out),
        .MEMWB_mem_out  (MEMWB_mem_out),
        .MEMWB_rd       (MEMWB_rd),
        .MEMWB_ctrl     (MEMWB_ctrl)
    );
endmodule
