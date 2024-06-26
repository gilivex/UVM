class monitor_out_res extends uvm_monitor;
    `uvm_component_utils (monitor_out_res)

    uvm_analysis_port# (my_transaction) mon_out_res_ap; // monitor analysis port

    virtual inf vinf;
    my_transaction my_tran;
    bit next_is_valid = 0;
    int sum_of_trans_out1 = 0;

    function new (string name, uvm_component parent);
        super.new (name, parent) ;
    endfunction


    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        uvm_config_db#(virtual inf)::get(this,"","inf",vinf);
        mon_out_res_ap = new("mon_out_res_ap", this);
    endfunction

    task run_phase(uvm_phase phase);

        my_transaction tr = new();
        // next_is_valid = 0;

           forever begin
            @(vinf.res_out or vinf.reset)
            
            tr.res_out = vinf.res_out;
            mon_out_res_ap.write(tr);
            sum_of_trans_out1++;
        end
    



           
            // forever begin
                // fork the process to wait for the enable signal
                // @(posedge vinf.clk);
                // fork
                //     // wait for the enable signal
                //     begin
                //         #2ps;//wait for 3ns to make sure the signal is stable
                //         if(vinf.enable == 1 || vinf.reset == 1) begin // 
                //             next_is_valid = 1;
                //         end
                //         else begin
                //             next_is_valid = 0;
                //         end
                //     end
               
                //     begin
                //         if(next_is_valid) begin
                //             my_tran.rd_data = vinf.rd_data;
                //             my_tran.res_out = vinf.res_out;
                //             //send the transaction to the analysis port
                //             sum_of_trans_out++;
                //             mon_out_ap.write(my_tran);
                //         end
                //     end 
                // join;
            // end 
        
    endtask

endclass
