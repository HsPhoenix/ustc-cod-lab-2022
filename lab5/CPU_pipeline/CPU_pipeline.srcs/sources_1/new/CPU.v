`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/05/08 22:11:28
// Design Name: 
// Module Name: CPU
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


module cpu(
    input clk, 
    input rst,

    // IO_BUS
    input      [31:0] io_din,    // 来自 sw 的输入数据
    output     [7:0]  io_addr,   // led 和 seg 的地址
    output     [31:0] io_dout,   // 输出 led 和 seg 的数据
    output            io_we,     // 输出 led 和 seg 数据时的使能信号

    // Debug_BUS
    input      [7:0]  dbg_addr,  // 存储器 (MEM) 或寄存器堆 (RF) 的调试读口地址
    output     [31:0] rf_data,   // 从RF读取的数据
    output     [31:0] m_data,    // 从MEM读取的数据

    // PC/IF/ID 流水段寄存器
    output reg [31:0] pc,
    output     [31:0] pc_in,
    output     [31:0] IFID_pc,
    output     [31:0] IFID_inst,

    // ID/EX 流水段寄存器
    output     [31:0] IDEX_pc,
    output     [31:0] IDEX_reg_1,
    output     [31:0] IDEX_reg_2,
    output     [31:0] IDEX_imm,
    output     [4:0]  IDEX_rd,
    output     [31:0] IDEX_ctrl,

    // EX/MEM 流水段寄存器
    output     [31:0] EXMEM_alu_out,
    output     [31:0] EXMEM_reg_2,
    output     [4:0]  EXMEM_rd,
    output     [31:0] EXMEM_ctrl,

    // MEM/WB 流水段寄存器
    output     [31:0] MEMWB_alu_out,
    output     [31:0] MEMWB_mem_out,
    output     [4:0]  MEMWB_rd,
    output     [31:0] MEMWB_ctrl
);
    // Control Signal
    wire        enable;
    // IF
    wire        pc_src;
    wire [31:0] pc_next;
    wire [31:0] pc_add;
    wire [31:0] inst;
    // IF/ID
    wire        IFID_flush;
    wire [31:0] IFID_pc_next;
    // ID
    wire [31:0] ctrl;
    wire        jump;       // ctrl[9]
    wire        branch;     // ctrl[8]
    wire        mem_read;   // ctrl[13]
    wire        mem_write;  // ctrl[12]
    wire        alu_op;     // ctrl[0]
    wire        alu_src;    // ctrl[4]
    wire [1:0]  reg_src;    // ctrl[17:16]
    wire        reg_write;  // ctrl[18]
    wire [31:0] reg_1;
    wire [31:0] reg_2;
    wire [4:0]  rs_1;
    wire [4:0]  rs_2;
    wire [4:0]  rd;
    wire [31:0] imm;
    // ID/EX
    wire        IDEX_flush;
    wire [31:0] IDEX_pc_next;
    wire [4:0]  IDEX_rs_1;
    wire [4:0]  IDEX_rs_2;
    // EX
    wire [1:0]  forward_1;
    wire [1:0]  forward_2;
    reg  [31:0] EX_reg_2;
    reg  [31:0] alu_in_1;
    wire [31:0] alu_in_2;
    wire [31:0] alu_out;
    wire        eq;
    // EX/MEM
    wire [31:0] EXMEM_pc_next;
    // MEM
    wire        mem_we;
    wire [31:0] mem_out;
    wire [31:0] mem_data;
    // MEM/WB
    wire [31:0] MEMWB_pc_next;
    // WB
    reg  [31:0] WB_data;
    // IF: pc, inst_mem
    assign pc_next = pc + 32'h4;
    assign pc_in   = (pc_src == 1'b1) ? pc_add : pc_next;
    always @(posedge clk or posedge rst) begin
        if (rst)         pc <= 32'h0;
        else if (enable) pc <= pc_in;
    end
    inst_mem Inst_Mem (
        .a   (pc[9:2]),
        .spo (inst)
    );
    // IF/ID Register
    if_id IF_ID (
        .clk          (clk),
        .rst          (rst),
        .en           (enable),
        .clr          (IFID_flush),
        .pc           (pc),
        .pc_next      (pc_next),
        .inst         (inst),
        .IFID_pc      (IFID_pc),
        .IFID_pc_next (IFID_pc_next),
        .IFID_inst    (IFID_inst)
    );
    // ID: hazard, ctrl, regfile, imm_gen
    assign ctrl = {~enable, ~enable, IFID_flush, IDEX_flush, 2'b00, forward_1,
                   2'b00, forward_2, 1'b0, reg_write, reg_src, 2'b00, mem_read, 
                   mem_write, 2'b00, jump, branch, 2'b00, 1'b0, alu_src, 
                   3'b000, alu_op}; // bunch of fking wires
    assign rs_1 = IFID_inst[19:15];
    assign rs_2 = IFID_inst[24:20];
    assign rd   = IFID_inst[11:7];

    hazard Hazard (
        .rs_1         (rs_1),
        .rs_2         (rs_2),
        .pc_src       (pc_src),
        .IDEX_rd      (IDEX_rd),
        .IDEX_reg_src (IDEX_ctrl[17:16]),
        .enable       (enable),
        .IFID_flush   (IFID_flush),
        .IDEX_flush   (IDEX_flush)
    );
    control Control (
        .inst      (IFID_inst[6:0]),
        .jump      (jump),
        .branch    (branch),
        .mem_read  (mem_read),
        .mem_write (mem_write),
        .alu_op    (alu_op),
        .alu_src   (alu_src),
        .reg_src   (reg_src),
        .reg_write (reg_write)      
    );
    regfile Reg_File (
        .clk (clk),
        .we  (MEMWB_ctrl[18]),
        .ra1 (rs_1),
        .ra2 (rs_2),
        .ra3 (dbg_addr[4:0]),
        .wa  (MEMWB_rd),
        .wd  (WB_data),
        .rd1 (reg_1),
        .rd2 (reg_2),
        .rd3 (rf_data)
    );
    imm_gen Imm_Gen (
        .inst (IFID_inst),
        .imm  (imm)
    );
    // ID/EX Register
    id_ex ID_EX (
        .clk          (clk),
        .rst          (rst),
        .clr          (IDEX_flush),
        .IFID_pc      (IFID_pc),
        .IFID_pc_next (IFID_pc_next),
        .reg_1        (reg_1),
        .reg_2        (reg_2),
        .imm          (imm),
        .rs_1         (rs_1),
        .rs_2         (rs_2),
        .rd           (rd),
        .ctrl         (ctrl),
        .IDEX_pc      (IDEX_pc),
        .IDEX_pc_next (IDEX_pc_next),
        .IDEX_reg_1   (IDEX_reg_1),
        .IDEX_reg_2   (IDEX_reg_2),
        .IDEX_imm     (IDEX_imm),
        .IDEX_rs_1    (IDEX_rs_1),
        .IDEX_rs_2    (IDEX_rs_2),
        .IDEX_rd      (IDEX_rd),
        .IDEX_ctrl    (IDEX_ctrl)
    );
    // EX: forward, alu, pc_adder
    assign pc_src  = IDEX_ctrl[9] | (IDEX_ctrl[8] & eq);
    assign pc_add  = IDEX_pc + IDEX_imm;
    always @(*) begin
        case (forward_1)
            2'b00:   alu_in_1 = IDEX_reg_1;
            2'b01:   alu_in_1 = WB_data;
            2'b10:   alu_in_1 = EXMEM_alu_out;
            default: alu_in_1 = 32'h0;
        endcase
    end
    always @(*) begin
        case (forward_2)
            2'b00:   EX_reg_2 = IDEX_reg_2;
            2'b01:   EX_reg_2 = WB_data;
            2'b10:   EX_reg_2 = EXMEM_alu_out;
            default: EX_reg_2 = 32'h0;
        endcase
    end
    assign alu_in_2 = IDEX_ctrl[4] ? IDEX_imm : EX_reg_2;
    forward Forward (
        .IDEX_rs_1       (IDEX_rs_1),
        .IDEX_rs_2       (IDEX_rs_2),
        .EXMEM_reg_write (EXMEM_ctrl[18]),
        .EXMEM_rd        (EXMEM_rd),
        .MEMWB_reg_write (MEMWB_ctrl[18]),
        .MEMWB_rd        (MEMWB_rd),
        .forward_1       (forward_1),
        .forward_2       (forward_2)
    );
    alu ALU (
        .in_1 (alu_in_1),
        .in_2 (alu_in_2),
        .op   (IDEX_ctrl[0]),
        .out  (alu_out),
        .eq   (eq)
    );
    // EX/MEM Register
    ex_mem EX_MEM (
        .clk           (clk),
        .rst           (rst),
        .alu_out       (alu_out),
        .IDEX_pc_next  (IDEX_pc_next),
        .EX_reg_2      (EX_reg_2),
        .IDEX_rd       (IDEX_rd),
        .IDEX_ctrl     (IDEX_ctrl),
        .EXMEM_alu_out (EXMEM_alu_out),
        .EXMEM_pc_next (EXMEM_pc_next),
        .EXMEM_reg_2   (EXMEM_reg_2),
        .EXMEM_rd      (EXMEM_rd),
        .EXMEM_ctrl    (EXMEM_ctrl)
    );
    // MEM: data_mem
    assign io_we   = EXMEM_ctrl[12] & EXMEM_alu_out[10];
    assign io_addr = EXMEM_alu_out[7:0];
    assign io_dout = EXMEM_reg_2;
    assign mem_we  = EXMEM_ctrl[12] & (~EXMEM_alu_out[10]);
    assign mem_out = (EXMEM_alu_out[10]) ? io_din : mem_data;
    data_mem Data_Mem (
        .clk  (clk),
        .we   (mem_we),
        .a    (EXMEM_alu_out[9:2]),
        .dpra (dbg_addr),
        .d    (EXMEM_reg_2),
        .spo  (mem_data),
        .dpo  (m_data)
    );
    // MEM/WB Register
    mem_wb MEM_WB (
        .clk           (clk),
        .rst           (rst),
        .mem_out       (mem_out),
        .EXMEM_pc_next (EXMEM_pc_next),
        .EXMEM_alu_out (EXMEM_alu_out),
        .EXMEM_rd      (EXMEM_rd),
        .EXMEM_ctrl    (EXMEM_ctrl),
        .MEMWB_mem_out (MEMWB_mem_out),
        .MEMWB_pc_next (MEMWB_pc_next),
        .MEMWB_alu_out (MEMWB_alu_out),
        .MEMWB_rd      (MEMWB_rd),
        .MEMWB_ctrl    (MEMWB_ctrl)
    );
    // WB
    always @(*) begin
        case (MEMWB_ctrl[17:16])
            2'b00:   WB_data = MEMWB_alu_out;
            2'b01:   WB_data = MEMWB_mem_out;
            2'b10:   WB_data = MEMWB_pc_next;
            default: WB_data = 32'h0;
        endcase
    end
endmodule
