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
    reg        clk;
    reg        step;
    reg        rst;
    reg        run;
    reg        valid;
    reg  [4:0] in;
    wire       ready;
    wire [1:0] check;
    wire [4:0] out_0;
    wire [2:0] an;
    wire [3:0] seg;
    initial begin
        clk   <= 1'b0;
        step  <= 1'b0;
        rst   <= 1'b0;
        run   <= 1'b0;
        valid <= 1'b0;
        in    <= 4'h0;
        #1
        rst   <= 1'b1;
        #1
        rst   <= 1'b0;
        run   <= 1'b1;
        in    <= 4'h2;
        #58
        in    <= 4'h3;
    end
    always #1  clk   <= ~clk;
    always #12 valid <= ~valid;

    main Main(
        .clk   (clk),
        .step  (step),
        .rst   (rst),
        .run   (run),
        .valid (valid),
        .in    (in),
        .ready (ready),
        .check (check),
        .out_0 (out_0),
        .an    (an),
        .seg   (seg)
    );

endmodule