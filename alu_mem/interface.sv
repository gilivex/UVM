parameter int 
parameter int DATA_WIDTH = 8;
interface inf #(
    parameter int ADDAR_WIDTH = 2
    parameter int DATA_WIDTH = 8)

(input logic clk, input logic reset);
    // input port
    //Address for writing or reading
    logic [1:0] addr;
    //write data drive by master
    logic wr_data;
    // 0-write, 1-read
    logic rd_wr;
    //enable for write or read
    logic enable;
    // output port
    //read data drive by slave
    logic [7:0] rd_data;
    //output result
    logic [15:0] res_out = 0;
    
    modport  DUT (input clk, reset,  addr,  wr_data,  rd_wr,  enable, output rd_data,  res_out);
     

    
endinterface //inf(input logic )