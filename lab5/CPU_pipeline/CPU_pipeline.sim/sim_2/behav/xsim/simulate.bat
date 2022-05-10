@echo off
REM ****************************************************************************
REM Vivado (TM) v2019.1 (64-bit)
REM
REM Filename    : simulate.bat
REM Simulator   : Xilinx Vivado Simulator
REM Description : Script for simulating the design by launching the simulator
REM
REM Generated by Vivado on Wed May 11 00:01:40 +0800 2022
REM SW Build 2552052 on Fri May 24 14:49:42 MDT 2019
REM
REM Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
REM
REM usage: simulate.bat
REM
REM ****************************************************************************
echo "xsim tb_behav -key {Behavioral:sim_2:Functional:tb} -tclbatch tb.tcl -view D:/Users/Documents/GitHub/COD_lab/lab5/CPU_pipeline/fib_sim.wcfg -log simulate.log"
call xsim  tb_behav -key {Behavioral:sim_2:Functional:tb} -tclbatch tb.tcl -view D:/Users/Documents/GitHub/COD_lab/lab5/CPU_pipeline/fib_sim.wcfg -log simulate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
