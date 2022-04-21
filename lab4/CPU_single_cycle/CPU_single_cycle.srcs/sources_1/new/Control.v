`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/04/17 15:15:17
// Design Name: 
// Module Name: control
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


module control (
    input       [6:0] inst,
    output reg  [2:0] Imm_Gen,
    output reg  [1:0] RegSrc,
    output      [1:0] ALUop,
    output            jal,
    output            jalr,
    output            Branch,
    output            MemWrite,
    output            ALUSrc,
    output            RegWrite
);
    reg [5:0] type;
    always @(*) begin
        case (inst) 
        7'b0110011: type = 6'b000001; // R-type
        7'b1100111,
        7'b0000011,
        7'b0010011: type = 6'b000010; // I-type
        7'b1100011: type = 6'b000100; // B-type
        7'b0100011: type = 6'b001000; // S-type
        7'b1101111: type = 6'b010000; // J-type
        7'b0010111: type = 6'b100000; // U-type
        default:    type = 6'b000000;
        endcase
    end

    assign jal      = type[4]; // J-type
    assign jalr     = (inst == 7'b1100111);
    assign Branch   = type[2]; // B-type
    assign MemWrite = type[3]; // S-type
    assign ALUSrc   = type[1] | type[3]; // I-type, S-type
    assign RegWrite = type[0] | type[1] | type[4] | type[5]; // R-type, I-type, J-type, U-type
    assign ALUop    = {type[2] , (type[0] | inst == 7'b0010011)};

    always @(*) begin
        case (type)
        6'b000010: Imm_Gen = 3'b001; // I-type
        6'b000100: Imm_Gen = 3'b010; // B-type
        6'b001000: Imm_Gen = 3'b011; // S-type
        6'b010000: Imm_Gen = 3'b100; // J-type
        6'b100000: Imm_Gen = 3'b101; // U-type
        default:   Imm_Gen = 3'b000;
        endcase
    end

    always @(*) begin
        if (type[5])                 // auipc
            RegSrc = 2'b11;
        else if (jalr || type[4])    // jal(r)
            RegSrc = 2'b10;
        else if (inst == 7'b0000011) // load
            RegSrc = 2'b01;
        else
            RegSrc = 2'b00;
    end
endmodule
