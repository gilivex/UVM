`uvm_analysis_imp_decl(_port_in)
`uvm_analysis_imp_decl(_port_out)
class scoreboard extends uvm_scoreboard;

`uvm_component_utils(scoreboard)   

uvm_analysis_imp_port_in#(transaction, scoreboard) scb_port_in;
uvm_analysis_imp_port_out#(transaction, scoreboard) scb_port_out;

transaction tr_in;
transaction tr_out;
bit [7:0] count;
bit [7:0] cur_count;

function new(string name = "scoreboard", uvm_component parent);
    super.new(name, parent);
    tr_in = new("tr_in");
    tr_out = new("tr_out");

endfunction

function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    scb_port_in = new("scb_port_in", this); 
    scb_port_out = new("scb_port_out", this);
    count = 0;
endfunction

function void connect_phase(uvm_phase phase);
endfunction

virtual function void write_port_in(transaction tr);
$display("Inside write_port_in");
$display("tr.enable = %0d, tr.data_in = %0d, tr.load = %0d, tr.rst = %0d", tr.enable, tr.data_in, tr.load, tr.rst);
   
    if(tr.rst) begin
        count = 0;
        return;
        end;
    if(tr.load) begin
        cur_count = tr.data_in;
        count = tr.data_in;
        return;
        end;
    if(tr.enable) begin
        count = count + 1;
        return;
        end;
    endfunction

    virtual function void write_port_out(transaction tr);
        $display("Inside write_port_out");
        $display("tr.count = %0d", tr.count);
    if(tr.count == this.count)
            `uvm_info(get_type_name(), "Count match", UVM_MEDIUM)
     else       
            `uvm_warning(get_type_name(), "Count mismatch")
            $display("tr.count = %0d", tr.count, "count = %0d ", count);
        endfunction


endclass