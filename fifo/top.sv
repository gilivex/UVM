`include "interface.sv"
`include "fifo.sv"
`include "my_pkg.svh"

module top ;
  
  import uvm_pkg::*;
  import my_pkg::*;

  bit clk, rst;

  always #5 clk = ~clk;

    initial begin
        rst = 1;
        #5 rst = 0;
    end

    inf i_inf(clk,rst);
    fifo f1(i_inf);

    initial begin
        uvm_config_db#(virtual inf)::set(null, "uvm_test_top.*", "inf", i_inf);
        run_test("random_test");
    end


endmodule