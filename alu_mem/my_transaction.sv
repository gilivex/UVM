// calss transaction uvm sqeuence item

class my_transaction extends uvm_sequence_item;

    parameter int ADDAR_WIDTH = 2;
    parameter int DATA_WIDTH = 8;

    //Address for writing or reading
    rand bit [ADDAR_WIDTH-1:0] addr;
    //write data drive by master
    rand bit [DATA_WIDTH-1:0] wr_data;
    // 0-write, 1-read
    rand bit rd_wr;
    //enable for write or read
    rand bit enable;


    // output port
    //read data drive by slave
    bit [DATA_WIDTH-1:0] rd_data;
   //output result
    bit [16-1:0] res_out = 0;
    bit reset = 0;

    // bit to determine if the transaction data is valid or not 
    // we use it in the scoreboard and the reference model
    bit is_data_valid = 0;
    

    // `uvm_object_utils(my_transaction);

    function new(string name = "my_transaction");
        super.new(name);
    endfunction

    `uvm_object_utils_begin(my_transaction)
        `uvm_field_int(addr, UVM_ALL_ON)
        `uvm_field_int(wr_data, UVM_ALL_ON)
        `uvm_field_int(rd_wr, UVM_ALL_ON)
        `uvm_field_int(enable, UVM_ALL_ON)
        `uvm_field_int(rd_data, UVM_ALL_ON)
        `uvm_field_int(res_out, UVM_ALL_ON)

   `uvm_object_utils_end

endclass