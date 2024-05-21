class monitor_in extends uvm_monitor;
 
`uvm_component_utils(monitor_in)
 
uvm_analysis_port #(transaction) mon_in_port;

  // Declare variables
  virtual inf v_inf;
  transaction tr;
 
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
            tr = transaction::type_id::create("tr",this);        
            
            forever begin
            @(posedge v_inf.clk);
            #2ps;
            if(((v_inf.enable)|(v_inf.load)) && !(v_inf.rst)) 
            begin
            tr.data_in = v_inf.data_in;
            tr.load = v_inf.load;
            tr.enable = v_inf.enable;
            tr.rst = v_inf.rst;

            // `uvm_info("MONITOR_IN", $sformatf("Data_in = %h, Load = %h", tr.data_in, tr.load), UVM_MEDIUM);
            mon_in_port.write(tr);
            end
            end
        endtask
endclass