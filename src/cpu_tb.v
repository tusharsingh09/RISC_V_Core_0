`timescale 1ns/1ps
`include "cpu.v"

module CPU_tb();

reg clk, reset;

CPU DUT(clk, reset);

initial begin
    $dumpfile("../bin/cpu.vcd");
    $dumpvars(0, DUT);
    clk = 0;
    reset = 1;
    #5 reset = 0;
    #500 $finish;
end

always #2 clk = ~clk;

endmodule