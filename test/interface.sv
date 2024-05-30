interface inf(input logic clk, rst);

	// declare the signals
	logic [7:0] data_in, data_out;


	// modport for the DUT module - decide ports directions
	modport DUT(
        input data_in,clk,rst,
        output data_out
    );
endinterface