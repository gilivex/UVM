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

// here i would like to get the transaction from the 
//monitor_in (usually when there were changes in the input ports)
// and then send this transaction(inputs) to the reference model
// and then get the output from the reference model and compare it with the first cell in the fifo
// if they are not equal i will enter this output(from the reference model) to the fifo
//else i will just ignore it
virtual function void write_port_in(my_transaction trans);
 my_transaction ref_trans = new();
    ref_trans = ref_m.step(trans);
    my_fifo.push_back(ref_trans);
    //first we check if the fifo is empty and the last transaction
    // is not equal to the reference transaction
    // if(my_fifo.size() == 0)begin
    //     if(last_trans.Y != ref_trans.Y) 
    //         my_fifo.push_back(ref_trans);
    // end
    //now we check if the last transaction is not equal to the
    // reference transaction in the head of the fifo
    
//    else begin
//    my_transaction temp = new();
//    temp = my_fifo.pop_front();
//    my_fifo.push_front(temp);
// //    if(last_trans.Y !=my_fifo[my_fifo.size()-1].Y) 
//         if(last_trans.Y != temp.Y)
//         my_fifo.push_back(temp); 
//     end
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
    if(dut_out.Y != ref_out.Y) begin
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
