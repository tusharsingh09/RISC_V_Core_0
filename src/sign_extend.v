`ifndef SIGN_EXT_V
`define SIGN_EXT_V

// Sign extension for jump instruction is ignored as of now

module SignExtend(
    input wire [31:7] instruction,
    input wire [2:0] ImmSrc,
    output wire [31:0] out
);

reg [31:0] out_t;
always@(*) begin
    out_t = 32'd0;
    case(ImmSrc)
        3'b000: // I-type
            out_t = { {20{instruction[31]}}, instruction[31:20] }; // 12 bits encoded
        3'b001: // S-type
            out_t = { {20{instruction[31]}}, instruction[31:25], instruction[4:0] };
        3'b010: // B-type, 12 bit encoded 1-12, 0th aways = 0
            out_t = { {19{instruction[31]}}, instruction[31], instruction[30:25], instruction[11:8], instruction[7], 1'b0 };
        3'b011: // U-type
            out_t = { instruction[31:12], 12'b0 };
        // 3'b100: // J-type
    endcase
end

assign out = out_t;
endmodule

`endif
