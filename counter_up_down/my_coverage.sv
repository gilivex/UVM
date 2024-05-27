class my_coverage;

my_transaction trans;

covergroup my_coverage_cg;

//coverpoint

up_down_cp: coverpoint trans.up_down {
bins up = {1};
bins down = {0};
}

load_cp: coverpoint trans.load {
bins load = {1};
bins no_load = {0};
}

count_cp: coverpoint trans.count {
    bins min = {0};
    bins mid = {100};
    bins max = {255};
}

rst_cp: coverpoint trans.rst {
    bins rst = {1};
    bins no_rst = {0};
}

// count_edges_cp: coverpoint trans.count {
//     bins zero_to_max = {0};
//     bins max_to_zero = {255};
// }


cross count_cp, up_down_cp;

// cross count_cp, up_down_cp;

//  cross count_cp.min,up_down_cp.up;
//  cross count_cp.max, up_down_cp.down;

endgroup : my_coverage_cg

// some more sufficticeted covergroup
covergroup my_coverage_cr;

//coverpoint

up_down_cr: coverpoint trans.up_down {
bins up = (1[*2]);
bins down = (0[*2]);
}

load_cr: coverpoint trans.load {
bins load = (1[*2]);
bins no_load = (0[*2]);
}
endgroup : my_coverage_cr


function void sample(my_transaction tr);
    trans = tr;
    my_coverage_cg.sample();
    my_coverage_cr.sample();
endfunction

function new();
    trans = new();
    my_coverage_cg = new();
    my_coverage_cr = new();
endfunction


endclass