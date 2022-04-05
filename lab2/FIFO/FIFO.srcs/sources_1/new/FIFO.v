`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/03/27 15:19:41
// Design Name: 
// Module Name: fifo
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


module fifo(
    input           clk,    // clock (100 MHz, posedge)
    input           rst,    // sychronous reset (active high)
    input           enq,    // enqueue (active high)
    input   [3:0]   in,     // enqueue data
    input           deq,    // dequeue (active high)
    output  [3:0]   out,    // dequeue data
    output          full,   // queue full
    output          emp,    // queue empty
    output  [2:0]   an,     // segment display selection
    output  [3:0]   seg     // segment display data
);
    // wires
    wire        enq_edge;
    wire        deq_edge;
    wire        we;
    wire [2:0]  ra0, ra1, wa;
    wire [3:0]  rd0, rd1, wd;
    wire [7:0]  valid;
    // datapath
    reg_file RF(
        .clk(clk),
        .ra0(ra0),
        .ra1(ra1),
        .we (we),
        .wa (wa),
        .wd (wd),
        .rd0(rd0),
        .rd1(rd1)
    );

    sig_edge SEDG_enq(
        .clk(clk),
        .a  (enq),
        .p  (enq_edge)
    );
    sig_edge SEDG_deq(
        .clk(clk),
        .a  (deq),
        .p  (deq_edge)
    );

    list_control_unit LCU(
        .clk  (clk),
        .rst  (rst),
        .in   (in),
        .enq  (enq_edge),
        .deq  (deq_edge),
        .rd   (rd0),
        .full (full),
        .emp  (emp),
        .out  (out),
        .ra   (ra0),
        .we   (we),
        .wa   (wa),
        .wd   (wd),
        .valid(valid)
    );

    segplay_unit SDU(
        .clk_100mhz  (clk),
        .data        (rd1),
        .valid       (valid),
        .addr        (ra1),
        .segplay_an  (an),
        .segplay_data(seg)
    );
endmodule
