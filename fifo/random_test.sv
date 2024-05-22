class random_test extends uvm_test;

    `uvm_component_utils(random_test)
    
 env my_env;

    // Constructor
    function new (string name = "random_test", uvm_component parent);
        super.new(name, parent);
    endfunction
    
    // Build phase
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        my_env = env::type_id::create("my_env", this);
    endfunction
    
    // Run phase
    task run_phase(uvm_phase phase);
    my_sequence seq;
    phase.raise_objection(this);
    seq = my_sequence::type_id::create("seq");
    if(!seq.randomize())
        `uvm_error("RANDOMIZE_FAILED", "Failed to randomize sequence")
        seq.start(my_env.age_in.seqr);
        #4ns;
      `uvm_info("",$sformatf("num_of_tr_in = %0d, num_of_tr_out = %0d", my_env.scb.num_of_trans_in, my_env.scb.num_of_trans_out), UVM_MEDIUM);
      `uvm_info("", "This is a random test running", UVM_MEDIUM)
		phase.drop_objection(this);
    endtask
    endclass