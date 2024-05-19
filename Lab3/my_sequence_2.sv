//secound type of sequences 

class my_sequence_2 extends uvm_sequence #(my_transaction);

`uvm_component_utils(my_sequence_2)

function new(string name = "my_sequence_2");
super.new(name);
endfunction //new()

task body;

repeat(10)
begin 
    req = my_transaction::type_id::create("req");
    start_item(req);
    if(!req.randomize())   
    `uvm_error("RANDOMIZE_FAILED", "Randomize failed for my_transaction");
    req.a =req.b+1;
    finish_item(req);
end

endtask //body
endclass