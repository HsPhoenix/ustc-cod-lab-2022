`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/05/23 11:12:20
// Design Name: 
// Module Name: tb
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
    reg  [31:0] io_din;
    reg  [7:0]  dbg_addr;
    wire [7:0]  io_addr;
    wire [31:0] io_dout;
    wire        io_we;
    wire [31:0] rf_data;
    wire [31:0] m_data;
    cpu test_cpu (
        .clk      (clk),
        .rst      (rst),
        .io_din   (io_din),
        .dbg_addr (dbg_addr),
        .io_addr  (io_addr),
        .io_dout  (io_dout),
        .io_we    (io_we),
        .rf_data  (rf_data),
        .m_data   (m_data)
    );
    
    initial begin
        clk      = 1'b0;
        rst      = 1'b1;
        io_din   = 32'h12345678;
        dbg_addr = 8'h5;
        #3
        rst      = 1'b0;
        #99997
        $finish;
    end

    always #1 clk = ~clk;
endmodule
