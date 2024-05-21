class agent_in extends uvm_agent;
`uvm_component_utils(agent_in)

uvm_analysis_port #(transaction) agent_in_port;
// instance of sequencer and driver
// and monitor_in

sequencer seqr;
driver drv;
monitor_in mon_in;


function new(string name = "agent_in", uvm_component parent);
    super.new(name, parent);
endfunction

function void build_phase(uvm_phase phase);
    super.build_phase(phase);
     seqr = sequencer::type_id::create("seqr",this);
     drv = driver::type_id::create("drv",this);
     mon_in = monitor_in::type_id::create("mon_in",this);
     agent_in_port = new("agent_in_port", this);   
endfunction

function void connect_phase(uvm_phase phase);
drv.seq_item_port.connect(seqr.seq_item_export);
mon_in.mon_in_port.connect(agent_in_port);
endfunction

endclass
