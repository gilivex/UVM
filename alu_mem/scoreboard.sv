`uvm_analysis_imp_decl(_port_in)
`uvm_analysis_imp_decl(_port_out)
`include "ref_modle.sv"
//define enum type for max size of fifo and min size of fifo

class scoreboard extends uvm_scoreboard;

`uvm_component_utils(scoreboard)   

uvm_analysis_imp_port_in#(my_transaction, scoreboard) scb_port_in;
uvm_analysis_imp_port_out#(my_transaction, scoreboard) scb_port_out;

ref_model ref_m;
my_transaction trans_ref;
my_transaction trans_in;
my_transaction trans_out;
int num_of_trans_in = 0;
int num_of_trans_out = 0;
// int fifo_size = 0;
my_transaction my_fifo[$];

function new(string name = "scoreboard", uvm_component parent);
    super.new(name, parent);
    trans_ref = new("trans_ref");
    trans_in = new("trans_in");
    trans_out = new("trans_out");
    ref_m = new();

endfunction

function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    scb_port_in = new("scb_port_in", this); 
    scb_port_out = new("scb_port_out", this);
endfunction

function void connect_phase(uvm_phase phase);
endfunction

virtual function void write_port_in(my_transaction trans);
// trans_in.wr_data = trans.wr_data;
// trans_in.rd_wr = trans.rd_wr;
// trans_in.enable = trans.enable;
// trans_in.addr = trans.addr;
//  
// trans_ref = ref_m.step(trans_in);
trans_ref = ref_m.step(trans);
my_fifo.push_back(trans_ref);
endfunction

virtual function void write_port_out(my_transaction trans);
// if fifo is empty then wait for the data to be ready

trans_out.rd_data = trans.rd_data;
trans_out.res_out = trans.res_out;
  if(my_fifo.size() == 0)
        `uvm_info(get_type_name(), "FIFO is empty", UVM_LOW)
  else
compare(trans_out, my_fifo.pop_front());
endfunction

//compare the output of the DUT with the output of the reference model
virtual function void compare(my_transaction dut_out, my_transaction ref_out);
   
    if(dut_out.res_out != ref_out.res_out) begin
        `uvm_warning("", "TEST FAILED")
    end
    else `uvm_info(get_type_name(), "TEST PASSED", UVM_LOW)

       if(dut_out.is_data_valid == 1)
        if(dut_out.rd_data != ref_out.rd_data)
        `uvm_warning("", "TEST FAILED")
            else
        `uvm_info(get_type_name(), "TEST PASSED", UVM_LOW)
    
    endfunction
endclass
