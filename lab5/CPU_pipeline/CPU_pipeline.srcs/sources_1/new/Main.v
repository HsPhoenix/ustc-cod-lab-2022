`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/05/08 22:11:28
// Design Name: 
// Module Name: Main
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


module main(
    input        clk,    // clk_100MHz
    input        step,   // btn
    input        rst,    // sw[7]
    input        run,    // sw[6]
    input        valid,  // sw[5]
    input  [4:0] in,     // sw[4:0]
    output       ready,  // led[7]
    output [1:0] check,  // led[6:5]
    output [4:0] out_0,  // led[4:0]
    output [2:0] an,     // segplay_an
    output [3:0] seg     // segplay_data
);
    wire clk_cpu;
    
    // IO_BUS
    wire        io_we;
    wire [7:0]  io_addr;
    wire [31:0] io_din;
    wire [31:0] io_dout;

    // Debug_BUS
    wire [31:0] rf_data;
    wire [31:0] m_data;
    wire [7:0]  dbg_addr;

    // Pipeline Register
    wire [31:0] pc_in;
    wire [31:0] pc;
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

    // Wire Mapping
    cpu CPU(
        .clk           (clk_cpu),
        .rst           (rst),
        .io_we         (io_we),
        .io_addr       (io_addr),
        .io_din        (io_din),
        .io_dout       (io_dout),
        .rf_data       (rf_data),
        .m_data        (m_data),
        .dbg_addr      (dbg_addr),
        .pc_in         (pc_in),
        .pc            (pc),
        .IFID_pc       (IFID_pc),
        .IFID_inst     (IFID_inst),
        .IDEX_pc       (IDEX_pc),
        .IDEX_reg_1    (IDEX_reg_1),
        .IDEX_reg_2    (IDEX_reg_2),
        .IDEX_imm      (IDEX_imm),
        .IDEX_rd       (IDEX_rd),
        .IDEX_ctrl     (IDEX_ctrl),
        .EXMEM_alu_out (EXMEM_alu_out),
        .EXMEM_reg_2   (EXMEM_reg_2),
        .EXMEM_rd      (EXMEM_rd),
        .EXMEM_ctrl    (EXMEM_ctrl),
        .MEMWB_alu_out (MEMWB_alu_out),
        .MEMWB_mem_out (MEMWB_mem_out),
        .MEMWB_rd      (MEMWB_rd),
        .MEMWB_ctrl    (MEMWB_ctrl)
    );

    pdu PDU(
        .clk       (clk),
        .rst       (rst),
        .run       (run),
        .step      (step),
        .clk_cpu   (clk_cpu),
        .valid     (valid),
        .in        (in),
        .ready     (ready),
        .check     (check),
        .out0      (out_0),
        .an        (an),
        .seg       (seg),
        .io_we     (io_we),
        .io_addr   (io_addr),
        .io_din    (io_din),
        .io_dout   (io_dout),
        .rf_data   (rf_data),
        .m_data    (m_data),
        .m_rf_addr (dbg_addr),
        .pcin      (pc_in),
        .pc        (pc),
        .pcd       (IFID_pc),
        .pce       (IDEX_pc),
        .ir        (IFID_inst),
        .imm       (IDEX_imm),
        .mdr       (MEMWB_mem_out),
        .a         (IDEX_reg_1),
        .b         (IDEX_reg_2),
        .y         (EXMEM_alu_out),
        .bm        (EXMEM_reg_2),
        .yw        (MEMWB_alu_out),
        .rd        (IDEX_rd),
        .rdm       (MEMWB_rd),
        .rdw       (EXMEM_rd),
        .ctrl      (IDEX_ctrl),
        .ctrlm     (EXMEM_ctrl),
        .ctrlw     (MEMWB_ctrl)
    );
endmodule
