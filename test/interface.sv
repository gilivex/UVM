interface inf(input logic clk, rst);

	// declare the signals
	logic [7:0] tx, rx;


	// modport for the DUT module - decide ports directions
	modport DUT(
        input tx,clk,rst,
        output rx
    );
endinterface