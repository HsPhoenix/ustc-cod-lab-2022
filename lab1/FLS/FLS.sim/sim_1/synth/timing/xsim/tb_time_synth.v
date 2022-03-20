// Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2019.1 (win64) Build 2552052 Fri May 24 14:49:42 MDT 2019
// Date        : Sun Mar 20 16:35:08 2022
// Host        : LAPTOP-5ODQCLAT running 64-bit major release  (build 9200)
// Command     : write_verilog -mode timesim -nolib -sdf_anno true -force -file
//               D:/Users/Documents/GitHub/COD_lab/lab1/FLS/FLS.sim/sim_1/synth/timing/xsim/tb_time_synth.v
// Design      : fls
// Purpose     : This verilog netlist is a timing simulation representation of the design and should not be modified or
//               synthesized. Please ensure that this netlist is used with the corresponding SDF file.
// Device      : xc7a100tcsg324-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps
`define XIL_TIMING

module alu
   (D,
    Q,
    \_inferred__0/i__carry__0_0 ,
    d_IBUF,
    sel);
  output [6:0]D;
  input [6:0]Q;
  input [6:0]\_inferred__0/i__carry__0_0 ;
  input [6:0]d_IBUF;
  input [0:0]sel;

  wire [6:0]D;
  wire [6:0]Q;
  wire [6:0]\_inferred__0/i__carry__0_0 ;
  wire \_inferred__0/i__carry__0_n_2 ;
  wire \_inferred__0/i__carry__0_n_3 ;
  wire \_inferred__0/i__carry_n_0 ;
  wire \_inferred__0/i__carry_n_1 ;
  wire \_inferred__0/i__carry_n_2 ;
  wire \_inferred__0/i__carry_n_3 ;
  wire [6:0]alu_out;
  wire [6:0]d_IBUF;
  wire i__carry__0_i_1_n_0;
  wire i__carry__0_i_2_n_0;
  wire i__carry__0_i_3_n_0;
  wire i__carry_i_1_n_0;
  wire i__carry_i_2_n_0;
  wire i__carry_i_3_n_0;
  wire i__carry_i_4_n_0;
  wire [0:0]sel;
  wire [3:2]\NLW__inferred__0/i__carry__0_CO_UNCONNECTED ;
  wire [3:3]\NLW__inferred__0/i__carry__0_O_UNCONNECTED ;

  (* METHODOLOGY_DRC_VIOS = "{SYNTH-8 {cell *THIS*}}" *) 
  CARRY4 \_inferred__0/i__carry 
       (.CI(1'b0),
        .CO({\_inferred__0/i__carry_n_0 ,\_inferred__0/i__carry_n_1 ,\_inferred__0/i__carry_n_2 ,\_inferred__0/i__carry_n_3 }),
        .CYINIT(1'b0),
        .DI(Q[3:0]),
        .O(alu_out[3:0]),
        .S({i__carry_i_1_n_0,i__carry_i_2_n_0,i__carry_i_3_n_0,i__carry_i_4_n_0}));
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-8 {cell *THIS*}}" *) 
  CARRY4 \_inferred__0/i__carry__0 
       (.CI(\_inferred__0/i__carry_n_0 ),
        .CO({\NLW__inferred__0/i__carry__0_CO_UNCONNECTED [3:2],\_inferred__0/i__carry__0_n_2 ,\_inferred__0/i__carry__0_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,Q[5:4]}),
        .O({\NLW__inferred__0/i__carry__0_O_UNCONNECTED [3],alu_out[6:4]}),
        .S({1'b0,i__carry__0_i_1_n_0,i__carry__0_i_2_n_0,i__carry__0_i_3_n_0}));
  LUT3 #(
    .INIT(8'hAC)) 
    \f[0]_i_1 
       (.I0(alu_out[0]),
        .I1(d_IBUF[0]),
        .I2(sel),
        .O(D[0]));
  (* SOFT_HLUTNM = "soft_lutpair2" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \f[1]_i_1 
       (.I0(alu_out[1]),
        .I1(d_IBUF[1]),
        .I2(sel),
        .O(D[1]));
  (* SOFT_HLUTNM = "soft_lutpair2" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \f[2]_i_1 
       (.I0(alu_out[2]),
        .I1(d_IBUF[2]),
        .I2(sel),
        .O(D[2]));
  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \f[3]_i_1 
       (.I0(alu_out[3]),
        .I1(d_IBUF[3]),
        .I2(sel),
        .O(D[3]));
  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \f[4]_i_1 
       (.I0(alu_out[4]),
        .I1(d_IBUF[4]),
        .I2(sel),
        .O(D[4]));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \f[5]_i_1 
       (.I0(alu_out[5]),
        .I1(d_IBUF[5]),
        .I2(sel),
        .O(D[5]));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \f[6]_i_2 
       (.I0(alu_out[6]),
        .I1(d_IBUF[6]),
        .I2(sel),
        .O(D[6]));
  LUT2 #(
    .INIT(4'h6)) 
    i__carry__0_i_1
       (.I0(Q[6]),
        .I1(\_inferred__0/i__carry__0_0 [6]),
        .O(i__carry__0_i_1_n_0));
  LUT2 #(
    .INIT(4'h6)) 
    i__carry__0_i_2
       (.I0(Q[5]),
        .I1(\_inferred__0/i__carry__0_0 [5]),
        .O(i__carry__0_i_2_n_0));
  LUT2 #(
    .INIT(4'h6)) 
    i__carry__0_i_3
       (.I0(Q[4]),
        .I1(\_inferred__0/i__carry__0_0 [4]),
        .O(i__carry__0_i_3_n_0));
  LUT2 #(
    .INIT(4'h6)) 
    i__carry_i_1
       (.I0(Q[3]),
        .I1(\_inferred__0/i__carry__0_0 [3]),
        .O(i__carry_i_1_n_0));
  LUT2 #(
    .INIT(4'h6)) 
    i__carry_i_2
       (.I0(Q[2]),
        .I1(\_inferred__0/i__carry__0_0 [2]),
        .O(i__carry_i_2_n_0));
  LUT2 #(
    .INIT(4'h6)) 
    i__carry_i_3
       (.I0(Q[1]),
        .I1(\_inferred__0/i__carry__0_0 [1]),
        .O(i__carry_i_3_n_0));
  LUT2 #(
    .INIT(4'h6)) 
    i__carry_i_4
       (.I0(Q[0]),
        .I1(\_inferred__0/i__carry__0_0 [0]),
        .O(i__carry_i_4_n_0));
endmodule

(* NotValidForBitStream *)
module fls
   (clk,
    rst,
    en,
    d,
    f);
  input clk;
  input rst;
  input en;
  input [6:0]d;
  output [6:0]f;

  wire \a_reg_n_0_[0] ;
  wire \a_reg_n_0_[1] ;
  wire \a_reg_n_0_[2] ;
  wire \a_reg_n_0_[3] ;
  wire \a_reg_n_0_[4] ;
  wire \a_reg_n_0_[5] ;
  wire \a_reg_n_0_[6] ;
  wire adder_n_0;
  wire adder_n_1;
  wire adder_n_2;
  wire adder_n_3;
  wire adder_n_4;
  wire adder_n_5;
  wire adder_n_6;
  wire clk;
  wire clk_IBUF;
  wire clk_IBUF_BUFG;
  wire [6:0]d;
  wire [6:0]d_IBUF;
  wire en;
  wire en_IBUF;
  wire [6:0]f;
  wire [6:0]f_OBUF;
  wire fsm1_n_2;
  wire fsm1_n_3;
  wire fsm1_n_4;
  wire fsm1_n_5;
  wire fsm1_n_6;
  wire fsm1_n_7;
  wire fsm1_n_8;
  wire fsm1_n_9;
  wire get_en_edge_n_2;
  wire get_en_edge_n_3;
  wire get_en_edge_n_4;
  wire rst;
  wire rst_IBUF;
  wire [1:0]sel;
  wire signal_r1;
  wire signal_r2;

initial begin
 $sdf_annotate("tb_time_synth.sdf",,,,"tool_control");
end
  FDRE #(
    .INIT(1'b0)) 
    \a_reg[0] 
       (.C(clk_IBUF_BUFG),
        .CE(get_en_edge_n_4),
        .D(fsm1_n_9),
        .Q(\a_reg_n_0_[0] ),
        .R(rst_IBUF));
  FDRE #(
    .INIT(1'b0)) 
    \a_reg[1] 
       (.C(clk_IBUF_BUFG),
        .CE(get_en_edge_n_4),
        .D(fsm1_n_8),
        .Q(\a_reg_n_0_[1] ),
        .R(rst_IBUF));
  FDRE #(
    .INIT(1'b0)) 
    \a_reg[2] 
       (.C(clk_IBUF_BUFG),
        .CE(get_en_edge_n_4),
        .D(fsm1_n_7),
        .Q(\a_reg_n_0_[2] ),
        .R(rst_IBUF));
  FDRE #(
    .INIT(1'b0)) 
    \a_reg[3] 
       (.C(clk_IBUF_BUFG),
        .CE(get_en_edge_n_4),
        .D(fsm1_n_6),
        .Q(\a_reg_n_0_[3] ),
        .R(rst_IBUF));
  FDRE #(
    .INIT(1'b0)) 
    \a_reg[4] 
       (.C(clk_IBUF_BUFG),
        .CE(get_en_edge_n_4),
        .D(fsm1_n_5),
        .Q(\a_reg_n_0_[4] ),
        .R(rst_IBUF));
  FDRE #(
    .INIT(1'b0)) 
    \a_reg[5] 
       (.C(clk_IBUF_BUFG),
        .CE(get_en_edge_n_4),
        .D(fsm1_n_4),
        .Q(\a_reg_n_0_[5] ),
        .R(rst_IBUF));
  FDRE #(
    .INIT(1'b0)) 
    \a_reg[6] 
       (.C(clk_IBUF_BUFG),
        .CE(get_en_edge_n_4),
        .D(fsm1_n_3),
        .Q(\a_reg_n_0_[6] ),
        .R(rst_IBUF));
  alu adder
       (.D({adder_n_0,adder_n_1,adder_n_2,adder_n_3,adder_n_4,adder_n_5,adder_n_6}),
        .Q(f_OBUF),
        .\_inferred__0/i__carry__0_0 ({\a_reg_n_0_[6] ,\a_reg_n_0_[5] ,\a_reg_n_0_[4] ,\a_reg_n_0_[3] ,\a_reg_n_0_[2] ,\a_reg_n_0_[1] ,\a_reg_n_0_[0] }),
        .d_IBUF(d_IBUF),
        .sel(sel[1]));
  BUFG clk_IBUF_BUFG_inst
       (.I(clk_IBUF),
        .O(clk_IBUF_BUFG));
  IBUF clk_IBUF_inst
       (.I(clk),
        .O(clk_IBUF));
  IBUF \d_IBUF[0]_inst 
       (.I(d[0]),
        .O(d_IBUF[0]));
  IBUF \d_IBUF[1]_inst 
       (.I(d[1]),
        .O(d_IBUF[1]));
  IBUF \d_IBUF[2]_inst 
       (.I(d[2]),
        .O(d_IBUF[2]));
  IBUF \d_IBUF[3]_inst 
       (.I(d[3]),
        .O(d_IBUF[3]));
  IBUF \d_IBUF[4]_inst 
       (.I(d[4]),
        .O(d_IBUF[4]));
  IBUF \d_IBUF[5]_inst 
       (.I(d[5]),
        .O(d_IBUF[5]));
  IBUF \d_IBUF[6]_inst 
       (.I(d[6]),
        .O(d_IBUF[6]));
  IBUF en_IBUF_inst
       (.I(en),
        .O(en_IBUF));
  OBUF \f_OBUF[0]_inst 
       (.I(f_OBUF[0]),
        .O(f[0]));
  OBUF \f_OBUF[1]_inst 
       (.I(f_OBUF[1]),
        .O(f[1]));
  OBUF \f_OBUF[2]_inst 
       (.I(f_OBUF[2]),
        .O(f[2]));
  OBUF \f_OBUF[3]_inst 
       (.I(f_OBUF[3]),
        .O(f[3]));
  OBUF \f_OBUF[4]_inst 
       (.I(f_OBUF[4]),
        .O(f[4]));
  OBUF \f_OBUF[5]_inst 
       (.I(f_OBUF[5]),
        .O(f[5]));
  OBUF \f_OBUF[6]_inst 
       (.I(f_OBUF[6]),
        .O(f[6]));
  FDRE #(
    .INIT(1'b0)) 
    \f_reg[0] 
       (.C(clk_IBUF_BUFG),
        .CE(get_en_edge_n_3),
        .D(adder_n_6),
        .Q(f_OBUF[0]),
        .R(rst_IBUF));
  FDRE #(
    .INIT(1'b0)) 
    \f_reg[1] 
       (.C(clk_IBUF_BUFG),
        .CE(get_en_edge_n_3),
        .D(adder_n_5),
        .Q(f_OBUF[1]),
        .R(rst_IBUF));
  FDRE #(
    .INIT(1'b0)) 
    \f_reg[2] 
       (.C(clk_IBUF_BUFG),
        .CE(get_en_edge_n_3),
        .D(adder_n_4),
        .Q(f_OBUF[2]),
        .R(rst_IBUF));
  FDRE #(
    .INIT(1'b0)) 
    \f_reg[3] 
       (.C(clk_IBUF_BUFG),
        .CE(get_en_edge_n_3),
        .D(adder_n_3),
        .Q(f_OBUF[3]),
        .R(rst_IBUF));
  FDRE #(
    .INIT(1'b0)) 
    \f_reg[4] 
       (.C(clk_IBUF_BUFG),
        .CE(get_en_edge_n_3),
        .D(adder_n_2),
        .Q(f_OBUF[4]),
        .R(rst_IBUF));
  FDRE #(
    .INIT(1'b0)) 
    \f_reg[5] 
       (.C(clk_IBUF_BUFG),
        .CE(get_en_edge_n_3),
        .D(adder_n_1),
        .Q(f_OBUF[5]),
        .R(rst_IBUF));
  FDRE #(
    .INIT(1'b0)) 
    \f_reg[6] 
       (.C(clk_IBUF_BUFG),
        .CE(get_en_edge_n_3),
        .D(adder_n_0),
        .Q(f_OBUF[6]),
        .R(rst_IBUF));
  fsm fsm1
       (.CLK(clk_IBUF_BUFG),
        .D({fsm1_n_3,fsm1_n_4,fsm1_n_5,fsm1_n_6,fsm1_n_7,fsm1_n_8,fsm1_n_9}),
        .\FSM_onehot_curr_state_reg[0]_0 (fsm1_n_2),
        .\FSM_onehot_curr_state_reg[0]_1 (get_en_edge_n_2),
        .Q(f_OBUF),
        .d_IBUF(d_IBUF),
        .rst_IBUF(rst_IBUF),
        .sel(sel),
        .signal_r1(signal_r1),
        .signal_r2(signal_r2));
  get_edge get_en_edge
       (.CLK(clk_IBUF_BUFG),
        .E(get_en_edge_n_3),
        .\FSM_onehot_curr_state_reg[0] (get_en_edge_n_2),
        .\FSM_onehot_curr_state_reg[0]_0 (fsm1_n_2),
        .en_IBUF(en_IBUF),
        .rst_IBUF(rst_IBUF),
        .sel(sel),
        .signal_r1(signal_r1),
        .signal_r2(signal_r2),
        .signal_r2_reg_0(get_en_edge_n_4));
  IBUF rst_IBUF_inst
       (.I(rst),
        .O(rst_IBUF));
endmodule

module fsm
   (sel,
    \FSM_onehot_curr_state_reg[0]_0 ,
    D,
    CLK,
    \FSM_onehot_curr_state_reg[0]_1 ,
    signal_r2,
    signal_r1,
    rst_IBUF,
    Q,
    d_IBUF);
  output [1:0]sel;
  output \FSM_onehot_curr_state_reg[0]_0 ;
  output [6:0]D;
  input CLK;
  input \FSM_onehot_curr_state_reg[0]_1 ;
  input signal_r2;
  input signal_r1;
  input rst_IBUF;
  input [6:0]Q;
  input [6:0]d_IBUF;

  wire CLK;
  wire [6:0]D;
  wire \FSM_onehot_curr_state[1]_i_1_n_0 ;
  wire \FSM_onehot_curr_state[2]_i_1_n_0 ;
  wire \FSM_onehot_curr_state_reg[0]_0 ;
  wire \FSM_onehot_curr_state_reg[0]_1 ;
  wire [6:0]Q;
  wire [6:0]d_IBUF;
  wire rst_IBUF;
  wire [1:0]sel;
  wire signal_r1;
  wire signal_r2;

  LUT5 #(
    .INIT(32'h0000BA8A)) 
    \FSM_onehot_curr_state[1]_i_1 
       (.I0(sel[0]),
        .I1(signal_r2),
        .I2(signal_r1),
        .I3(\FSM_onehot_curr_state_reg[0]_0 ),
        .I4(rst_IBUF),
        .O(\FSM_onehot_curr_state[1]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'h0000BAAA)) 
    \FSM_onehot_curr_state[2]_i_1 
       (.I0(sel[1]),
        .I1(signal_r2),
        .I2(signal_r1),
        .I3(sel[0]),
        .I4(rst_IBUF),
        .O(\FSM_onehot_curr_state[2]_i_1_n_0 ));
  (* FSM_ENCODED_STATES = "initiated:001,a_loaded:010,b_loaded:100," *) 
  FDRE #(
    .INIT(1'b1)) 
    \FSM_onehot_curr_state_reg[0] 
       (.C(CLK),
        .CE(1'b1),
        .D(\FSM_onehot_curr_state_reg[0]_1 ),
        .Q(\FSM_onehot_curr_state_reg[0]_0 ),
        .R(1'b0));
  (* FSM_ENCODED_STATES = "initiated:001,a_loaded:010,b_loaded:100," *) 
  FDRE #(
    .INIT(1'b0)) 
    \FSM_onehot_curr_state_reg[1] 
       (.C(CLK),
        .CE(1'b1),
        .D(\FSM_onehot_curr_state[1]_i_1_n_0 ),
        .Q(sel[0]),
        .R(1'b0));
  (* FSM_ENCODED_STATES = "initiated:001,a_loaded:010,b_loaded:100," *) 
  FDRE #(
    .INIT(1'b0)) 
    \FSM_onehot_curr_state_reg[2] 
       (.C(CLK),
        .CE(1'b1),
        .D(\FSM_onehot_curr_state[2]_i_1_n_0 ),
        .Q(sel[1]),
        .R(1'b0));
  LUT3 #(
    .INIT(8'hAC)) 
    \a[0]_i_1 
       (.I0(Q[0]),
        .I1(d_IBUF[0]),
        .I2(sel[1]),
        .O(D[0]));
  (* SOFT_HLUTNM = "soft_lutpair5" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \a[1]_i_1 
       (.I0(Q[1]),
        .I1(d_IBUF[1]),
        .I2(sel[1]),
        .O(D[1]));
  (* SOFT_HLUTNM = "soft_lutpair5" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \a[2]_i_1 
       (.I0(Q[2]),
        .I1(d_IBUF[2]),
        .I2(sel[1]),
        .O(D[2]));
  (* SOFT_HLUTNM = "soft_lutpair4" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \a[3]_i_1 
       (.I0(Q[3]),
        .I1(d_IBUF[3]),
        .I2(sel[1]),
        .O(D[3]));
  (* SOFT_HLUTNM = "soft_lutpair4" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \a[4]_i_1 
       (.I0(Q[4]),
        .I1(d_IBUF[4]),
        .I2(sel[1]),
        .O(D[4]));
  (* SOFT_HLUTNM = "soft_lutpair3" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \a[5]_i_1 
       (.I0(Q[5]),
        .I1(d_IBUF[5]),
        .I2(sel[1]),
        .O(D[5]));
  (* SOFT_HLUTNM = "soft_lutpair3" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \a[6]_i_2 
       (.I0(Q[6]),
        .I1(d_IBUF[6]),
        .I2(sel[1]),
        .O(D[6]));
endmodule

module get_edge
   (signal_r2,
    signal_r1,
    \FSM_onehot_curr_state_reg[0] ,
    E,
    signal_r2_reg_0,
    CLK,
    rst_IBUF,
    en_IBUF,
    \FSM_onehot_curr_state_reg[0]_0 ,
    sel);
  output signal_r2;
  output signal_r1;
  output \FSM_onehot_curr_state_reg[0] ;
  output [0:0]E;
  output [0:0]signal_r2_reg_0;
  input CLK;
  input rst_IBUF;
  input en_IBUF;
  input \FSM_onehot_curr_state_reg[0]_0 ;
  input [1:0]sel;

  wire CLK;
  wire [0:0]E;
  wire \FSM_onehot_curr_state_reg[0] ;
  wire \FSM_onehot_curr_state_reg[0]_0 ;
  wire en_IBUF;
  wire rst_IBUF;
  wire [1:0]sel;
  wire signal_r1;
  wire signal_r2;
  wire [0:0]signal_r2_reg_0;

  LUT4 #(
    .INIT(16'hFF8A)) 
    \FSM_onehot_curr_state[0]_i_1 
       (.I0(\FSM_onehot_curr_state_reg[0]_0 ),
        .I1(signal_r2),
        .I2(signal_r1),
        .I3(rst_IBUF),
        .O(\FSM_onehot_curr_state_reg[0] ));
  (* SOFT_HLUTNM = "soft_lutpair6" *) 
  LUT3 #(
    .INIT(8'h04)) 
    \a[6]_i_1 
       (.I0(signal_r2),
        .I1(signal_r1),
        .I2(sel[0]),
        .O(signal_r2_reg_0));
  (* SOFT_HLUTNM = "soft_lutpair6" *) 
  LUT4 #(
    .INIT(16'h0444)) 
    \f[6]_i_1 
       (.I0(signal_r2),
        .I1(signal_r1),
        .I2(sel[0]),
        .I3(sel[1]),
        .O(E));
  FDRE #(
    .INIT(1'b0)) 
    signal_r1_reg
       (.C(CLK),
        .CE(1'b1),
        .D(en_IBUF),
        .Q(signal_r1),
        .R(rst_IBUF));
  FDRE #(
    .INIT(1'b0)) 
    signal_r2_reg
       (.C(CLK),
        .CE(1'b1),
        .D(signal_r1),
        .Q(signal_r2),
        .R(1'b0));
endmodule
`ifndef GLBL
`define GLBL
`timescale  1 ps / 1 ps

module glbl ();

    parameter ROC_WIDTH = 100000;
    parameter TOC_WIDTH = 0;

//--------   STARTUP Globals --------------
    wire GSR;
    wire GTS;
    wire GWE;
    wire PRLD;
    tri1 p_up_tmp;
    tri (weak1, strong0) PLL_LOCKG = p_up_tmp;

    wire PROGB_GLBL;
    wire CCLKO_GLBL;
    wire FCSBO_GLBL;
    wire [3:0] DO_GLBL;
    wire [3:0] DI_GLBL;
   
    reg GSR_int;
    reg GTS_int;
    reg PRLD_int;

//--------   JTAG Globals --------------
    wire JTAG_TDO_GLBL;
    wire JTAG_TCK_GLBL;
    wire JTAG_TDI_GLBL;
    wire JTAG_TMS_GLBL;
    wire JTAG_TRST_GLBL;

    reg JTAG_CAPTURE_GLBL;
    reg JTAG_RESET_GLBL;
    reg JTAG_SHIFT_GLBL;
    reg JTAG_UPDATE_GLBL;
    reg JTAG_RUNTEST_GLBL;

    reg JTAG_SEL1_GLBL = 0;
    reg JTAG_SEL2_GLBL = 0 ;
    reg JTAG_SEL3_GLBL = 0;
    reg JTAG_SEL4_GLBL = 0;

    reg JTAG_USER_TDO1_GLBL = 1'bz;
    reg JTAG_USER_TDO2_GLBL = 1'bz;
    reg JTAG_USER_TDO3_GLBL = 1'bz;
    reg JTAG_USER_TDO4_GLBL = 1'bz;

    assign (strong1, weak0) GSR = GSR_int;
    assign (strong1, weak0) GTS = GTS_int;
    assign (weak1, weak0) PRLD = PRLD_int;

    initial begin
	GSR_int = 1'b1;
	PRLD_int = 1'b1;
	#(ROC_WIDTH)
	GSR_int = 1'b0;
	PRLD_int = 1'b0;
    end

    initial begin
	GTS_int = 1'b1;
	#(TOC_WIDTH)
	GTS_int = 1'b0;
    end

endmodule
`endif
