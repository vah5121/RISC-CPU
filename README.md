# RISC-CPU

## Purpose
The goal is to design a 5-stage CPU using MIPS instruction set.

## Design Overview
* The 5-stages of the CPU are: instruction fetch, instruction decode, execute, memory read/write, and write back. 
* The instruction decode stage has a forwarding unit to avoid data hazards
* Writing to the Data Register occurs on rising clock edges and reading the Data Register occurs on falling clock edges 

## Detailed Description

This project utilizes Vivado to implement a 5 stage pipeline CPU in Verilog. The five stages include IF (Instruction Fetch), ID (Instruction Decode), EX(Execution), MEM(Memory), and WB (Write Back).

The first stage, IF, contains an adder that increments a counter called PC and a register called Instruction Memory that holds MIPS instructions. At every positive clock edge, PC is incremented by 4 through the use of an adder. Updating PC triggers the Instruction Memory register. This register holds instructions that tell subsequent stages what to do. During every clock cycle, the Instruction Memory outputs an instruction at the address PC. All instructions are then passed to the ID stage.

The ID stage includes a control unit, a Data Register, and forwarding hardware. At every positive clock edge, the control unit passes read and write signals, controls multiplexers, and tells the ALU found in the EX stage what operation to conduct. The Data Register holds MIPS registers and their values. During every rising clock edge, the Data Register outputs register values. The forwarding hardware detects whether we need to forward register values or pass the recently read register values.  Register data, read and write signals, and ALU control signals are sent to the EX stage during every cycle. 

The EX stage consists of an ALU. Depending on the instruction, the ALU will add, subtract, or complete a boolean operation. There is a signal that comes from the ID stage that tells the ALU what operation to complete. The output of the ALU is fed to the next stage. 

The next stage, DM, consists of a Data Memory register and is used when there is a load or store word instruction. For load words, the write signal is asserted. Then data is read at the address calculated by the ALU. For store words, the write signal is deserted. Then, data is written at the address calculated by the ALU. 

The last stage, WB, consists of the same Data Register used in the ID stage. The purpose of this stage is to write data into the Data Register on falling clock edges. If the instruction is a load word, the data read from the Data Memory is written into the Data Register. For R-format instructions, the output of the ALU is written back into the Data Register. 
