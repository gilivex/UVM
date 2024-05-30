`uvm_analysis_imp_decl(_port_in)
`uvm_analysis_imp_decl(_port_out)
`include "ref_model.sv"

class scoreboard extends uvm_scoreboard;

`uvm_component_utils(scoreboard)   

uvm_analysis_imp_port_in#(my_transaction, scoreboard) scb_port_in;
uvm_analysis_imp_port_out#(my_transaction, scoreboard) scb_port_out;

int num_of_trans_in = 0;
int num_of_trans_out = 0;
my_transaction my_fifo[$];
ref_model ref_m;
my_transaction last_trans;


function new(string name = "scoreboard", uvm_component parent);
    super.new(name, parent);
    ref_m = new();
    last_trans = new();
endfunction

function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    scb_port_in = new("scb_port_in", this); 
    scb_port_out = new("scb_port_out", this);
endfunction

function void connect_phase(uvm_phase phase);
endfunction

virtual function void write_port_in(my_transaction trans);

    my_fifo.push_back(trans);
  
endfunction

virtual function void write_port_out(my_transaction trans);
    if(my_fifo.size()!= 0)begin
         last_trans = my_fifo.pop_front();
        compare(trans,last_trans);
    end
    else 
    `uvm_info(get_type_name(), "FIFO IS EMPTY", UVM_LOW)
   
endfunction

virtual function void compare(my_transaction dut_out, my_transaction ref_out);
    if(dut_out.data_out != ref_out.data_out) begin
        `uvm_warning("", "TEST FAILED")
        // tr.print();
        $display("dut Y = ", dut_out.Y);
        $display("ref Y = ", ref_out.Y);
        ref_out.print();
    end
    else
        `uvm_info(get_type_name(), "TEST PASSED", UVM_LOW)
    
endfunction
endclass
