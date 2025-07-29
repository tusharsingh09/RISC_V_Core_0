`ifndef PC_V
`define PC_V

// 16-bit Program Counter
module ProgramCounter(
    input wire clk,
    input wire reset,
    input wire [15:0] pc_next,
    output reg [15:0] pc
);
always@(posedge clk or posedge reset) begin
   if(reset) pc <= 15'd0;
   else pc <= pc_next;
end
endmodule

`endif