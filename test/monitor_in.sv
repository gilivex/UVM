class monitor_in extends uvm_monitor;
    `uvm_component_utils (monitor_in)

    uvm_analysis_port# (my_transaction) mon_in_ap; // monitor analysis port

    virtual inf vinf;
    int sum_of_trans_in = 0;
    my_transaction my_tran;
    time half_dur = 4350ns;
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
           @(negedge vinf.get_bit)
           #dur *1.5;
             begin
                for(int i=0; i<8; i++)begin
                    my_tran.data_in[i] = vinf.get_bit;
                    #dur;
                end
                if(vinf.get_bit !=1)
                `uvm_error("STOP bit ERROR")
                else begin
                mon_in_ap.write(my_tran);
                sum_of_trans_in++;
                end
            end
        end
    endtask
endclass