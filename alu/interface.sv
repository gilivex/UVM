interface inf(input logic clk, rst);

	// declare the signals
	
	logic [3:0] a;
	logic [3:0] b;
    logic [1:0] mode;

	logic [3:0] out;

	// modport for the DUT module - decide ports directions
	modport DUT(
        input a, b, mode, rst,clk,
        output out);
	
endinterface