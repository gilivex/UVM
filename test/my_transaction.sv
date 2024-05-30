// calss transaction uvm sqeuence item

class my_transaction extends uvm_sequence_item;
 
         bit get_bit;
    rand bit [7:0] data_in;
         bit [7:0] data_out;
     //     bit rst =0;




    // `uvm_object_utils(my_transaction);

    function new(string name = "my_transaction");
        super.new(name);
    endfunction

    `uvm_object_utils_begin(my_transaction)
        `uvm_field_int(data_in, UVM_ALL_ON)
        `uvm_field_int(data_out, UVM_ALL_ON)
            `uvm_field_int(get_bit, UVM_ALL_ON)
   `uvm_object_utils_end

endclass