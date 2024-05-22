class my_sequence extends uvm_sequence #(transaction);
 `uvm_object_utils(my_sequence)

transaction tr;

 function new(string name = "sequence");
     super.new(name);
    endfunction

    task body();

    repeat(100)
    begin
    tr = transaction::type_id::create("tr");
    start_item(tr);
    if(!randomize(tr))
    `uvm_fatal("RANDOMIZE_ERROR","Randomize failed for transaction");
    finish_item(tr);
        
    end
    endtask

    endclass
