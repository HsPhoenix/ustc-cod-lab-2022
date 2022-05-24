`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/05/22 21:23:27
// Design Name: 
// Module Name: Data_Mem
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


module data_mem(
    input             clk,
    input      [2:0]  funct3,
    input      [9:0]  addr,
    input      [31:0] data,
    input             mem_read,
    input             mem_we,
    input      [7:0]  dbg_addr,
    output reg [31:0] mem_data,
    output     [31:0] dbg_data
);
    reg  [31:0] data_in;
    wire [31:0] data_out;

    always @(*) begin
        if (mem_we) begin
            case(funct3)
                3'b000:
                case(addr[1:0]) 
                    2'b00: data_in = {data_out[31:8], data[7:0]};
                    2'b01: data_in = {data_out[31:16], data[7:0], data_out[7:0]};
                    2'b10: data_in = {data_out[31:24], data[7:0], data_out[15:0]};
                    2'b11: data_in = {data[7:0], data_out[23:0]};
                endcase
                3'b001:
                case (addr[1])
                    1'b0: data_in = {data_out[31:16], data[15:0]};
                    1'b1: data_in = {data[15:0], data_out[15:0]};
                endcase
                3'b010: data_in = data;
                default: data_in = data_out;
            endcase
        end
        else begin
            data_in = data_out;
        end
    end

    always @(*) begin
        if (mem_read) begin
            case (funct3)
                3'b000:
                case (addr[1:0])
                    2'b00: mem_data = {{24{data_out[7]}},  data_out[7:0]};
                    2'b01: mem_data = {{24{data_out[15]}}, data_out[15:8]};
                    2'b10: mem_data = {{24{data_out[23]}}, data_out[23:16]};
                    2'b11: mem_data = {{24{data_out[31]}}, data_out[31:24]};
                endcase
                3'b001:
                case (addr[1])
                    1'b0: mem_data = {{16{data_out[15]}}, data_out[15:0]};
                    1'b1: mem_data = {{16{data_out[31]}}, data_out[31:16]};
                endcase
                3'b010: mem_data = data_out;
                3'b100: 
                case (addr[1:0])
                    2'b00: mem_data = {24'h0, data_out[7:0]};
                    2'b01: mem_data = {24'h0, data_out[15:8]};
                    2'b10: mem_data = {24'h0, data_out[23:16]};
                    2'b11: mem_data = {24'h0, data_out[31:24]};
                endcase
                3'b101:
                case (addr[1])
                    1'b0: mem_data = {16'h0, data_out[15:0]};
                    1'b1: mem_data = {16'h0, data_out[31:16]};
                endcase
                default: mem_data = data_out;
            endcase
        end
        else begin
            mem_data = data_out;
        end
    end

    dual_port_ram Data_Mem(
        .clk  (clk),
        .we   (mem_we),
        .a    (addr[9:2]),
        .dpra (dbg_addr),
        .d    (data_in),
        .spo  (data_out),
        .dpo  (dbg_data)
    );
endmodule
