// sequence class that creates a sequence of transactions that test the adder and that will
// be executed by the driver

class my_sequence extends uvm_sequence #(my_transaction);
`uvm_object_utils(my_sequence)

    function new(string name ="my_sequence");
    super.new(name);        
    endfunction //new()


    task body();
    // my_transaction my_tran;

    repeat(15   )
    begin
        // my_tran = my_transaction::type_id::create("my_tran");
        req= my_transaction::type_id::create("req");    
        start_item(req);
        // if(!req.randomize())
        // `uvm_error("RANDOMIZE_FAILED", "Randomize failed for my_transaction")
        assert(req.randomize());
        finish_item(req);
    end
    endtask //body
endclass //sequence extends uvm_sequence