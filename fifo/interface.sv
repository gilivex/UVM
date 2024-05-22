interface inf(input logic clk, rst);

logic write_en, read_en;
logic [3:0] data_in;
logic full, empty;
logic [3:0] data_out;


modport DUT(input clk, rst, write_en, read_en,data_in, output full, empty, data_out);

endinterface