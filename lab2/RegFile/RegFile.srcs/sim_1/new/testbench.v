`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2022/03/23 00:56:47
// Design Name:
// Module Name: testbench
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


module testbench();
    parameter clk_sep   = 1;
    parameter time_sep  = 10;
    parameter width     = 32;
    reg       clk;
    reg       [4:0] ra0;
    reg       [4:0] ra1;
    reg       [4:0] wa;
    reg       we;
    reg       [width-1:0] wd;
    wire      [width-1:0] rd0;
    wire      [width-1:0] rd1;
    register_file regfile(
        .clk(clk),
        .ra0(ra0),
        .ra1(ra1),
        .wa(wa),
        .we(we),
        .wd(wd),
        .rd0(rd0),
        .rd1(rd1)
    );
    initial begin
        clk = 0;
        ra0 = 5'h03;
        ra1 = 5'h12;
        forever #clk_sep clk = ~clk;
    end
    initial begin
        we = 1'b0;
        wa = 5'h03;
        wd = 32'h12345678;
        #time_sep
        we = 1'b1;
        #time_sep
        wa = 5'h12;
        wd = 32'h87654321;
        #time_sep
        we = 1'b0;
        wd = 32'habcdef01;
        #time_sep
        we = 1'b1;
        #time_sep
        we = 1'b0;
        wa = 5'h03;
        #time_sep
        we = 1'b1;
        #time_sep
        $finish;
    end
endmodule
