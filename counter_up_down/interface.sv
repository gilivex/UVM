interface inf(input logic clk, rst);

//declare the signals
    logic [7:0] data_in;
    logic load;
    logic enable;
    logic [7:0] count;

    modport DUT(input data_in, load, enable, clk, rst, output count);

endinterface //inf