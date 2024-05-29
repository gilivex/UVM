class monitor_in extends uvm_monitor;
  `uvm_component_utils(monitor_in)
  uvm_analysis_port#(my_transaction) mon_in_ap;

  virtual inf vinf;
int sum_of_trans_in=0;

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        uvm_config_db#(virtual inf)::get(this, "", "inf", vinf);
        mon_in_ap = new("mon_in_ap", this);
    endfunction

task run_phase(uvm_phase phase);

my_transaction tr;
tr = new();

forever begin
    
@(vinf.A or vinf.B or vinf.mode)begin
    tr.A = vinf.A;
    tr.B = vinf.B;
    tr.mode = vinf.mode;
    mon_in_ap.write(tr);
    sum_of_trans_in++;
end
end

endtask
endclass
