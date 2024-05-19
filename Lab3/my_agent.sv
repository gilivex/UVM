class my_agent extends uvm_agent; 

`uvm_component_utils(my_agent)
// uvm_active_passive_enum is_active = UVM_ACTIVE;

// instance of sequencer and driver

my_sequencer my_sequencer_h;
my_driver my_driver_h;


function new(string name = "my_agent",uvm_component parent);
super.new(name,parent);
endfunction //new()

function void build_phase(uvm_phase phase);
super.build_phase(phase);begin
// if(is_active=UVM_ACTIVE) 
    my_sequencer_h = my_sequencer::type_id::create("my_sequencer_h",this);
    my_driver_h = my_driver::type_id::create("my_driver_h",this);

end
endfunction //build_phase
function void connect_phase(uvm_phase phase);   
// if(is_active == UVM_ACTIVE)
my_driver_h.seq_item_port.connect(my_sequencer_h.seq_item_export);
endfunction //connect_phase


endclass //my_agent extends uvm_agent
