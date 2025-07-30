`ifndef DATAPATH_V
`define DATAPATH_V

`include "mux.v"
`include "pc.v"
`include "instr_mem.v"
`include "reg_file.v"
`include "sign_extend.v"
`include "alu.v"

module Datapath(
    input wire clk,
    input wire reset,
    output wire [15:0] PC, // goes to instruction memory
    output wire alu_zero,
    // control inputs
    input wire RegSrc,
    input wire PCSrc,
    input wire ResultSrc,
    input wire [2:0] ALUControl,
    input wire ALUSrc,
    input wire [2:0] ImmSrc,
    input wire RegWrite,
    input wire Branch,
    input wire [31:0] ReadData,
    output wire [31:0] WriteData,
    output wire [15:0] DataAddr,
    output wire [31:0] instr
);

wire [15:0] PC_Next;

wire [31:0] instruction;
wire [31:0] alu_src_a, alu_src_b;
wire [31:0] SigmImm;
wire [31:0] alu_result;
wire [31:0] Result; // goes to wd3 (register file writing data)

// wanna use only LSB 16 bits of sigimm since pc in 16 bti
MUX2 #(.size(16)) pc_mux(
    .I0(PC[15:0]+16'd4),
    .I1(PC[15:0]+SigmImm), // sigimm pehls se hi address dega, to direct add krenge
    .s(PCSrc),
    .out(PC_Next)
);

// use PC[15:2] to load instructions from memory
ProgramCounter progr_counter(
    .clk(clk), .reset(reset),
    .pc_next(PC_Next),
    .pc(PC)
);

InstructionMemory instr_mem(
    .addr(PC>>2),
    .instruction(instruction)
);

MUX2 #(.size(32)) result_mux(
    .I0(alu_result),
    .I1(ReadData),
    .s(ResultSrc),
    .out(Result)
);

RegisterFile reg_file(
    .clk(clk), .reset(reset),
    .RegWrite(RegWrite),
    .addr1(instruction[19:15]),
    .addr2(instruction[24:20]),
    .addr3(instruction[11:7]),
    .read1(alu_src_a),
    .read2(WriteData),
    .data(Result)
);

MUX2 #(.size(32)) alu_src_b_mux(
    .I0(WriteData),
    .I1(SigmImm),
    .s(ALUSrc),
    .out(alu_src_b)
);

SignExtend sign_ext(
    .instruction(instruction[31:7]),
    .ImmSrc(ImmSrc),
    .out(SigmImm)
);

ALU main_alu(
    .srcA(alu_src_a),
    .srcB(alu_src_b),
    .alu_zero(alu_zero),
    .alu_result(alu_result),
    .ALUControl(ALUControl)
);

assign DataAddr = alu_result[15:0];
assign instr = instruction;

endmodule

`endif 