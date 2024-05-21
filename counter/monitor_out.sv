class monitor_out extends uvm_monitor;

`uvm_component_utils(monitor_out)
    
uvm_analysis_port #(transaction) mon_out_port;

      // Declare variables
      virtual inf v_inf;
      bit is_valid;
      
     // Constructor
     function new (string name = "monitor_out", uvm_component parent);
          super.new(name, parent);
     endfunction

     function void build_phase(uvm_phase phase);
          super.build_phase(phase);
          uvm_config_db #(virtual inf)::get(this, "", "inf", v_inf);
            mon_out_port = new("mon_out_port", this);
     endfunction

        task run_phase(uvm_phase phase);
            transaction tr;
        tr = transaction::type_id::create("tr",this);
           
            forever begin           
                @(posedge v_inf.clk);
                // #2ps;
               if(((v_inf.enable)|(v_inf.load)) && !(v_inf.rst)) 
               is_valid = 1;
               else
                is_valid = 0;
            
            if(is_valid)
               begin
                tr.count = v_inf.count;
                // `uvm_info("MONITOR_OUT", $sformatf("Count = %h", tr.count), UVM_MEDIUM);
                // @(posedge v_inf.clk);
                 mon_out_port.write(tr);
            end
            end
        endtask
endclass