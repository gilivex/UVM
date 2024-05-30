// driver class to push values to the signals of the interface
class my_driver extends uvm_driver#(my_transaction);

	`uvm_component_utils(my_driver)
	
	virtual inf vinf;
     time dur = 8700ns;
	// constructor
	function new(string name, uvm_component parent);
		super.new(name, parent);
	endfunction
	
	// build phase
	function void build_phase(uvm_phase phase);
		if (!uvm_config_db#(virtual inf)::get(this, "", "inf", vinf))
			`uvm_error("", "uvm_config_db :: get failed")
	endfunction
	
	// run phase
	task run_phase(uvm_phase phase);
		my_transaction trans = new();
		forever begin
			seq_item_port.get_next_item(trans);
            vinf.get_bit <= 0;
            #dur;
            for(int i=0; i<8; i++)begin
                   vinf.get_bit <= trans.data_in[i];
                   #dur;
                end
            vinf.get_bit = 1;
            #dur;
			seq_item_port.item_done();
            end
	endtask

endclass