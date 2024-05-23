class env extends uvm_env;

`uvm_component_utils(env)

//declare the agents and the scoreboard

agent_in age_in;
agent_out age_out;
scoreboard scb;

function new(string name = "env", uvm_component parent);
    super.new(name, parent);
endfunction

function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    age_in = agent_in::type_id::create("age_in", this);
    age_out = agent_out::type_id::create("age_out", this);
    scb = scoreboard::type_id::create("scb", this);
endfunction

function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    age_in.agent_in_port.connect(scb.scb_port_in);
    age_out.agent_out_port.connect(scb.scb_port_out);
endfunction
endclass