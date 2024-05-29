
class my_sequence extends uvm_sequence #(my_transaction);
    `uvm_object_utils(my_sequence)
    
    function new(string name = "my_sequence");
        super.new(name);
    endfunction

    task body();

        my_transaction tr = new();
        
        for(int i = 0; i < 10; i++) begin
            // start_item() is a method of uvm_sequence that creates a new transaction
            // and sends it to the sequencer
            start_item(tr);
            tr.A = i%2;
            if(tr.A == 0)
                tr.B = 1;
            else
                tr.B = 0;
            tr.mode = 0;

            // finish_item() is a method of uvm_sequence that sends the transaction to the driver
            // and waits for the driver to finish processing the transaction
            finish_item(tr);
        end

        repeat(2000) begin
            // start_item() is a method of uvm_sequence that creates a new transaction
            // and sends it to the sequencer
            req = my_transaction::type_id::create("req");
            start_item(req);
            if(!req.randomize())
                `uvm_error(get_type_name(), "randomize failed")

            // finish_item() is a method of uvm_sequence that sends the transaction to the driver
            // and waits for the driver to finish processing the transaction
            finish_item(req);
        end

    endtask

    
endclass