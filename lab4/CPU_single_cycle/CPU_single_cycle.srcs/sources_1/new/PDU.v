`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2022/04/17 14:59:41
// Design Name:
// Module Name: pdu
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


module pdu(
    input clk,
    input rst,

    //选择CPU工作方式;
    input run,
    input step,
    output clk_cpu,

    //输入switch的端口
    input valid,
    input [4:0] in,

    //输出led和seg的端口
    output [1:0] check,     //led6-5:查看类型
    output [4:0] out0,      //led4-0
    output [2:0] an,        //8个数码管
    output [3:0] seg,
    output ready,           //led7

    //IO_BUS
    input  [7:0] io_addr,
    input  [31:0] io_dout,
    input  io_we,
    output [31:0] io_din,

    //Debug_BUS
    output [7:0] m_rf_addr,
    input  [31:0] rf_data,
    input  [31:0] m_data,
    input  [31:0] pc
);

    reg  [4:0] in_r;         //同步外部输入用
    reg  run_r, step_r, step_2r, valid_r, valid_2r;
    wire step_p, valid_pn;  //取边沿信号

    reg clk_cpu_r;      //寄存器输出CPU时钟
    reg [4:0] out0_r;   //输出外设端口
    reg [31:0] out1_r;
    reg ready_r;
    reg [19:0] cnt;     //刷新计数器，刷新频率约为95Hz
    reg [1:0] check_r;  //查看信息类型, 00-运行结果，01-寄存器堆，10-存储器，11-PC

    reg [7:0] io_din_a; //_a表示为满足组合always描述要求定义的，下同
    reg ready_a;
    reg [4:0] out0_a;
    reg [31:0] out1_a;
    reg [3:0] seg_a;

    assign clk_cpu = clk_cpu_r;
    assign io_din = io_din_a;
    assign check = check_r;
    assign out0 = out0_a;
    assign ready = ready_a;
    assign seg = seg_a;
    assign an = cnt[19:17];
    assign step_p = step_r & ~step_2r;     //取上升沿
    assign valid_pn = valid_r ^ valid_2r;  //取上升沿或下降沿
    assign m_rf_addr = {{3{1'b0}}, in_r};

    //同步输入信号
    always @(posedge clk) begin
        run_r <= run;
        step_r <= step;
        step_2r <= step_r;
        valid_r <= valid;
        valid_2r <= valid_r;
        in_r <= in;
    end

    //CPU工作方式
    always @(posedge clk, posedge rst) begin
        if(rst)
            clk_cpu_r <= 0;
        else if (run_r)
            clk_cpu_r <= ~clk_cpu_r;
        else
            clk_cpu_r <= step_p;
    end

    //读外设端口
    always @* begin
        case (io_addr)
            8'h0c:
                io_din_a = {{27{1'b0}}, in_r};
            8'h10:
                io_din_a = {{31{1'b0}}, valid_r};
            default:
                io_din_a = 32'h0000_0000;
        endcase
    end

    //写外设端口
    always @(posedge clk, posedge rst) begin
        if (rst) begin
            out0_r <= 5'h1f;
            out1_r <= 32'h1234_5678;
            ready_r <= 1'b1;
        end
        else if (io_we)
        case (io_addr)
            8'h00:
                out0_r <= io_dout[4:0];
            8'h04:
                ready_r <= io_dout[0];
            8'h08:
                out1_r <= io_dout;
            default:
                ;
        endcase
    end

    //LED和数码管查看类型
    always @(posedge clk, posedge rst) begin
        if(rst)
            check_r <= 2'b00;
        else if(run_r)
            check_r <= 2'b00;
        else if (step_p)
            check_r <= 2'b00;
        else if (valid_pn)
            check_r <= check - 2'b01;
    end

    //LED和数码管显示内容
    always @* begin
        ready_a = 1'b0;
        case (check_r)
            2'b00: begin
                out0_a = out0_r;
                out1_a = out1_r;
                ready_a = ready_r;
            end
            2'b01: begin
                out0_a = in_r;
                out1_a = rf_data;
            end
            2'b10: begin
                out0_a = in_r;
                out1_a = m_data;
            end
            2'b11: begin
                out0_a = 5'b00000;
                out1_a = pc;
            end
        endcase
    end

    //扫描数码管
    always @(posedge clk, posedge rst) begin
        if (rst)
            cnt <= 20'h0_0000;
        else
            cnt <= cnt + 20'h0_0001;
    end

    always @* begin
        case (an)
            3'd0:
                seg_a = out1_a[3:0];
            3'd1:
                seg_a = out1_a[7:4];
            3'd2:
                seg_a = out1_a[11:8];
            3'd3:
                seg_a = out1_a[15:12];
            3'd4:
                seg_a = out1_a[19:16];
            3'd5:
                seg_a = out1_a[23:20];
            3'd6:
                seg_a = out1_a[27:24];
            3'd7:
                seg_a = out1_a[31:28];
            default:
                ;
        endcase
    end

endmodule

