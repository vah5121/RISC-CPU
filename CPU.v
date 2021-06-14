`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/10/2020 01:07:03 PM
// Design Name: 
// Module Name: CPU
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

//module wrapper(clk_x, WB_mux);

//    input wire clk_x;
//    wire [8:0] PC_in_x;
//    wire [8:0] PC_out_x;
//    wire [31:0] IM_out_x;
//    wire [31:0] IF_ID_out_x;
//    wire wreg_x;
//    wire mem2reg_x;
//    wire wmem_x;
//    wire [3:0] aluc_x;
//    wire aluimm_x;
//    wire regrt_x;
//    wire [4:0] rd_or_rt_x;
//    wire [31:0] rs_x;
//    wire [31:0] rt_x;
//    wire [31:0] extender_x;
//    wire wreg_EX;
//    wire mem2reg_EX;
//    wire wmem_EX;
//    wire [3:0] aluc_EX;
//    wire aluimm_EX;
//    wire [4:0] rd_or_rt_EX;
//    wire [31:0] rs_EX;
//    wire [31:0] rt_EX;
//    wire [31:0] extender_EX;
//    wire [31:0] Sign_or_RT_out;
//    wire [31:0] ALU_out;
//    wire wreg_ExMem;
//    wire m2reg_ExMem;
//    wire wmem_ExMem;
//    wire [4:0] rd_rt_ExMem;
//    wire [31:0] ALU_ExMem;
//    wire [31:0] rt_ExMem;
//    wire [31:0] MemFile_out;
//    wire wreg_MemW;
//    wire m2reg_MemW;
//    wire [4:0] rd_rt_MemW;
//    wire [31:0] ALU_MemW;
//    wire [31:0] MemFile_MemW;
//    output wire [31:0] WB_mux;
//    wire [1:0] fwdb;
//    wire [1:0] fwda;
//    wire [31:0] forwardA_out;
//    wire [31:0] forwardB_out;
    
//    PC PC_x(PC_in_x, PC_out_x, clk_x);
//    Adder Adder_x(PC_out_x, PC_in_x);
//    Instruction_Memory Instruction_Memory_x(PC_out_x, IM_out_x);
//    IF_ID IF_ID_x(IM_out_x, IF_ID_out_x, clk_x);
//    ControlUnit ControlUnit_x(IF_ID_out_x, wreg_x, mem2reg_x, wmem_x, aluc_x, aluimm_x, regrt_x, rd_rt_ExMem, m2reg_ExMem, wreg_ExMem, rd_or_rt_EX, mem2reg_EX, wreg_EX, fwdb, fwda);
//    rd_rt_mux rd_rt_mux_x(regrt_x,IF_ID_out_x,rd_or_rt_x);
//    //RegFile RegFile_x(IF_ID_out_x, rs_x, rt_x);
//    RegFile RegFile_x(clk_x,IF_ID_out_x, wreg_MemW, rd_rt_MemW, WB_mux, rs_x, rt_x);
//    forwardA forwardA_x(fwda, rs_x, ALU_out, ALU_ExMem, MemFile_out, forwardA_out);
//    forwardB forwardB_x(fwdb, rt_x, ALU_out, ALU_ExMem, MemFile_out, forwardB_out);
    
//    Extender Extender_x(IF_ID_out_x, extender_x);
//    ID_EXE ID_EXE_x(clk_x, wreg_x, mem2reg_x, wmem_x, aluc_x, aluimm_x, rd_or_rt_x, forwardA_out, forwardB_out, extender_x, wreg_EX, mem2reg_EX, wmem_EX, aluc_EX, aluimm_EX, rd_or_rt_EX, rs_EX, rt_EX, extender_EX);
    
//    Sign_or_RT Sign_or_RT_x(aluimm_EX, extender_EX, rt_EX, Sign_or_RT_out);
//    ALU ALU_x(aluc_EX, rs_EX, Sign_or_RT_out, ALU_out);
//    EXE_MEM EXE_MEM_x(clk_x, wreg_EX, mem2reg_EX, wmem_EX, rd_or_rt_EX, ALU_out, rt_EX, wreg_ExMem, m2reg_ExMem, wmem_ExMem, rd_rt_ExMem, ALU_ExMem, rt_ExMem);

//    MEMORY_FILE MEMORY_FILE_x(wmem_ExMem, ALU_ExMem, rt_ExMem, MemFile_out);
    
//    MEM_WB MEM_WB_x(clk_x, wreg_ExMem, m2reg_ExMem, rd_rt_ExMem, ALU_ExMem, MemFile_out, wreg_MemW, m2reg_MemW, rd_rt_MemW, ALU_MemW, MemFile_MemW);
//    Mux_ALU_MEM Mux_ALU_MEM_x(ALU_MemW, MemFile_MemW, m2reg_MemW, WB_mux); 

//endmodule

//------------------------------------------------------------------------------------------------------------------------------------------------

module PC(PC_in,PC_out,clk); 
    input clk;
    input [8:0] PC_in;   // input of the PC
    output reg [8:0] PC_out; // output of PC
//    initial begin
//        PC_out = 100;
//    end
    always @(posedge clk) begin
        PC_out <= PC_in;    // result of the adder operation sets new PC address     
    end
endmodule

//---------------------------------------------------------------------------------------------------------------------------------------------------

module Adder(adder_in,adder_out);      // just adder that takes in the current PC address and adds four to it. this is then sent the to PC register. triggers whenever
    input [8:0] adder_in;         // input of the adder, the pc address
    output reg [8:0] adder_out;      // output of adder is the adder result
     initial begin
        adder_out = 100;
    end
    always @(adder_in) begin
        adder_out <= adder_out + 4;  // adder reulst is just the output of the PC register + 4  
    end
endmodule
  
//--------------------------------------------------------------------------------------------------------------------------------------------------    
      
module Instruction_Memory(IM_in,IM_out); // input is PC, and that PC points to a address in our instruction memory, the output is whatever stored at that address. trigers whenever PC is incremented
    reg [31:0] IM [0:511];    // instruction memory
    input [8:0] IM_in;  // input to IM, it's the PC output
    output reg [31:0] IM_out; // output of the IM
    initial begin
       IM[100] <= 32'h00221820; 
       IM[104] <= 32'h01232022;
       IM[108] <= 32'h00692825;
       IM[112] <= 32'h00693026;
       IM[116] <= 32'h00693824;
       IM[120] <= 32'h8C040004;
       IM[124] <= 32'hAC030004;
    end
    always @(IM_in) begin
        IM_out <= IM[IM_in]; //whenever PC output changes we fetch new instruction at PC address in the IM and set it to the IM out.   
    end    
endmodule

//----------------------------------------------------------------------------------------------------------------------------------------------------

module IF_ID(IF_ID_in,IF_ID_out,clk); //input is output of instruction memory, outputs the input. triggers at posedge clock
    input clk;
    input [31:0] IF_ID_in;    // input is the output of the data memory,IM_out
    output reg [31:0] IF_ID_out; // output
    
    always @(posedge clk) begin
          IF_ID_out <= IF_ID_in;
    end    
endmodule

//----------------------------------------------------------------------------------------------------------------------------------------------------

module ControlUnit(CU_in,wreg,mem2reg,wmem,aluc,aluimm,regrt, mrn, mm2reg, mwreg, ern, em2reg, ewreg, fwdb, fwda);
    input [31:0] CU_in; //32 bit instruction, IF_ID_out
    input [4:0] mrn;
    input mm2reg;
    input mwreg;
    input [4:0] ern;
    input em2reg;
    input ewreg;
    output reg [1:0] fwdb;
    output reg [1:0] fwda;
    
    output reg wreg;
    output reg mem2reg;
    output reg wmem;
    output reg [3:0] aluc;
    output reg aluimm;
    output reg regrt;
    always @(*) begin
        if (CU_in[31:26] == 6'b100011) begin //lw op
            wreg <= 1;
            mem2reg <= 1;
            wmem <= 0;
            aluc <= 2;
            aluimm <= 1;
            regrt <= 1;
        end  
        else if (CU_in[31:26] == 6'b101011) begin //sw op
            wreg <= 0;
            mem2reg <= 1; // dont care
            wmem <= 1;
            aluc <= 2;
            aluimm <= 1;
            regrt <= 1; //dont care
        end  
        else if (CU_in[31:26] == 6'b000000) begin //R-Format ---> look at function bits
            case(CU_in[5:0])
                6'b100000 : begin   // add
                             wreg <= 1;
                             mem2reg <= 0;
                             wmem <= 0;
                             aluc <= 2;
                             aluimm <= 0;
                             regrt <= 0;
                             end
                6'b100010 : begin   // subtract
                             wreg <= 1;
                             mem2reg <= 0;
                             wmem <= 0;
                             aluc <= 6;
                             aluimm <= 0;
                             regrt <= 0;
                             end 
                 6'b100101 : begin   // or
                             wreg <= 1;
                             mem2reg <= 0;
                             wmem <= 0;
                             aluc <= 1;
                             aluimm <= 0;
                             regrt <= 0;
                             end
                 6'b100110 : begin   // xor
                             wreg <= 1;
                             mem2reg <= 0;
                             wmem <= 0;
                             aluc <= 7;
                             aluimm <= 0;
                             regrt <= 0;
                             end  
                 6'b100100 : begin   // and
                             wreg <= 1;
                             mem2reg <= 0;
                             wmem <= 0;
                             aluc <= 0;
                             aluimm <= 0;
                             regrt <= 0;
                             end                          
                 default :   begin   // default all zero
                              wreg <= 0;
                              mem2reg <= 0;
                              wmem <= 0;
                              aluc <= 0;
                              aluimm <= 0;
                              regrt <= 0;
                              end  
            endcase   
        end  
        if(ern == CU_in [25:21] & ewreg == 1) begin // 01 - forward a
            fwda = 1;
        end
        else if (mrn == CU_in [25:21] & mwreg == 1 & mm2reg == 0) begin // 10 - forward a
            fwda = 2;
        end
        else if (mrn == CU_in [25:21] & mwreg == 1 & mm2reg == 1) begin // 11 - forward a
            fwda = 3;
        end
        else begin
            fwda = 0;
        end
        
        if(ern == CU_in [20:16] & ewreg == 1) begin // 01 - forward b
            fwdb = 1;
        end
        else if (mrn == CU_in [20:16] & mwreg == 1 & mm2reg == 0) begin // 10 - forward b
            fwdb = 2;
        end
        else if (mrn == CU_in [20:16] & mwreg == 1 & mm2reg == 1) begin // 11 - forward b
            fwdb = 3;
        end
        else begin
            fwdb = 0;
        end
    end
endmodule

//--------------------------------------------------------------------------------------------------------------------------------------------------------------

module rd_rt_mux(regrt,rd_or_rt_in,rd_or_rt);
    input regrt;                             // decides whether rd or rt is chosen
    input [31:0] rd_or_rt_in;                  // input, IF_ID_out
    output reg [4:0] rd_or_rt;
    always @(*) begin
        if(regrt) begin
            rd_or_rt <= rd_or_rt_in[20:16]; //rt
        end
        else begin
            rd_or_rt <= rd_or_rt_in[15:11]; //rd
        end
    end
endmodule

//---------------------------------------------------------------------------------------------------------------------------------------------------------------

module RegFile(clk, RegFile_in, wreg, write, data, rs, rt);
    integer i;
    reg [31:0] RegFile [0:31];         // holds 32 registers that are 32 bits,
    input clk;
    input [31:0] RegFile_in;      // input, contains rs and rt, IF_ID_out
    input wreg;
    input [4:0] write;
    input [31:0] data;
    output reg [31:0] rs;
    output reg [31:0] rt;
    initial begin
        RegFile[0] <= 32'h00000000;
        RegFile[1] <= 32'hA00000AA;
        RegFile[2] <= 32'h10000011;
        RegFile[3] <= 32'h20000022;
        RegFile[4] <= 32'h30000033;
        RegFile[5] <= 32'h40000044;
        RegFile[6] <= 32'h50000055;
        RegFile[7] <= 32'h60000066;
        RegFile[8] <= 32'h70000077;
        RegFile[9] <= 32'h80000088;
        RegFile[10] <= 32'h90000099;
        for (i=11; i<32; i = i + 1) begin // sets all registers to zero at the begining of the loop
            RegFile[i] <= 0;
        end
    end
    always @(*) begin
        if (wreg) begin
            RegFile[write] <= data;
        end
    end
    always @(negedge clk) begin
            rs <= RegFile [RegFile_in [25:21]]; //### RegFile content contained at the address determined by the IF/ID output. bit 16-20 always contains rt regardless of format and bit 21-25 always contains rs
            rt <= RegFile [RegFile_in [20:16]]; // same theory as above
    end
endmodule

//module RegFile(RegFile_in,rs,rt);
//    integer i;
//    reg [31:0] RegFile [0:31];         // holds 32 registers that are 32 bits,
//    input [31:0] RegFile_in;      // input, contains rs and rt, IF_ID_out
//    output reg [31:0] rs;
//    output reg [31:0] rt;
//    initial begin
//        for (i=0; i<32; i = i + 1) begin // sets all registers to zero at the begining of the loop
//            RegFile[i] <= 0;
//        end
//    end
//    always @(RegFile_in) begin
//            rs = RegFile [RegFile_in [25:21]]; //### RegFile content contained at the address determined by the IF/ID output. bit 16-20 always contains rt regardless of format and bit 21-25 always contains rs
//            rt = RegFile [RegFile_in [20:16]]; // same theory as above
//    end
//endmodule

//-----------------------------------------------------------------------------------------------------------------------------------------------------------

module forwardA(fwda, rs, ealu, malu, mfile, forwardA);
    input [1:0] fwda;
    input [31:0] rs;
    input [31:0] ealu;
    input [31:0] malu;
    input [31:0] mfile;
    output reg [31:0] forwardA;
    always @(*) begin
        case(fwda)
                0 : begin 
                     forwardA = rs;
                     end
                1 : begin 
                     forwardA = ealu;
                     end
                2 : begin 
                     forwardA = malu;
                     end
                3 : begin 
                     forwardA = mfile;
                     end
                default : begin
                            forwardA = rs;
                            end
        endcase
    end
endmodule

//--------------------------------------------------------------------------------------------------------------------------------------------------------------

module forwardB(fwdb, rt, ealu, malu, mfile, forwardB);
    input [1:0] fwdb;
    input [31:0] rt;
    input [31:0] ealu;
    input [31:0] malu;
    input [31:0] mfile;
    output reg [31:0] forwardB;
    always @(*) begin
        case(fwdb)
                0 : begin 
                     forwardB = rt;
                     end
                1 : begin 
                     forwardB = ealu;
                     end
                2 : begin 
                     forwardB = malu;
                     end
                3 : begin 
                     forwardB = mfile;
                     end
                default : begin
                            forwardB = rt;
                            end
        endcase
    end
endmodule

//--------------------------------------------------------------------------------------------------------------------------------------------------------------

module Extender(extender_in, extender);
    input [31:0] extender_in;                  // input of extender
    output reg [31:0] extender;
    always @(extender_in) begin
          extender <= {16'h0000,extender_in[15:0]}; 
    end    
endmodule

//------------------------------------------------------------------------------------------------------------------------------------------------------------------

module ID_EXE(clk, wreg_in, mem2reg_in, wmem_in, aluc_in, aluimm_in, rd_rt_in, read_rs_in , read_rt_in, extender_in2, wreg, mem2reg, wmem, aluc, aluimm, rd_rt, read_rs, read_rt, extender2);

    input clk;
    input wreg_in;
    input mem2reg_in;
    input wmem_in;
    input [3:0] aluc_in;
    input aluimm_in;
    input [4:0] rd_rt_in;
    input [31:0] read_rs_in;
    input [31:0] read_rt_in;
    input [31:0] extender_in2;
    
    output reg wreg;
    output reg mem2reg;
    output reg wmem;
    output reg [3:0] aluc;
    output reg aluimm;
    output reg [4:0] rd_rt;
    output reg [31:0] read_rs;
    output reg [31:0] read_rt;
    output reg [31:0] extender2; 
    
    always @(posedge clk) begin
        wreg <= wreg_in;
        mem2reg <= mem2reg_in;
        wmem <= wmem_in;
        aluc <= aluc_in;
        aluimm <= aluimm_in;
        rd_rt <= rd_rt_in;
        read_rs <= read_rs_in;
        read_rt <= read_rt_in;
        extender2 <= extender_in2;
    end
endmodule

//-----------------------------------------------------------------------------------------------------------------------------------------------------------

module Sign_or_RT(ealuimm,sign,RT,Sign_or_RT_out);
    input ealuimm;
    input [31:0] sign; //output of the sign extender
    input [31:0] RT;   // rt value read from the register file
    output reg [31:0] Sign_or_RT_out; 
    always @(*) begin
          if (ealuimm) begin // aluimm = 1 then output equal to sign extension
            Sign_or_RT_out <= sign;
          end
          else begin
            Sign_or_RT_out <= RT;
          end
    end 
endmodule

//----------------------------------------------------------------------------------------------------------------------------------------------------------

module ALU(ealuc,RS, Sign_RT, ALU_out);
    input [3:0] ealuc;       // 2 bit input of 
    input [31:0] RS;         // input 1 of ALU, it's the value RS read from the register file
    input [31:0] Sign_RT;    // input 2 of ALU, it's either the ouput of the sign extender or the value of RT read from the register
    output reg [31:0] ALU_out;
    always@(*) begin
        if (ealuc == 2) begin //if aluc = 0, then we have a lw meaning we have to use the add operand
            ALU_out <= RS + Sign_RT; // add
        end
        else if (ealuc == 6) begin
            ALU_out <= RS - Sign_RT; // subtract
        end
        else if (ealuc == 1) begin
            ALU_out <= RS | Sign_RT; // or
        end
        else if (ealuc == 7) begin
            ALU_out <= RS ^ Sign_RT; // xor
        end
        else begin
            ALU_out <= RS & Sign_RT; // and
        end
    end
endmodule

//------------------------------------------------------------------------------------------------------------------------------------------------------

module EXE_MEM(clk,wreg_in,m2reg_in,wmem_in,rd_rt_in,ALU_in,rt_in,wreg,m2reg,wmem,rd_rt,ALU,rt);
    input clk;
    input wreg_in;
    input m2reg_in;
    input wmem_in;
    input [4:0] rd_rt_in;
    input [31:0] ALU_in;
    input [31:0] rt_in;
    output reg wreg;
    output reg m2reg;
    output reg wmem;
    output reg [4:0] rd_rt;
    output reg [31:0] ALU;
    output reg [31:0] rt;
    always@(posedge clk)begin
        wreg <= wreg_in;
        m2reg <= m2reg_in;
        wmem <= wmem_in;
        rd_rt <= rd_rt_in;
        ALU <= ALU_in;
        rt <= rt_in;
    end
    
endmodule

//-------------------------------------------------------------------------------------------------------------------------------------------------------------

module MEMORY_FILE(wmem, address, write_data, MemFile_out);
    reg [31:0] MemFile [0:31];
    input wmem;
    input [31:0] address;
    input [31:0] write_data;
    output reg [31:0] MemFile_out;
    initial begin
       MemFile[0] <= 32'hA00000AA; 
       MemFile[4] <= 32'h10000011;
       MemFile[8] <= 32'h20000022; 
       MemFile[12] <= 32'h30000033;
       MemFile[16] <= 32'h40000044; 
       MemFile[20] <= 32'h50000055;
       MemFile[24] <= 32'h60000066; 
       MemFile[28] <= 32'h70000077;
       MemFile[32] <= 32'h80000088; 
       MemFile[36] <= 32'h90000099;
    end
    always@(*)begin
        if(wmem == 0)begin //if wmem = 0 then we have a lw, if wmem = 1 we have a sw
            MemFile_out <= MemFile[address];
        end
        if(wmem == 1)begin
            MemFile[address] = write_data;
        end
    end
endmodule

//---------------------------------------------------------------------------------------------------------------------------------------------------------

module MEM_WB(clk,wreg_in,m2reg_in,rd_rt_in,ALU_in,MemFile_in,wreg,mem2reg,rd_rt,ALU,MemFile);
    input clk;
    input wreg_in;
    input m2reg_in;
    input [4:0] rd_rt_in;
    input [31:0] ALU_in;
    input [31:0] MemFile_in;
    output reg wreg;
    output reg mem2reg;
    output reg [4:0] rd_rt;
    output reg [31:0] ALU;
    output reg [31:0] MemFile;
    always@(posedge clk)begin
        wreg = wreg_in;
        mem2reg = m2reg_in;
        rd_rt = rd_rt_in;
        ALU = ALU_in;
        MemFile = MemFile_in;
    end
endmodule

//--------------------------------------------------------------------------------------------------------------------------------------------------------

module Mux_ALU_MEM(ALU, MemFile, m2reg, MuxOut);
    input [31:0 ]ALU;
    input [31:0] MemFile;
    input m2reg;
    output reg [31:0] MuxOut;
    always@(*)begin
        if (m2reg) begin
            MuxOut = MemFile;
        end
        else begin
            MuxOut = ALU;
        end
    end   
endmodule

//----------------------------------------------------------------------------------------------------------------------------------------------------------








