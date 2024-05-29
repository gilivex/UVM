`uvm_analysis_imp_decl(_port_in)
`uvm_analysis_imp_decl(_port_out)
`uvm_analysis_imp_decl(_port_out_res)
`include "ref_model.sv"

class scoreboard extends uvm_scoreboard;

`uvm_component_utils(scoreboard)   

uvm_analysis_imp_port_in#(my_transaction, scoreboard) scb_port_in;
uvm_analysis_imp_port_out#(my_transaction, scoreboard) scb_port_out;
uvm_analysis_imp_port_out_res#(my_transaction, scoreboard) scb_port_out_res;

ref_model ref_m;
my_transaction trans_ref;
my_transaction trans_out;
int num_of_trans_in = 0;
int num_of_trans_out = 0;
my_transaction my_fifo[$];
my_transaction my_fifo_res[$];
my_transaction trans_rd;
my_transaction trans_res;

function new(string name = "scoreboard", uvm_component parent);
    super.new(name, parent);
    trans_ref = new("trans_ref");
    trans_out = new("trans_out");
    ref_m = new();
    trans_rd = new();
    trans_res = new();
endfunction

function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    scb_port_in = new("scb_port_in", this); 
    scb_port_out = new("scb_port_out", this);
    scb_port_out_res = new("scb_port_out_res", this);
endfunction

function void connect_phase(uvm_phase phase);
endfunction

virtual function void write_port_in(my_transaction trans);
trans_ref = ref_m.step(trans);
if(trans_ref.rd_wr == 0)
    my_fifo_res.push_back(trans_ref);
else
my_fifo.push_back(trans_ref);
my_fifo_res.push_back(trans_ref);
endfunction

// write only for rd_data output
virtual function void write_port_out(my_transaction trans);
// if fifo is empty then wait for the data to be ready
   if(my_fifo.size()!= 0)begin
         trans_rd = my_fifo.pop_front();
        compare_rd(trans,trans_rd);
    end
    else 
    `uvm_info(get_type_name(), "FIFO IS EMPTY", UVM_LOW)
endfunction

// write only for res_out output
virtual function void write_port_out_res(my_transaction trans);
// if fifo is empty then wait for the data to be ready
   if(my_fifo_res.size()!= 0)begin
         trans_res = my_fifo_res.pop_front();
        compare_res(trans,trans_res);
    end
    else 
    `uvm_info(get_type_name(), "FIFO IS EMPTY", UVM_LOW)
endfunction

// compare only for the rd_data
function void compare_rd(my_transaction dut_out, my_transaction ref_out);
    `uvm_info(get_type_name(), "COMPARING RD_DATA", UVM_LOW)
    if(dut_out.rd_data != ref_out.rd_data)
        test_failed(dut_out, ref_out);
    else
        test_passed(dut_out, ref_out);
    endfunction

//compare only for the res_out
function void compare_res(my_transaction dut_out, my_transaction ref_out);
    `uvm_info(get_type_name(), "COMPARING RES_OUT", UVM_LOW)
    if(dut_out.res_out != ref_out.res_out)
        test_failed(dut_out, ref_out);
    else
        test_passed(dut_out, ref_out);
    
    endfunction

function void test_passed(my_transaction dut_out, my_transaction ref_out);
            `uvm_info(get_type_name(), "TEST PASSED", UVM_LOW )
            print_more_data(dut_out, ref_out);
endfunction

function void test_failed(my_transaction dut_out, my_transaction ref_out);
            `uvm_warning("", "TEST FAILED")
            print_more_data(dut_out, ref_out);
endfunction

function void print_more_data(my_transaction dut_out, my_transaction ref_out);
    $display("DUT OUT: %0d %0d", dut_out.res_out, dut_out.rd_data);
    $display("REF OUT: %0d %0d", ref_out.res_out, ref_out.rd_data);
    $display("time: %0t", $time);
    // ref_out.print();
    // dut_out.print();
endfunction

endclass
