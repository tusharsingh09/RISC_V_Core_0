`ifndef DATA_MEM_H
`define DATA_MEM_H

// addr here is 32 bits from BUS byt only 16 LSB bits will be used
module DataMemory(
    input wire clk,
    input wire reset,
    input wire MemWrite,
    input wire [31:0] addr,
    input wire WriteData,
    output wire [31:0] ReadData
);

// 16-bit address bus
reg [31:0] memory [2**16-1:0];
integer i;
always@(posedge clk or posedge reset) begin
    if(reset) for(i=0;i<2**16-1;i=i+1) memory[i] <= 32'd0;
    else if(MemWrite == 1'b1) memory[addr[15:0]] <= WriteData;
end
assign ReadData = memory[addr[15:0]];
endmodule

`endif
