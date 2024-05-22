class monitor_out extends uvm_monitor;

`uvm_component_utils(monitor_out)
    
uvm_analysis_port #(transaction) mon_out_port;

      // Declare variables
      virtual inf vinf;
      bit is_valid;
      
     // Constructor
     function new (string name = "monitor_out", uvm_component parent);
          super.new(name, parent);
     endfunction

     function void build_phase(uvm_phase phase);
          super.build_phase(phase);
          uvm_config_db #(virtual inf)::get(this, "", "inf", vinf);
            mon_out_port = new("mon_out_port", this);
     endfunction

        task run_phase(uvm_phase phase);
            transaction trans;
        trans = transaction::type_id::create("tr",this);
           is_valid = 0;
            forever begin           
                @(posedge vinf.clk);
                fork 
                    begin
                      #2ps;
                     if((vinf.write_en)||(vinf.read_en)||(vinf.rst)) 
                      is_valid = 1;
                      else
                    is_valid = 0;
                    end

                    begin
                    if(is_valid)
                    begin
                    trans.data_out = vinf.data_out;
                    trans.empty = vinf.empty;
                    trans.full = vinf.full;
                    mon_out_port.write(trans);
                    end
                    end
                join              
            end
        endtask
endclass