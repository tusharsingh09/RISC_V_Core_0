`ifndef INSTR_MEM_V
`define INSTR_MEM_V

// PC is 16-bit
module InstructionMemory(
    input wire [15:0] addr,
    output wire [31:0] instruction
);

reg [31:0] memory [2**16-1:0];
assign instruction = memory[addr];

initial $readmemh("../examples/instructions.hex", memory, 0, 2);

endmodule

`endif
