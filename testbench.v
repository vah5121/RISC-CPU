`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/10/2020 01:08:20 PM
// Design Name: 
// Module Name: testbench
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


module testbench();
//   reg clk_x;
//   wire [31:0] WB_mux;
//   wrapper wrapper_tb(clk_x,WB_mux);
   
    reg clk_x;
    wire [8:0] PC_in_x;
    wire [8:0] PC_out_x;
    wire [31:0] IM_out_x;
    wire [31:0] IF_ID_out_x;
    wire wreg_x;
    wire mem2reg_x;
    wire wmem_x;
    wire [3:0] aluc_x;
    wire aluimm_x;
    wire regrt_x;
    wire [4:0] rd_or_rt_x;
    wire [31:0] rs_x;
    wire [31:0] rt_x;
    wire [31:0] extender_x;
    wire wreg_EX;
    wire mem2reg_EX;
    wire wmem_EX;
    wire [3:0] aluc_EX;
    wire aluimm_EX;
    wire [4:0] rd_or_rt_EX;
    wire [31:0] rs_EX;
    wire [31:0] rt_EX;
    wire [31:0] extender_EX;
    wire [31:0] Sign_or_RT_out;
    wire [31:0] ALU_out;
    wire wreg_ExMem;
    wire m2reg_ExMem;
    wire wmem_ExMem;
    wire [4:0] rd_rt_ExMem;
    wire [31:0] ALU_ExMem;
    wire [31:0] rt_ExMem;
    wire [31:0] MemFile_out;
    wire wreg_MemW;
    wire m2reg_MemW;
    wire [4:0] rd_rt_MemW;
    wire [31:0] ALU_MemW;
    wire [31:0] MemFile_MemW;
    wire [31:0] WB_mux;
    wire [1:0] fwdb;
    wire [1:0] fwda;
    wire [31:0] forwardA_out;
    wire [31:0] forwardB_out;
    
    PC PC_x(PC_in_x, PC_out_x, clk_x);
    Adder Adder_x(PC_out_x, PC_in_x);
    Instruction_Memory Instruction_Memory_x(PC_out_x, IM_out_x);
    IF_ID IF_ID_x(IM_out_x, IF_ID_out_x, clk_x);
    ControlUnit ControlUnit_x(IF_ID_out_x, wreg_x, mem2reg_x, wmem_x, aluc_x, aluimm_x, regrt_x, rd_rt_ExMem, m2reg_ExMem, wreg_ExMem, rd_or_rt_EX, mem2reg_EX, wreg_EX, fwdb, fwda);
    rd_rt_mux rd_rt_mux_x(regrt_x,IF_ID_out_x,rd_or_rt_x);
    //RegFile RegFile_x(IF_ID_out_x, rs_x, rt_x);
    RegFile RegFile_x(clk_x,IF_ID_out_x, wreg_MemW, rd_rt_MemW, WB_mux, rs_x, rt_x);
    forwardA forwardA_x(fwda, rs_x, ALU_out, ALU_ExMem, MemFile_out, forwardA_out);
    forwardB forwardB_x(fwdb, rt_x, ALU_out, ALU_ExMem, MemFile_out, forwardB_out);
    
    Extender Extender_x(IF_ID_out_x, extender_x);
    ID_EXE ID_EXE_x(clk_x, wreg_x, mem2reg_x, wmem_x, aluc_x, aluimm_x, rd_or_rt_x, forwardA_out, forwardB_out, extender_x, wreg_EX, mem2reg_EX, wmem_EX, aluc_EX, aluimm_EX, rd_or_rt_EX, rs_EX, rt_EX, extender_EX);
    
    Sign_or_RT Sign_or_RT_x(aluimm_EX, extender_EX, rt_EX, Sign_or_RT_out);
    ALU ALU_x(aluc_EX, rs_EX, Sign_or_RT_out, ALU_out);
    EXE_MEM EXE_MEM_x(clk_x, wreg_EX, mem2reg_EX, wmem_EX, rd_or_rt_EX, ALU_out, rt_EX, wreg_ExMem, m2reg_ExMem, wmem_ExMem, rd_rt_ExMem, ALU_ExMem, rt_ExMem);

    MEMORY_FILE MEMORY_FILE_x(wmem_ExMem, ALU_ExMem, rt_ExMem, MemFile_out);
    
    MEM_WB MEM_WB_x(clk_x, wreg_ExMem, m2reg_ExMem, rd_rt_ExMem, ALU_ExMem, MemFile_out, wreg_MemW, m2reg_MemW, rd_rt_MemW, ALU_MemW, MemFile_MemW);
    Mux_ALU_MEM Mux_ALU_MEM_x(ALU_MemW, MemFile_MemW, m2reg_MemW, WB_mux);
    
    initial begin
        clk_x = 0;
    end
    always begin
        #5;
        clk_x = ~clk_x;
    end  
endmodule
