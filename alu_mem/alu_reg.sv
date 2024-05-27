//this class is used to store the data of the ALU register and the memory

class alu_reg (parameter int DATA_WIDTH = 8, parameter int ADDR_WIDTH = 2);

logic [ADDR_WIDTH-1:0] my_reg [DATA_WIDTH-1:0];

function new();
reset();
endfunction

function void write_reg (input logic [ADDR_WIDTH-1:0] addr, input logic [DATA_WIDTH-1:0] data);
if(rd_wr == 0)  
 my_reg[addr] = data;
    
endfunction

function void read_reg (input logic [ADDR_WIDTH-1:0] addr, output logic [DATA_WIDTH-1:0] data);
if(rd_wr == 1)  
return my_reg[addr];
endfunction

function void reset();
my_reg = '{default:'0};
endfunction

endclass