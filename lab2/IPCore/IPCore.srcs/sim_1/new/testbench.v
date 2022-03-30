`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2022/03/30 14:28:25
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
    // shared input signals
    reg         clk;
    reg  [3:0]  addr;
    reg  [7:0]  in;
    reg         we;
    initial begin
        clk <= 1'b0;
        forever
            #1 clk <= ~clk;
    end
    initial begin
        addr <= 4'h0;
        in   <= 8'h00;
        we   <= 1'b0;
        #10 addr <= 4'h1;
        #10 addr <= 4'h2;
        #10 addr <= 4'h3;
        #10 addr <= 4'h4;
        #10 addr <= 4'h5;
        #10 addr <= 4'h6;
        #10 addr <= 4'h7;
        #10 addr <= 4'h8;
        #10 addr <= 4'h9;
        #10 addr <= 4'hA;
        #10 addr <= 4'hB;
        #10 addr <= 4'hC;
        #10 addr <= 4'hD;
        #10 addr <= 4'hE;
        #10 addr <= 4'hF;
        #10 addr <= 4'h0;
        in   <= 8'h00;
        we   <= 1'b1;
        #10 addr <= 4'h1;
        in   <= 8'h11;
        #10 addr <= 4'h2;
        in   <= 8'h22;
        #10 addr <= 4'h3;
        in   <= 8'h33;
        #10 addr <= 4'h4;
        in   <= 8'h44;
        #10 addr <= 4'h5;
        in   <= 8'h55;
        #10 addr <= 4'h6;
        in   <= 8'h66;
        #10 addr <= 4'h7;
        in   <= 8'h77;
        #10 addr <= 4'h8;
        in   <= 8'h88;
        #10 addr <= 4'h9;
        in   <= 8'h99;
        #10 addr <= 4'hA;
        in   <= 8'hAA;
        #10 addr <= 4'hB;
        in   <= 8'hBB;
        #10 addr <= 4'hC;
        in   <= 8'hCC;
        #10 addr <= 4'hD;
        in   <= 8'hDD;
        #10 addr <= 4'hE;
        in   <= 8'hEE;
        #10 addr <= 4'hF;
        in   <= 8'hFF;
        #10 addr <= 4'h0;
        we   <= 1'b0;
        #10 addr <= 4'h1;
        #10 addr <= 4'h2;
        #10 addr <= 4'h3;
        #10 addr <= 4'h4;
        #10 addr <= 4'h5;
        #10 addr <= 4'h6;
        #10 addr <= 4'h7;
        #10 addr <= 4'h8;
        #10 addr <= 4'h9;
        #10 addr <= 4'hA;
        #10 addr <= 4'hB;
        #10 addr <= 4'hC;
        #10 addr <= 4'hD;
        #10 addr <= 4'hE;
        #10 addr <= 4'hF;
        #10 $finish;
    end
    // block memory
    reg         ena;
    wire [7:0]  out_block;
    initial begin
        ena <= 1'b1;
        #330 ena <= 1'b0;
        forever
            #5 ena <= ~ena;
    end
    block_ram       test_block(
        .clka(clk),
        .addra(addr),
        .dina(in),
        .douta(out_block),
        .ena(ena),
        .wea(we)
    );
    // distributed memory
    wire [7:0]  out_dist;
    distributed_ram test_dist(
        .clk(clk),
        .a(addr),
        .d(in),
        .we(we),
        .spo(out_dist)
    );
endmodule
