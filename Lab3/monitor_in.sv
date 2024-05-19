class monitor_in extends uvm_monitor; 
    `uvm(uvm_component_utils(monitor_in))

    uvm_analysis_port#(monitor_in) mon_in_ap;

    virtual inf vinf;
    my_transaction my_tran;

    // for coverage

    my_transaction my_tran_cvg;

    //define coverpoints
    covergroup cg;
    a_cp: coverpoint my_tran_cvg.a;
    b_cp: coverpoint my_tran_cvg.b;
// cross just for practice not needed
    cross a_cp, b_cp;

    endgroup

    function new(string name, uvm_component parent);
        super.new(name, parent);
        my_tran_cvg = new(); // for coverage but why it is needed????
        endfunction

        function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        uvm_config_db#(virtual inf)::get(this,"","inf",vinf);
        mon_in_ap = new("mon_in_ap", this);
        endfunction


    task run_phase(uvm_phase phase);
    my_tran = my_transaction::id_type::create("my_tran", this);

    forever begin 
        @(posedge vinf.clk);
        if(vinf.enable) begin 
            my_tran.a = vinf.a;
            my_tran.b = vinf.b;
            // for coverage
            my_tran_cvg = my_tran;
            cg.sample();
            uvm_info(" ", $sformatf("Monitor expected enable=%0d, a=%0d, b=%0d, sum=%d", vinf.enable,vinf.a, vinf.b, vinf.sum), UVM_MEDIUM);
            //send the transaction to the analysis port
            mon_in_ap.write(my_tran);
        end
    end
endtask
    endclass