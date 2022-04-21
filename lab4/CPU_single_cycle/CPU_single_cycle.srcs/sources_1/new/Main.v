`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/04/17 21:14:30
// Design Name: 
// Module Name: main
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
    input           clk,
    input           btn,
    input   [7:0]   sw,
    output  [7:0]   led,
    output  [2:0]   an,
    output  [3:0]   d
);
    wire        clk_cpu;
    wire [7:0]  io_addr;
    wire [31:0] io_dout;
    wire        io_we;
    wire [31:0] io_din;
    wire [7:0]  m_rf_addr;
    wire [31:0] rf_data;
    wire [31:0] m_data;
    wire [31:0] pc;

    pdu PDU(
        .clk        (clk),
        .rst        (sw[7]),
        .run        (sw[6]),
        .step       (btn),
        .clk_cpu    (clk_cpu),
        .valid      (sw[5]),
        .in         (sw[4:0]),
        .check      (led[6:5]),
        .out0       (led[4:0]),
        .an         (an),
        .seg        (d),
        .ready      (led[7]),
        .io_addr    (io_addr),
        .io_dout    (io_dout),
        .io_we      (io_we),
        .io_din     (io_din),
        .m_rf_addr  (m_rf_addr),
        .rf_data    (rf_data),
        .m_data     (m_data),
        .pc         (pc)
    );

    cpu CPU(
        .clk        (clk_cpu),
        .rst        (sw[7]),
        .io_din     (io_din),
        .io_addr    (io_addr),
        .io_dout    (io_dout),
        .io_we      (io_we),
        .m_rf_addr  (m_rf_addr),
        .rf_data    (rf_data),
        .m_data     (m_data),
        .pc         (pc)
    );
endmodule
