`ifndef MUX_V
`define MUX_V

module MUX2 #(parameter size = 32)(
    input wire [size-1:0] I0,
    input wire [size-1:0] I1,
    input wire s,
    output wire [size-1:0] out
);
assign out = s?I1:I0;
endmodule

`endif 
