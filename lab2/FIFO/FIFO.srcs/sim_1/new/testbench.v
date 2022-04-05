`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2022/03/30 14:03:54
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
    reg         enq;
    reg         deq;
    reg  [3:0]  in;
    wire [3:0]  out;
    wire        full;
    wire        emp;

    fifo        test(
        .clk(clk),
        .rst(rst),
        .enq(enq),
        .deq(deq),
        .in(in),
        .out(out),
        .full(full),
        .emp(emp)
    );

    initial begin
        clk <= 1'b0;
        forever
            #1 clk <= ~clk;
    end

    initial begin
        rst <= 1'b1;
        #5  rst <= 1'b0;
    end

    initial begin
        enq <= 1'b0;
        deq <= 1'b0;
        in  <= 4'h0;
        #20 enq <= 1'b1;    // 1st enqueue
        in  <= 4'h1;
        #20 enq <= 1'b0;
        #20 enq <= 1'b1;    // 2nd enqueue
        in  <= 4'h2;
        #20 enq <= 1'b0;
        #20 enq <= 1'b1;    // 3rd enqueue
        in  <= 4'h3;
        #20 enq <= 1'b0;
        #20 enq <= 1'b1;    // 4th enqueue
        in  <= 4'h4;
        #20 enq <= 1'b0;
        #20 enq <= 1'b1;    // 5th enqueue
        in  <= 4'h5;
        #20 enq <= 1'b0;
        #20 enq <= 1'b1;    // 6th enqueue
        in  <= 4'h6;
        #20 enq <= 1'b0;
        #20 enq <= 1'b1;    // 7th enqueue
        in  <= 4'h7;
        #20 enq <= 1'b0;
        #20 enq <= 1'b1;    // 8th enqueue
        in  <= 4'h8;
        #20 enq <= 1'b0;
        #20 enq <= 1'b1;    // 9th enqueue (invalid)
        in  <= 4'h9;
        #20 enq <= 1'b0;
        #20 enq <= 1'b1;    // 10th enqueue (invalid)
        in  <= 4'hA;
        #20 enq <= 1'b0;
        #20 deq <= 1'b1;    // 1st dequeue
        #20 deq <= 1'b0;
        #20 deq <= 1'b1;    // 2nd dequeue
        #20 deq <= 1'b0;
        #20 deq <= 1'b1;    // 3rd dequeue
        #20 deq <= 1'b0;
        #20 deq <= 1'b1;    // 4th dequeue
        #20 deq <= 1'b0;
        #20 deq <= 1'b1;    // 5th dequeue
        #20 deq <= 1'b0;
        #20 deq <= 1'b1;    // 6th dequeue
        #20 deq <= 1'b0;
        #20 deq <= 1'b1;    // 7th dequeue
        #20 deq <= 1'b0;
        #20 deq <= 1'b1;    // 8th dequeue
        #20 deq <= 1'b0;
        #20 deq <= 1'b1;    // 9th dequeue (invalid)
        #20 deq <= 1'b0;
        #20 deq <= 1'b1;    // 10th dequeue (invalid)
        #20 deq <= 1'b0;
        #20 $finish;
    end
endmodule
