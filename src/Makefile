all: compile run wave

compile:
	iverilog -o ../bin/cpu *.v

run: 
	vvp ../bin/cpu

wave:
	gtkwave ../bin/cpu.vcd