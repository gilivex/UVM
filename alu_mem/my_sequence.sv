
class my_sequence extends uvm_sequence #(my_transaction);
    `uvm_object_utils(my_sequence)
    
    function new(string name = "my_sequence");
        super.new(name);
    endfunction

    task body();
        my_transaction trans; 
        trans = new();

        write_a(1); 
        write_a(1); 
        write_b(3); 
        write_b(3); 
        write_op(1); 
        write_op(1);
        write_exc(1);
        write_exc(1);

        


// //test 1 
//         start_item(trans);
//         trans.addr = 0;
//         trans.rd_wr = 0;
//         trans.enable = 1;
//         trans.wr_data = 1;

//         finish_item(trans);    

//          start_item(trans);    
//         trans.addr = 1
//         trans.rd_wr = 0;
//         trans.enable = 1;
//         trans.wr_data = 1;
//        finish_item(trans);    

//          start_item(trans);

//         trans.addr = 2 
//         trans.rd_wr = 0;
//         trans.enable = 1;
//         trans.wr_data = 1;
//         finish_item(trans);    

//         start_item(trans);
 
//          trans.addr = 3
//         trans.rd_wr = 0;
//         trans.enable = 1;
//         trans.wr_data = 1;
//         finish_item(trans);    
        

        // repeat(2000) begin
        //     // start_item() is a method of uvm_sequence that creates a new transaction
        //     // and sends it to the sequencer
        //     req = my_transaction::type_id::create("req");
        //     start_item(req);
        //     if(!req.randomize())
        //         `uvm_error(get_type_name(), "randomize failed")

        //     // finish_item() is a method of uvm_sequence that sends the transaction to the driver
        //     // and waits for the driver to finish processing the transaction
        //     finish_item(req);
        // end

    endtask

task write_a(bit [7:0] data);
    my_transaction wr_trans ;
    wr_trans = new();
    wr_trans.addr = 0;
    wr_trans.rd_wr = 0;
    wr_trans.wr_data = data;
    start_item(wr_trans);
    finish_item(wr_trans);
    
 endtask

task write_b(bit [7:0] data);
    my_transaction wr_trans ;
    wr_trans = new();
    wr_trans.addr = 1;
    wr_trans.rd_wr = 0;
    wr_trans.wr_data = data;
    start_item(wr_trans);
    finish_item(wr_trans);
    
 endtask
task write_op(bit [2:0] op);
    my_transaction wr_trans ;
    wr_trans = new();
    wr_trans.addr = 2;
    wr_trans.rd_wr = 0;
    wr_trans.wr_data = op;
    start_item(wr_trans);
    finish_item(wr_trans);
    
 endtask

task write_exc(bit exc);
    my_transaction wr_trans ;
    wr_trans = new();
    wr_trans.addr = 3;
    wr_trans.rd_wr = 0;
    wr_trans.wr_data = 8'b11111111;
    start_item(wr_trans);
    finish_item(wr_trans);
    
 endtask
    
endclass