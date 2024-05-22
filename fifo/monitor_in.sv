class monitor_in extends uvm_monitor;
 
`uvm_component_utils(monitor_in)
 
uvm_analysis_port #(transaction) mon_in_port;

  // Declare variables
  virtual inf vinf;
  transaction trans;
  int sum_of_trans = 0;
 
    // Constructor
    function new (string name = "monitor_in", uvm_component parent);
        super.new(name, parent);
    endfunction

function void build_phase(uvm_phase phase);
    super.build_phase(phase);
       if(!uvm_config_db#(virtual inf)::get(this,"","inf",v_inf))
        `uvm_fatal("MON_ERR", "Monitor needs an interface")
        mon_in_port = new("mon_in_port", this);
endfunction

        task run_phase(uvm_phase phase);
            trans = transaction::type_id::create("tr",this);        
            
            forever begin
            @(posedge v_inf.clk);
            #2ps;
            if((v_inf.write_en)||(v_inf.read_en)||(v_inf.rst)) 
            begin
            trans.write_en = vinf.write_en;
            trans.read_en = vinf.read_en;
            trans.data_in = vinf.data_in;
            trans.rst = vinf.rst;

            mon_in_port.write(trans);
            sum_of_trans++;
            end
            end
        endtask
endclass