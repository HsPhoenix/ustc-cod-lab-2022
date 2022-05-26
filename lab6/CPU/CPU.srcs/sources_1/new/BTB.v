`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/05/23 14:36:24
// Design Name: 
// Module Name: btb
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

module btb #(
    parameter BUF_LEN = 4
) (
    input             clk,
    input             rst,
    input             enable,
    input      [29:0] pc,
    input      [29:0] IDEX_pc,
    input             IDEX_branch,
    input             branch_taken,
    input      [31:0] IDEX_branch_target,
    input             IDEX_btb_hit,
    output reg [1:0]  pc_sel,
    output reg        btb_hit,
    output reg [31:0] btb_target,
    output            btb_fail,

    // Counters
    output reg [31:0] branch_cnt,
    output reg [31:0] btb_succ_cnt,
    output reg [31:0] btb_fail_cnt
);
    localparam TAG_LEN  = 30 - BUF_LEN;
    localparam BUF_SIZE = 1 << BUF_LEN;

    localparam STRONG_HIT  = 2'b11;
    localparam WEAK_HIT    = 2'b10;
    localparam WEAK_MISS   = 2'b01;
    localparam STRONG_MISS = 2'b00;

    // Buffer Register
    reg [TAG_LEN - 1 : 0] tag    [BUF_SIZE - 1 : 0];
    reg [31:0]            target [BUF_SIZE - 1 : 0];
    reg                   valid  [BUF_SIZE - 1 : 0];
    reg [1:0]             state  [BUF_SIZE - 1 : 0];

    // PC tag and index
    wire [TAG_LEN - 1 : 0] pc_tag;
    wire [BUF_LEN - 1 : 0] pc_idx;
    wire [TAG_LEN - 1 : 0] IDEX_pc_tag;
    wire [BUF_LEN - 1 : 0] IDEX_pc_idx;

    assign {pc_tag,      pc_idx}      = pc;
    assign {IDEX_pc_tag, IDEX_pc_idx} = IDEX_pc;

    // Generate Target
    always @(*) begin
        if (rst) begin
            btb_hit    = 1'b0;
            btb_target = 32'h0;
        end
        else if (valid[pc_idx] && 
                 (pc_tag == tag[pc_idx]) && 
                 state[pc_idx][1]) begin
            btb_hit    = 1'b1;
            btb_target = target[pc_idx];
        end
        else begin
            btb_hit    = 1'b0;
            btb_target = 32'h0;
        end
    end
    
    // Buffer Update
    reg btb_p_nt;  // branch predicted but not taken 
    reg btb_np_t;  // not branch predicted but taken

    assign btb_fail = btb_p_nt | btb_np_t;

    always @(*) begin
        if (rst) begin
            btb_p_nt  = 1'b0;
            btb_np_t  = 1'b0;
        end
        else begin
            btb_p_nt = (IDEX_btb_hit) & (~branch_taken);
            btb_np_t = (~IDEX_btb_hit) & (branch_taken);
        end
    end

    integer i = 0;
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            for (i = 0; i < BUF_SIZE; i = i + 1) begin
                tag[i]    <= 0;
                target[i] <= 32'h0;
                valid[i]  <= 1'b0;
                state[i]  <= WEAK_MISS;
            end
        end
        else if (enable && IDEX_branch) begin
            // tag matched, update state
            if ((tag[IDEX_pc_idx] == IDEX_pc_tag) && valid[IDEX_pc_idx]) begin
                case (state[IDEX_pc_idx])
                STRONG_HIT:
                    state[IDEX_pc_idx] <= btb_fail ? WEAK_HIT  : STRONG_HIT;
                WEAK_HIT:
                    state[IDEX_pc_idx] <= btb_fail ? WEAK_MISS : STRONG_HIT;
                WEAK_MISS:
                    state[IDEX_pc_idx] <= btb_fail ? WEAK_HIT  : STRONG_MISS;
                STRONG_MISS:
                    state[IDEX_pc_idx] <= btb_fail ? WEAK_MISS : STRONG_MISS;
                endcase
            end
            // tag not matched, change buffer
            else begin
                tag[IDEX_pc_idx]    <= IDEX_pc_tag;
                target[IDEX_pc_idx] <= IDEX_branch_target;
                valid[IDEX_pc_idx]  <= 1'b1;
                state[IDEX_pc_idx]  <= WEAK_MISS;
            end
        end
    end
    // PC Controller
    always @(*) begin
        if (btb_p_nt)      pc_sel <= 2'b11;  // IDEX_pc_next
        else if (btb_np_t) pc_sel <= 2'b10;  // pc_add
        else if (btb_hit)  pc_sel <= 2'b01;  // btb_target
        else               pc_sel <= 2'b00;  // pc_next
    end

    // Counter Part
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            branch_cnt   <= 32'h0;
            btb_succ_cnt <= 32'h0;
            btb_fail_cnt <= 32'h0;
        end
        else begin
            if (IDEX_branch) begin
                branch_cnt   <= branch_cnt   + 32'h1;
                if (btb_fail) btb_fail_cnt <= btb_fail_cnt + 32'h1;
                else          btb_succ_cnt <= btb_succ_cnt + 32'h1;
            end
            
        end
    end
endmodule  //btb
