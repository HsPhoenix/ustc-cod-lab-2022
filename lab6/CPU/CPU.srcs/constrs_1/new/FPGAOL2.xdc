## This file is a general .xdc for FPGAOL2_BOARD (adopted from Nexys4 DDR Rev. C)
## To use it in a project:
## - uncomment the lines corresponding to used pins
## - rename the used ports (in each line, after get_ports) according to the top level signal names in the project

## Clock signal
set_property -dict { PACKAGE_PIN B8    IOSTANDARD LVCMOS33 } [get_ports { clk }]; #IO_L12P_T1_MRCC_35 Sch=clk100mhz
create_clock -add -name sys_clk_pin -period 10.00 -waveform {0 5} [get_ports { clk }];


## FPGAOL2 LED (signle-digit-SEGPLAY)
set_property -dict { PACKAGE_PIN K17   IOSTANDARD LVCMOS33 } [get_ports { out_0[0] }]; #IO_L18P_T2_A24_15 Sch=led[0]
set_property -dict { PACKAGE_PIN K18   IOSTANDARD LVCMOS33 } [get_ports { out_0[1] }]; #IO_L24P_T3_RS1_15 Sch=led[1]
set_property -dict { PACKAGE_PIN L14   IOSTANDARD LVCMOS33 } [get_ports { out_0[2] }]; #IO_L17N_T2_A25_15 Sch=led[2]
set_property -dict { PACKAGE_PIN M14   IOSTANDARD LVCMOS33 } [get_ports { out_0[3] }]; #IO_L8P_T1_D11_14 Sch=led[3]
set_property -dict { PACKAGE_PIN L18   IOSTANDARD LVCMOS33 } [get_ports { out_0[4] }]; #IO_L7P_T1_D09_14 Sch=led[4]
set_property -dict { PACKAGE_PIN M18   IOSTANDARD LVCMOS33 } [get_ports { check[0] }]; #IO_L18N_T2_A11_D27_14 Sch=led[5]
set_property -dict { PACKAGE_PIN R12   IOSTANDARD LVCMOS33 } [get_ports { check[1] }]; #IO_L17P_T2_A14_D30_14 Sch=led[6]
set_property -dict { PACKAGE_PIN R13   IOSTANDARD LVCMOS33 } [get_ports { ready }]; #IO_L18P_T2_A12_D28_14 Sch=led[7]

## FPGAOL2 SWITCH
set_property -dict { PACKAGE_PIN M13   IOSTANDARD LVCMOS33 } [get_ports { in[0] }]; #IO_L24N_T3_RS0_15 Sch=sw[0]
set_property -dict { PACKAGE_PIN R18   IOSTANDARD LVCMOS33 } [get_ports { in[1] }]; #IO_L3N_T0_DQS_EMCCLK_14 Sch=sw[1]
set_property -dict { PACKAGE_PIN T18   IOSTANDARD LVCMOS33 } [get_ports { in[2] }]; #IO_L6N_T0_D08_VREF_14 Sch=sw[2]
set_property -dict { PACKAGE_PIN N14   IOSTANDARD LVCMOS33 } [get_ports { in[3] }]; #IO_L13N_T2_MRCC_14 Sch=sw[3]
set_property -dict { PACKAGE_PIN P14   IOSTANDARD LVCMOS33 } [get_ports { in[4] }]; #IO_L12N_T1_MRCC_14 Sch=sw[4]
set_property -dict { PACKAGE_PIN P18   IOSTANDARD LVCMOS33 } [get_ports { valid }]; #IO_L7N_T1_D10_14 Sch=sw[5]
set_property -dict { PACKAGE_PIN U12   IOSTANDARD LVCMOS33 } [get_ports { run }]; #IO_L17N_T2_A13_D29_14 Sch=sw[6]
set_property -dict { PACKAGE_PIN U11   IOSTANDARD LVCMOS33 } [get_ports { rst }]; #IO_L5N_T0_D07_14 Sch=sw[7]

## FPGAOL2 HEXPLAY

set_property -dict { PACKAGE_PIN T10   IOSTANDARD LVCMOS33 } [get_ports { seg[0] }]; #IO_L9N_T1_DQS_AD3N_15 Sch=xa_n[1]
set_property -dict { PACKAGE_PIN T9    IOSTANDARD LVCMOS33 } [get_ports { seg[1] }]; #IO_L9P_T1_DQS_AD3P_15 Sch=xa_p[1]
set_property -dict { PACKAGE_PIN U13   IOSTANDARD LVCMOS33 } [get_ports { seg[2] }]; #IO_L8N_T1_AD10N_15 Sch=xa_n[2]
set_property -dict { PACKAGE_PIN T13   IOSTANDARD LVCMOS33 } [get_ports { seg[3] }]; #IO_L8P_T1_AD10P_15 Sch=xa_p[2]
set_property -dict { PACKAGE_PIN V14   IOSTANDARD LVCMOS33 } [get_ports { an[0] }]; #IO_L7N_T1_AD2N_15 Sch=xa_n[3]
set_property -dict { PACKAGE_PIN U14   IOSTANDARD LVCMOS33 } [get_ports { an[1] }]; #IO_L7P_T1_AD2P_15 Sch=xa_p[3]
set_property -dict { PACKAGE_PIN V11   IOSTANDARD LVCMOS33 } [get_ports { an[2] }]; #IO_L10N_T1_AD11N_15 Sch=xa_n[4]

## FPGAOL2 BUTTON & SOFT_CLOCK

set_property -dict { PACKAGE_PIN V12   IOSTANDARD LVCMOS33 } [get_ports { step }]; #IO_L10P_T1_AD11P_15 Sch=xa_p[4]

##USB-RS232 Interface

#set_property -dict { PACKAGE_PIN M17    IOSTANDARD LVCMOS33 } [get_ports { rxd }]; 
#set_property -dict { PACKAGE_PIN M16    IOSTANDARD LVCMOS33 } [get_ports { txd }]; 
#set_property -dict { PACKAGE_PIN D3    IOSTANDARD LVCMOS33 } [get_ports { UART_CTS }]; #IO_L12N_T1_MRCC_35 Sch=uart_cts
#set_property -dict { PACKAGE_PIN E5    IOSTANDARD LVCMOS33 } [get_ports { UART_RTS }]; #IO_L5N_T0_AD13N_35 Sch=uart_rts
