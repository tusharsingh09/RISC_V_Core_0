`ifndef CPU_V
`define CPU_V

`include "data_mem.v"
`include "instr_mem.v"
`include "controller.v"
`include "alu_controller.v"
`include "datapath.v"

module CPU(
    input wire clk,
    input wire reset
);

wire [15:0] PC;
wire alu_zero, RegSrc, PCSrc, ResultSrc, ALUSrc, RegWrite, Branch;
wire [2:0] ALUControl, ImmSrc;
wire [15:0] DataAddr;
wire [31:0] ReadData, WriteData;
wire [31:0] instruction;

Datapath datapath(
    .clk(clk), .reset(reset),
    .PC(PC),
    .alu_zero(alu_zero),
    .RegSrc(RegSrc),
    .PCSrc(PCSrc),
    .ResultSrc(ResultSrc),
    .ALUControl(ALUControl),
    .ALUSrc(ALUSrc),
    .ImmSrc(ImmSrc),
    .RegWrite(RegWrite),
    .Branch(Branch),
    .ReadData(ReadData),
    .WriteData(WriteData),
    .DataAddr(DataAddr),
    .instr(instruction)
);

Controller controller(
    .opcode(instruction[6:0]),
    .funct7(instruction[31:25]),
    .funct3(instruction[14:12]),
    .alu_zero(alu_zero),
    .RegSrc(RegSrc),
    .PCSrc(PCSrc),
    .ResultSrc(ResultSrc),
    .ALUSrc(ALUSrc),
    .ImmSrc(ImmSrc),
    .RegWrite(RegWrite),
    .MemWrite(MemWrite),
    .Branch(Branch)
);

ALUController alu_controller(
    .opcode(instruction[6:0]),
    .funct3(instruction[14:12]),
    .funct7(instruction[31:25]),
    .alu_control(ALUControl)
);

endmodule

`endif 