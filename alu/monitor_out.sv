class monitor_out extends uvm_monitor;
  `uvm_component_utils(monitor_out)
  uvm_analysis_port#(my_transaction) mon_out_ap;

  virtual inf vinf;
int sum_of_trans_out=0;

  function new(string name, uvm_component parent);
    super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        uvm_config_db#(virtual inf)::get(this, "", "inf", vinf);
        mon_out_ap = new("mon_out_ap", this);
    endfunction

task run_phase(uvm_phase phase);

my_transaction tr;
tr = new();

forever begin
    @(vinf.Y)begin
        tr.Y = vinf.Y;
        mon_out_ap.write(tr);
        sum_of_trans_out++;
    end
end
endtask
endclass