# 声明
本人不鼓励, 不建议任何形式的代码抄袭, 实验请自己独立完成, 本仓库仅提供参考

如果你认为本项目对你有帮助, 可以点击右上方的 star.

# USTC 2022 COD Lab
个人 USTC 2022 春季学期计算机组成原理实验代码仓库, 包括 Vivado 项目以及实验报告.

|  Lab  |                                 Description                                  |
| :---: | :--------------------------------------------------------------------------: |
| Lab 1 |                                  ALU & FLS                                   |
| Lab 2 |                       FIFO & Memory IP Core & RegFile                        |
| Lab 3 |                         RISC-V Assembly and Datapath                         |
| Lab 4 |           Single Cycle RISC-V CPU Design (10-Instruction Support)            |
| Lab 5 |              Pipeline RISC-V CPU Design (6-Instruction Support)              |
| Lab 6 | Pipeline RISC-V CPU Design (37-Instruction Support, 2-bit Branch Prediction) |

# 综合实验 Lab 6
实现了 RV32I 中除 FENCE, CSR 与环境调用和断点指令外的全部 37 条指令支持, 实现 2-bit 分支预测. 数据通路如下
![datapath](assets/dp_cpu.svg)

> 短期内不会考虑走体系结构方向惹 (bushi)