class monitor_out extends uvm_monitor;
    `uvm_component_utils (monitor_out)

    uvm_analysis_port# (my_transaction) mon_out_ap; // monitor analysis port

    virtual inf vinf;
    my_transaction my_tran;
    int sum_of_trans_out = 0;
    time dur = 8700ns;
    
    function new (string name, uvm_component parent);
        super.new (name, parent) ;
    endfunction


    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        uvm_config_db#(virtual inf)::get(this,"","inf",vinf);
        mon_out_ap = new("mon_out_ap", this);
    endfunction

    task run_phase(uvm_phase phase);

        my_tran = my_transaction::type_id::create("my_tran", this);
        
        forever begin 
           @(negedge vinf.get_bit)
           #dur *1.5;
             begin
                for(int i=0; i<8; i++)begin
                    my_tran.data_out[i] = vinf.get_bit;
                    #dur;
                end
                if(vinf.get_bit !=1)
                `uvm_error("STOP bit ERROR")
                else begin
                    sum_of_trans_out++;
                    mon_out_ap.write(my_tran);
        end 
    end
        end
    endtask

endclass
