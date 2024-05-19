class seq_of_seq extends uvm_sequence #(my_transaction);

 `uvm_component_utils(seq_of_seq)

my_sequence_1 seq_1;
my_sequence_2 seq_2;


virtual task body;
seq_1 = my_sequence_1::type_id::create("seq_1");
seq_2 = my_sequence_2::type_id::create("seq_2");

repeat(5)
begin
start_item(seq_1);
start_item(seq_2);
end

endtask //body
endclass