`ifndef ALU_CONROLLER_V
`define ALU_CONROLLER_V

module ALUController(
    input wire [6:0] opcode,
    input wire [2:0] funct3,
    input wire [6:0] funct7,
    output reg [2:0] alu_control
);

always@(*) begin
    alu_control = 7'bzzzzzzz;
    // TODO: make ALU independent of opcode, I accidentally did
    if(opcode == 7'b0110011 | opcode == 7'b0010011) begin
        case(funct3)
        3'h0: alu_control = (funct7==7'h20)?(3'b001):(3'b000); // SUB:ADD
        3'h7: alu_control = 3'b010; // AND
        3'h6: alu_control = 3'b011; // OR
        3'h4: alu_control = 3'b100; // XOR
        3'h1: alu_control = 3'b110; // SLL
        3'h5: alu_control = 3'b101; // SRL
        endcase
    end
    else if (opcode == 7'b1100011) begin
        alu_control = (funct3 == 3'h0 || funct3 == 3'h1)?(3'b001):(3'h0);
    end
end

endmodule

`endif