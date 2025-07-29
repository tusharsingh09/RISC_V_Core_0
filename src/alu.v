`ifndef ALU_V
`define ALU_V

module ALU(
    input wire [31:0] srcA, srcB,
    input wire [2:0] ALUControl,
    output wire alu_zero,
    output reg [31:0] alu_result
);

always@(*) begin
    alu_result = 32'd0;
    case(ALUControl)
    3'b000: alu_result = srcA+srcB;
    3'b001: alu_result = srcA-srcB;
    3'b010: alu_result = srcA&srcB;
    3'b011: alu_result = srcA|srcB;
    3'b100: alu_result = srcA^srcB;
    3'b101: alu_result = srcA>>srcB;
    3'b110: alu_result = srcA<<srcB;
    // 3'b111: Shift Right Arithemetic 
    endcase
end

assign alu_zero = (alu_result == 32'd0);

endmodule

`endif 