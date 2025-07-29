`ifndef REG_FILE_V
`define REG_FILE_V

module RegisterFile(
    input wire clk,
    input wire reset,
    input wire RegWrite,
    input wire [4:0] addr1,
    input wire [4:0] addr2,
    input wire [4:0] addr3,
    output wire [31:0] read1,
    output wire [31:0] read2,
    output wire [31:0] data
);

reg [31:0] registers [31:0];
integer i;
always@(posedge clk or posedge reset) begin
    if(reset) for(i=0;i<32;i=i+1) registers[i] <= 32'd0;
    else if(RegWrite) registers[addr3] <= data;
    $writememh("../bin/registers.hex", registers);
end
assign read1 = registers[addr1];
assign read2 = registers[addr2];

endmodule

`endif