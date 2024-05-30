interface inf(input logic clk, rst);

	// declare the signals
	logic [7:0] data_in, data_out;
    bit get_bit;


	// modport for the DUT module - decide ports directions
	modport DUT(
        input data_in,get_bit,clk,rst,
        output data_out
    );
endinterface