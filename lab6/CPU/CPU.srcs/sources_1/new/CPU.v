`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/05/22 15:59:37
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

    // BTB Counter
    output     [31:0] branch_cnt,
    output     [31:0] btb_succ_cnt,
    output     [31:0] btb_fail_cnt,

    // PC/IF/ID 流水段寄存器
    output reg [31:0] pc,
    output reg [31:0] pc_in,
    output     [31:0] IFID_pc,
    output     [31:0] IFID_inst,

    // ID/EX 流水段寄存器
    output     [31:0] IDEX_pc,
    output     [31:0] IDEX_reg_1,
    output     [31:0] IDEX_reg_2,
    output     [31:0] IDEX_imm,
    output     [4:0]  IDEX_rd,

    // EX/MEM 流水段寄存器
    output     [31:0] EXMEM_alu_out,
    output     [31:0] EXMEM_reg_2,
    output     [4:0]  EXMEM_rd,

    // MEM/WB 流水段寄存器
    output     [31:0] MEMWB_alu_out,
    output     [31:0] MEMWB_mem_out,
    output     [4:0]  MEMWB_rd
);
    // Control Signal
    wire        enable;

    // IF: pc, inst_mem, btb
//    reg  [31:0] pc;
//    reg  [31:0] pc_in;
    wire [31:0] pc_next;
    wire [31:0] pc_add;
    wire [31:0] inst;
    wire [1:0]  pc_sel;
    wire        btb_hit;
    wire [31:0] btb_target;
    wire        btb_fail;
//    wire [31:0] branch_cnt;
//    wire [31:0] btb_succ_cnt;
//    wire [31:0] btb_fail_cnt;

  
    // IF/ID
    wire        IFID_flush;
//    wire [31:0] IFID_pc;
    wire [31:0] IFID_pc_next;
//    wire [31:0] IFID_inst;
    wire        IFID_btb_hit; 
  
    // ID
    wire        jump;
    wire        branch;
    wire [1:0]  alu_op;
    wire [1:0]  alu_1_src;
    wire        alu_2_src;
    wire        pc_add_src;
    wire        mem_read;
    wire        mem_write;
    wire [1:0]  reg_src;
    wire        reg_write;
    wire [3:0]  alu_funct;
    wire [2:0]  funct3;
    wire [31:0] reg_1;
    wire [31:0] reg_2;
    wire [4:0]  rs_1;
    wire [4:0]  rs_2;
    wire [4:0]  rd;
    wire [31:0] imm;
  
    // ID/EX
    wire        IDEX_flush;
    wire        IDEX_jump;
    wire        IDEX_branch;
    wire [3:0]  IDEX_alu_funct;
    wire [1:0]  IDEX_alu_1_src;
    wire        IDEX_alu_2_src;
    wire        IDEX_pc_add_src;
    wire        IDEX_mem_read;
    wire        IDEX_mem_write;
    wire [1:0]  IDEX_reg_src;
    wire        IDEX_reg_write;
    wire [2:0]  IDEX_funct3;
//    wire [31:0] IDEX_pc;
    wire [31:0] IDEX_pc_next;
    wire        IDEX_btb_hit;
//    wire [31:0] IDEX_reg_1;
//    wire [31:0] IDEX_reg_2;
//    wire [31:0] IDEX_imm;
//    wire [4:0]  IDEX_rd;
    wire [4:0]  IDEX_rs_1;
    wire [4:0]  IDEX_rs_2;

    // EX
    wire [1:0]  forward_1;
    wire [1:0]  forward_2;
    reg  [31:0] EX_reg_1;
    reg  [31:0] EX_reg_2;
    reg  [31:0] alu_in_1;
    wire [31:0] alu_in_2;
    wire [31:0] alu_out;
    wire        cmp;
    wire        branch_taken;

    // EX/MEM
    wire [31:0] EXMEM_pc_next;
    wire        EXMEM_mem_read;
    wire        EXMEM_mem_write;
    wire [1:0]  EXMEM_reg_src;
    wire        EXMEM_reg_write;
    wire [2:0]  EXMEM_funct3;
//    wire [31:0] EXMEM_alu_out;
//    wire [31:0] EXMEM_reg_2;
//    wire [4:0]  EXMEM_rd;

    // MEM
    wire        mem_we;
    wire [31:0] mem_out;
    wire [31:0] mem_data;
    // MEM/WB
    wire [1:0]  MEMWB_reg_src;
    wire        MEMWB_reg_write;
    wire [31:0] MEMWB_pc_next;
//    wire [31:0] MEMWB_mem_out;
//    wire [31:0] MEMWB_alu_out;
//    wire [4:0]  MEMWB_rd;
    // WB
    reg  [31:0] WB_data;

    // IF: pc, inst_mem
    assign pc_next = pc + 32'h4;
    
    always @(*) begin
        if (IDEX_jump) pc_in = pc_add;
        else begin
            case (pc_sel)
                2'b11: pc_in = IDEX_pc_next;
                2'b10: pc_in = pc_add;
                2'b01: pc_in = btb_target;
                2'b00: pc_in = pc_next;
            endcase
        end
    end

    always @(posedge clk or posedge rst) begin
        if (rst)         pc <= 32'h3000;
        else if (enable) pc <= pc_in;
    end

    btb #(.BUF_LEN(4)) BTB (
        .clk                (clk),
        .rst                (rst),
        .enable             (enable),
        .pc                 (pc[31:2]),
        .IDEX_pc            (IDEX_pc[31:2]),
        .IDEX_branch        (IDEX_branch),
        .branch_taken       (branch_taken),
        .IDEX_branch_target (pc_add),
        .IDEX_btb_hit       (IDEX_btb_hit),
        .pc_sel             (pc_sel),
        .btb_hit            (btb_hit),
        .btb_target         (btb_target),
        .btb_fail           (btb_fail),
        .branch_cnt         (branch_cnt),
        .btb_succ_cnt       (btb_succ_cnt),
        .btb_fail_cnt       (btb_fail_cnt)
    );  

    rom Inst_Mem (
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
        .btb_hit      (btb_hit),
        .inst         (inst),
        .IFID_pc      (IFID_pc),
        .IFID_pc_next (IFID_pc_next),
        .IFID_btb_hit (IFID_btb_hit),
        .IFID_inst    (IFID_inst)
    );
    // ID: hazard, ctrl, regfile, imm_gen
    assign funct3 = IFID_inst[14:12];
    assign rs_1   = IFID_inst[19:15];
    assign rs_2   = IFID_inst[24:20];
    assign rd     = IFID_inst[11:7];

    hazard Hazard (
        .rs_1          (rs_1),
        .rs_2          (rs_2),
        .btb_fail      (btb_fail),
        .IDEX_jump     (IDEX_jump),
        .IDEX_rd       (IDEX_rd),
        .IDEX_mem_read (IDEX_mem_read),
        .enable        (enable),
        .IFID_flush    (IFID_flush),
        .IDEX_flush    (IDEX_flush)
    );

    control Control (
        .inst       (IFID_inst[6:0]),
        .jump       (jump),
        .branch     (branch),
        .alu_op     (alu_op),
        .alu_1_src  (alu_1_src),
        .alu_2_src  (alu_2_src),
        .pc_add_src (pc_add_src),
        .mem_read   (mem_read),
        .mem_write  (mem_write),
        .reg_src    (reg_src),
        .reg_write  (reg_write)      
    );

    alu_control ALU_control (
        .alu_op    (alu_op),
        .funct3    (funct3),
        .funct7    (IFID_inst[30]),
        .alu_funct (alu_funct)
    );

    regfile Reg_File (
        .clk (clk),
        .we  (MEMWB_reg_write),
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
        .clk             (clk),
        .rst             (rst),
        .clr             (IDEX_flush),
        .jump            (jump),
        .branch          (branch),
        .alu_funct       (alu_funct),
        .alu_1_src       (alu_1_src),
        .alu_2_src       (alu_2_src),
        .pc_add_src      (pc_add_src),
        .mem_read        (mem_read),
        .mem_write       (mem_write),
        .reg_src         (reg_src),
        .reg_write       (reg_write),
        .IFID_pc         (IFID_pc),
        .IFID_pc_next    (IFID_pc_next),
        .IFID_btb_hit    (IFID_btb_hit),
        .funct3          (funct3),
        .reg_1           (reg_1),
        .reg_2           (reg_2),
        .imm             (imm),
        .rs_1            (rs_1),
        .rs_2            (rs_2),
        .rd              (rd),
        .IDEX_jump       (IDEX_jump),
        .IDEX_branch     (IDEX_branch),
        .IDEX_alu_funct  (IDEX_alu_funct),
        .IDEX_alu_1_src  (IDEX_alu_1_src),
        .IDEX_alu_2_src  (IDEX_alu_2_src),
        .IDEX_pc_add_src (IDEX_pc_add_src),
        .IDEX_mem_read   (IDEX_mem_read),
        .IDEX_mem_write  (IDEX_mem_write),
        .IDEX_reg_src    (IDEX_reg_src),
        .IDEX_reg_write  (IDEX_reg_write),
        .IDEX_pc         (IDEX_pc),
        .IDEX_pc_next    (IDEX_pc_next),
        .IDEX_btb_hit    (IDEX_btb_hit),
        .IDEX_funct3     (IDEX_funct3),
        .IDEX_reg_1      (IDEX_reg_1),
        .IDEX_reg_2      (IDEX_reg_2),
        .IDEX_imm        (IDEX_imm),
        .IDEX_rs_1       (IDEX_rs_1),
        .IDEX_rs_2       (IDEX_rs_2),
        .IDEX_rd         (IDEX_rd)
    );
    // EX: forward, alu, pc_adder
    assign pc_add       = (IDEX_pc_add_src ? EX_reg_1 : IDEX_pc) + IDEX_imm;
    assign branch_taken = IDEX_branch & cmp;
    always @(*) begin
        case (forward_1)
            2'b00:   EX_reg_1 = IDEX_reg_1;
            2'b01:   EX_reg_1 = WB_data;
            2'b10:   EX_reg_1 = EXMEM_alu_out;
            default: EX_reg_1 = 32'h0;
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
    
    always @(*) begin
        case (IDEX_alu_1_src)
            2'b00:   alu_in_1 = EX_reg_1;
            2'b01:   alu_in_1 = 32'h0;
            2'b10:   alu_in_1 = IDEX_pc;
            default: alu_in_1 = 32'h0;
        endcase
    end
    assign alu_in_2 = IDEX_alu_2_src ? IDEX_imm : EX_reg_2;

    forward Forward (
        .IDEX_rs_1       (IDEX_rs_1),
        .IDEX_rs_2       (IDEX_rs_2),
        .EXMEM_reg_write (EXMEM_reg_write),
        .EXMEM_rd        (EXMEM_rd),
        .MEMWB_reg_write (MEMWB_reg_write),
        .MEMWB_rd        (MEMWB_rd),
        .forward_1       (forward_1),
        .forward_2       (forward_2)
    );

    alu ALU (
        .in_1        (alu_in_1),
        .in_2        (alu_in_2),
        .funct       (IDEX_alu_funct),
        .arithmetic  (alu_out),
        .comparision (cmp)
    );

    // EX/MEM Register
    ex_mem EX_MEM (
        .clk             (clk),
        .rst             (rst),
        .IDEX_mem_read   (IDEX_mem_read),
        .IDEX_mem_write  (IDEX_mem_write),
        .IDEX_reg_src    (IDEX_reg_src),
        .IDEX_reg_write  (IDEX_reg_write),
        .IDEX_funct3     (IDEX_funct3),
        .alu_out         (alu_out),
        .IDEX_pc_next    (IDEX_pc_next),
        .EX_reg_2        (EX_reg_2),
        .IDEX_rd         (IDEX_rd),
        .EXMEM_mem_read  (EXMEM_mem_read),
        .EXMEM_mem_write (EXMEM_mem_write),
        .EXMEM_reg_src   (EXMEM_reg_src),
        .EXMEM_reg_write (EXMEM_reg_write),
        .EXMEM_funct3    (EXMEM_funct3),
        .EXMEM_alu_out   (EXMEM_alu_out),
        .EXMEM_pc_next   (EXMEM_pc_next),
        .EXMEM_reg_2     (EXMEM_reg_2),
        .EXMEM_rd        (EXMEM_rd)
    );

    // MEM: data_mem
    assign io_we   = EXMEM_mem_write & EXMEM_alu_out[10];
    assign io_addr = EXMEM_alu_out[7:0];
    assign io_dout = EXMEM_reg_2;
    assign mem_we  = EXMEM_mem_write & (~EXMEM_alu_out[10]);
    assign mem_out = EXMEM_alu_out[10] ? io_din : mem_data;

    data_mem Data_Mem (
        .clk      (clk),
        .funct3   (EXMEM_funct3),
        .addr     (EXMEM_alu_out[9:0]),
        .data     (EXMEM_reg_2),
        .mem_read (EXMEM_mem_read),
        .mem_we   (mem_we),
        .dbg_addr (dbg_addr),
        .mem_data (mem_data),
        .dbg_data (m_data)
    );

    // MEM/WB Register
    mem_wb MEM_WB (
        .clk             (clk),
        .rst             (rst),
        .EXMEM_reg_src   (EXMEM_reg_src),
        .EXMEM_reg_write (EXMEM_reg_write),
        .mem_out         (mem_out),
        .EXMEM_pc_next   (EXMEM_pc_next),
        .EXMEM_alu_out   (EXMEM_alu_out),
        .EXMEM_rd        (EXMEM_rd),
        .MEMWB_reg_src   (MEMWB_reg_src),
        .MEMWB_reg_write (MEMWB_reg_write),
        .MEMWB_mem_out   (MEMWB_mem_out),
        .MEMWB_pc_next   (MEMWB_pc_next),
        .MEMWB_alu_out   (MEMWB_alu_out),
        .MEMWB_rd        (MEMWB_rd)
    );
    // WB
    always @(*) begin
        case (MEMWB_reg_src)
            2'b00:   WB_data = MEMWB_alu_out;
            2'b01:   WB_data = MEMWB_mem_out;
            2'b10:   WB_data = MEMWB_pc_next;
            default: WB_data = 32'h0;
        endcase
    end
endmodule