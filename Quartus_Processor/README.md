# 5-Stage Pipelined RISC-V Processor
## Abstract

This project presents the successful implementation of a 5-staged pipelined RISC-V processor at the RTL, strictly adhering to the RV32I standard. The processor design incorporates key stages for instruction fetch, decode, execute, memory access, and write-back, optimizing performance and enabling concurrent instruction processing. Leveraging the simplicity and efficiency of the RISC-V RV32I instruction set, the project ensures compatibility with industry standards. The resulting RTL model demonstrates a functional pipelined processor, contributing to advancements in computer architecture through its emphasis on pipeline efficiency and adherence to established specifications.

## Top Architecture

![Microarchitecture (1)](https://github.com/meeeeet/5-Stage-Pipelined-RISC-V-Processor/assets/76646671/84371dc3-ebae-4851-8779-113b2568dc90)

## Supported Instructions
| LW   | SLLI | XOR |
|------|------|-----|
| SW   | SRLI | SRL |
| ADDI | SRAI | SRA |
| SLTI | ADD  | OR  |
| XORI | SUB  | AND |
| ORI  | SLL  | BEQ |
| ANDI | SLT  | JAL |

