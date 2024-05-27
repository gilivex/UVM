`include "my_transaction.sv"

class coverage; 


my_transaction trans_cov;

covergroup cp;

reset: coverpoint  trans_cov.reset{
bins reset = {0,1};
}

enable: coverpoint trans_cov.enable{
bins e0 = {0};
bins e1 = {1};
}

addr : coverpoint  trans_cov.addr {
bins addr0 = {0};
bins addr1 = {1};
bins addr2 = {2};
bins addr3 = {3};
}

read_write : coverpoint trans_cov.rd_wr {
bins read = {1};
bins write = {0};
}

en_re_wr : cross enable, read_write{
bins e1_r0 = {1,1}; 
bins e1_r1 = {1,0};
}


endgroup


function new();
cp = new();
this.trans_cov = new();
endfunction








endclass