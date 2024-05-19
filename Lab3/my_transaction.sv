class my_transaction extends uvm_sequence_item;
    `uvm_object_utils(my_transaction)

    rand bit enable;
	rand bit [3:0] a, b;
	bit [4:0] sum;
    bit rst = 0;

    function new(string name = "my_transaction");
        super.new(name);
        endfunction //new()
    endclass //my_transaction extends uvm_sequence_item