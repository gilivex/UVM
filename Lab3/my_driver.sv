// driver class to push values to the signals of the interface
class my_driver extends uvm_driver #(my_transaction);

	`uvm_component_utils(my_driver)
	
	virtual inf vinf;
	
	// constructor
	function new(string name, uvm_component parent);
		super.new(name, parent);
	endfunction
	
	// build phase
	function void build_phase(uvm_phase phase);
		uvm_config_db#(virtual inf)::get(this, "", "inf", vinf)
			`uvm_error("", "uvm_config_db :: get failed")
	endfunction
	
	// run phase
	task run_phase(uvm_phase phase);
		forever begin
			seq_item_port.get_next_item(req);
			`uvm_info("inf", my_tran.sprint(), UVM_LOW);	
			@(posedge vinf.clk) 
				vinf.enable <= my_tran.enable;
				vinf.a <= my_tran.a;
				vinf.b <= my_tran.b;

			`uvm_info(" ", $sformatf("DUT recived enable=%0d, a=%0d, b=%0d, sum=%d", vinf.enable, vinf.a, vinf.b, vinf.sum), UVM_MEDIUM);
			
			seq_item_port.item_done();
			end
		
	endtask

endclass