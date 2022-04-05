`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/03/27 13:39:54
// Design Name: 
// Module Name: list_control_unit
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


module list_control_unit(
    input              clk,         // clock (100 MHz, posedge)
    input              rst,         // sychronous reset (active high)
    input       [3:0]  in,
    input              enq,         // enqueue edge
    input              deq,         // dequeue edge
    input       [3:0]  rd,          // read data
    output             full,
    output             emp,         // empty
    output reg  [3:0]  out,         // deququed data
    output      [2:0]  ra,          // read address
    output             we,          // write enable
    output      [2:0]  wa,          // write address
    output      [3:0]  wd,          // write data
    output reg  [7:0]  valid
);
    reg [2:0] head;  // pointer to head
    reg [2:0] tail;  // pointer to tail

    assign full = &valid;
    assign emp  = ~(|valid);

    assign ra = head;
    assign we = enq & ~full & ~rst;
    assign wa = tail;
    assign wd = in; 
    
    always @(posedge clk) begin
        if (rst) begin
            valid <= 8'h00;
            head  <= 3'h0;
            tail  <= 3'h0;
            out   <= 3'h0;
        end
        else if(enq & ~full) begin
            valid[tail] <= 1'b1;
            tail        <= tail + 3'h1;
        end
        else if(deq & ~emp) begin
            valid[head] <= 1'b0;
            head        <= head + 3'h1;
            out         <= rd;
        end
    end
endmodule
