`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/04/17 18:20:24
// Design Name: 
// Module Name: cpu
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
    input               clk,
    input               rst,
    // IO_BUS
    input       [31:0]  io_din,  //来自 sw 的输入数据
    output      [7:0]   io_addr,
    output      [31:0]  io_dout, //输出 led 和 seg 的数据
    output              io_we,   //输出 led 和 seg 数据时的使能信号

    //Debug_BUS
    input       [7:0]   m_rf_addr, //存储器 (MEM) 或寄存器堆 (RF) 的调试读口地址
    output      [31:0]  rf_data,   //从RF读取的数据
    output      [31:0]  m_data,    //从MEM读取的数据
    output reg  [31:0]  pc         //PC的内容
);
    wire [31:0] new_pc;
    wire [31:0] next_pc;
    wire [31:0] added_pc;
    wire [1:0]  PCSrc;
    wire [31:0] inst;
    wire [2:0]  Imm_Gen;
    wire [1:0]  RegSrc;
    wire [1:0]  ALUop;
    wire        jal;
    wire        jalr;
    wire        Branch;
    wire        MemWrite;
    wire        ALUSrc;
    wire        RegWrite;
    wire [31:0] reg1;
    wire [31:0] reg2;
    reg  [31:0] regw;
    wire [31:0] imm;
    wire [31:0] op1;
    wire [31:0] op2;
    wire [1:0]  ALU_funct;
    wire [31:0] ALU_out;
    wire        BR_Taken;
    wire        mem_we;
    wire [31:0] mem_out;
    wire [31:0] load_data;

    assign new_pc    = (PCSrc) ? added_pc : next_pc;
    assign next_pc   = pc + 32'h4;
    assign added_pc  = ((jalr) ? reg1 : pc) + (imm & 32'hFFFFFFFE);
    assign PCSrc     = jal | jalr | (Branch & BR_Taken);
    assign op1       = reg1;
    assign op2       = (ALUSrc) ? imm : reg2;
    assign io_dout   = reg2;
    assign io_addr   = ALU_out[7:0];
    assign io_we     = ALU_out[10] & MemWrite;
    assign mem_we    = (~ALU_out[10]) & MemWrite;
    assign load_data = (ALU_out[10]) ? io_din : mem_out;

    always @(posedge clk or posedge rst) begin
        if (rst) pc <= 32'h0000_3000;
        else pc <= new_pc;
    end

    inst_mem Inst_Mem (
        .a   (pc[9:2]),
        .spo (inst)
    );

    control Control (
        .inst     (inst[6:0]),
        .Imm_Gen  (Imm_Gen),
        .RegSrc   (RegSrc),
        .ALUop    (ALUop),
        .jal      (jal),
        .jalr     (jalr),
        .Branch   (Branch),
        .MemWrite (MemWrite),
        .ALUSrc   (ALUSrc),
        .RegWrite (RegWrite)
    );

    regfile #(.WIDTH(32)) RegFile (
        .clk (clk),
        .we  (RegWrite),
        .ra1 (inst[19:15]),
        .ra2 (inst[24:20]),
        .ra3 (m_rf_addr[4:0]),
        .wa  (inst[11:7]),
        .wd  (regw),
        .rd1 (reg1),
        .rd2 (reg2),
        .rd3 (rf_data)
    );

    imm_gen_control Imm_Gen_Control (
        .inst    (inst),
        .imm_gen (Imm_Gen),
        .imm     (imm)
    );

    alu_control ALU_Control (
        .funct7 (inst[30]),
        .funct3 (inst[14:12]),
        .opcode (ALUop),
        .funct  (ALU_funct)
    );

    alu ALU (
        .op1    (op1),
        .op2    (op2),
        .funct  (ALU_funct),
        .result (ALU_out),
        .br_tk  (BR_Taken)
    );

    data_mem Data_Mem (
        .clk  (clk),
        .we   (mem_we),
        .a    (ALU_out[9:2]),
        .dpra (m_rf_addr),
        .d    (reg2),
        .spo  (mem_out),
        .dpo  (m_data)
    );

    always @(*) begin
        case (RegSrc)
        2'b00: regw = ALU_out;
        2'b01: regw = load_data;
        2'b10: regw = next_pc;
        2'b11: regw = added_pc;
        endcase
    end

endmodule
