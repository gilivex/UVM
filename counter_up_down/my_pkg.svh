package my_pkg;
	

import uvm_pkg::*;
	`include "uvm_macros.svh"
	`include "transaction.sv"
	`include "my_sequence.sv"	
	`include "sequencer.sv"
	`include "monitor_out.sv"
	`include "monitor_in.sv"
	`include "driver.sv"
	`include "agent_in.sv"
	`include "agent_out.sv"
	`include "scoreboard.sv"
	// `include "adder_config.sv"
	`include "env.sv"
	`include "random_test.sv"
endpackage
