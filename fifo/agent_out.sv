class agent_out extends uvm_agent;
   `uvm_component_utils(agent_out)

uvm_analysis_port #(transaction) agent_out_port;
// instance of monitor_out 
monitor_out mon_out;

function new(string name = "agent_out", uvm_component parent);
    super.new(name, parent);
endfunction

function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    mon_out = monitor_out::type_id::create("mon_out",this);
    agent_out_port = new("agent_out_port", this); 
endfunction

function void connect_phase(uvm_phase phase);
   super.connect_phase(phase);
   mon_out.mon_out_port.connect(agent_out_port);

   endfunction

   endclass