class monitor_in extends uvm_monitor;
    `uvm_component_utils (monitor_in)

    uvm_analysis_port# (my_transaction) mon_in_ap; // monitor analysis port

    virtual inf vinf;
    int sum_of_trans_in = 0;
    my_transaction my_tran;

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        uvm_config_db#(virtual inf)::get(this,"","inf",vinf);
        mon_in_ap = new("mon_in_ap", this);
    endfunction

    task run_phase(uvm_phase phase);
        my_tran = my_transaction::type_id::create("my_tran", this);

        forever begin 
            @(posedge vinf.clk)
             begin 
               my_tran = vinf.data_in;
                
                mon_in_ap.write(my_tran);
                sum_of_trans_in++;
            end
        end
    endtask
endclass