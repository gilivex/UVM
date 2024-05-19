// environment class - create the driver
class my_env extends uvm_env;

	`uvm_component_utils(my_env)
	
	my_agent my_agent_h;
	
	function new(string name, uvm_component parent);
		super.new(name, parent);
	endfunction
	
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		my_agent_h = my_agent::type_id::create("my_agent_h", this);
	endfunction

endclass