class my_agent_res extends uvm_agent;
    `uvm_component_utils(my_agent_res)
    
    uvm_analysis_port#(my_transaction) agnt_ap_res;
    monitor_out_res mon_res_h;
    
    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction
    
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        mon_res_h = monitor_out_res::type_id::create("mon_res_h", this);
        agnt_ap_res = new("agnt_ap_res", this);
    endfunction

    function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    mon_res_h.mon_out_res_ap.connect(agnt_ap_res);
    endfunction

endclass