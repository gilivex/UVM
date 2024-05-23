class transaction extends uvm_sequence_item;
  `uvm_object_utils(transaction)
  
  // declare variables
    rand bit [7:0] data_in;
    rand bit load, enable;
         bit [7:0] count;

    bit rst = 0;

    // Constructor
    function new (string name = "transaction");
      super.new(name);
      endfunction
  endclass