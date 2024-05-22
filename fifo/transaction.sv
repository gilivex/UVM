class transaction extends uvm_sequence_item;
  `uvm_object_utils(transaction)
  
  // declare variables
    
    rand bit [3:0] data_in;
    rand bit read_en, write_en;
    bit [3:0] data_out;
    bit rst = 0;
    bit empty, full;

    // Constructor
    function new (string name = "transaction");
      super.new(name);
      endfunction
  endclass