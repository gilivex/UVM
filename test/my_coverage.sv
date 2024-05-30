class my_coverage;

my_transaction trans_cov;

covergroup dut_cov_points;

    reset : coverpoint trans_cov.data_in[0]{
        bins r0={0};
        bins r1={1};
    }
    start : coverpoint trans_cov.data_in{
        bins e0={0};
    }
    stop : coverpoint trans_cov.data_in{
        bins a1={1};
       
    }

    data : coverpoint trans_cov.get_bit {
        bins d0={0};
        bins d1={1};
        }


    // cross data_cross = {data, start, stop} {
    //     bins d0_e0_a1 = {0, 0, 1};
    //     bins d1_e0_a1 = {1, 0, 1};
    
    // }

    // cross reset_cross = {reset, start, stop} {
    //     bins r0_e0_a1 = {0, 0, 1};
    //     bins r1_e0_a1 = {1, 0, 1};
    // }

    

endgroup:dut_cov_points


function coverage_sample(my_transaction tr);
    this.trans_cov = tr;
    dut_cov_points.sample();
endfunction


function new();
    dut_cov_points=new();
    this.trans_cov = new();
endfunction

endclass



