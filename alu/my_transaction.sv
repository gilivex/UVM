// calss transaction uvm sqeuence item

class my_transaction extends uvm_sequence_item;
 

    rand bit [3:0] a,b;
    rand bit [1:0] mode;
 
    bit [4:0] out;
    bit rst = 0;
    
    // bit to determine if the transaction data is valid or not 
    // we use it in the scoreboard and the reference model
    bit is_data_valid = 0;


    // `uvm_object_utils(my_transaction);

    function new(string name = "my_transaction");
        super.new(name);
    endfunction

    `uvm_object_utils_begin(my_transaction)
        `uvm_field_int(a, UVM_ALL_ON)
        `uvm_field_int(b, UVM_ALL_ON)
        `uvm_field_int(mode, UVM_ALL_ON)
        `uvm_field_int(out, UVM_ALL_ON)
        `uvm_field_int(rst, UVM_ALL_ON)
        `uvm_field_int(is_data_valid, UVM_ALL_ON)

   `uvm_object_utils_end

endclass