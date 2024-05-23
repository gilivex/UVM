class my_coverage;

// coverage for my fifo DUT 
bit read_en;
bit write_en;
bit full;
bit empty;
bit [3:0] data_in;
bit [3:0] data_out;
bit rst;


covergroup my_fifo_cov;
coverpoint read_en;
coverpoint write_en;
coverpoint full;
coverpoint empty;
coverpoint data_in;
coverpoint data_out;
coverpoint rst;
endgroup : my_fifo_cov

covergroup is_empty_is_full_cov;
is_empty_cov: 
bins is_empty[2] = {0, 1};

is_full_cov: 
bins is_full[2] = {0, 1};
endgroup : is_empty_is_full_cov




endclass
