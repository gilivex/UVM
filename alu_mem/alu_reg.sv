//this class is used to store the data of the ALU register and the memory

class alu_reg 
#(parameter int DATA_WIDTH = 8, parameter int ADDR_WIDTH = 2);

my_transaction trans;
bit [ADDR_WIDTH-1:0] my_reg [DATA_WIDTH-1:0];

function new();
reset();
trans = new();
endfunction

function void write_reg ( bit [ADDR_WIDTH-1:0] addr,  bit [DATA_WIDTH-1:0] data);
 my_reg[addr] = data;
endfunction

function bit [DATA_WIDTH-1:0] read_reg ( bit [ADDR_WIDTH-1:0] addr);
return my_reg[addr];
endfunction

function bit is_exc_on();
bit temp;
temp =  my_reg[3][0];
return temp;
endfunction

function void reset();
my_reg = '{default:'0};
endfunction

endclass