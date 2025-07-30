`ifndef CONTROLLER_V
`define CONTROLLER_V

module Controller(
    input wire [6:0] opcode,
    input wire [6:0] funct7,
    input wire [2:0] funct3,
    input wire alu_zero,
    
    output reg RegSrc,
    output reg PCSrc,
    output reg ResultSrc,
    output reg ALUSrc,
    output reg [2:0] ImmSrc,
    output reg RegWrite,
    output reg MemWrite,
    output reg Branch
);

always@(*) begin
    case(opcode)
    7'b0110011: begin // R-Type
        RegWrite = 1'b1;
        ALUSrc = 1'b0;
        PCSrc = 1'b0;
        MemWrite = 1'b0;
        ResultSrc = 1'b0;
    end
    7'b0010011: begin // I-Type
        ImmSrc = 3'b000; 
        RegWrite = 1'b1;
        ALUSrc = 1'b1;
        MemWrite = 1'b0;
        ResultSrc = 1'b0;
        PCSrc = 1'b0;
    end
    7'b1100011: begin // B-Type
        RegWrite = 1'b0;
        MemWrite = 1'b0;
        ImmSrc = 3'b010;
        ALUSrc = 1'b0;
        // separate beq and bne
        if(funct3 == 3'h0) PCSrc = alu_zero; // beq
        else if(funct3 == 3'h1) PCSrc = ~alu_zero; // bne
        ResultSrc = 1'b0;
    end
    7'b1101111: begin // jal
        RegWrite = 1'b0;
        MemWrite = 1'b0;
        PCSrc = 1'b1;
        ImmSrc = 3'b100;
        ALUSrc = 1'b0;
        ResultSrc = 1'b0;
    end
    endcase
end

endmodule

`endif 