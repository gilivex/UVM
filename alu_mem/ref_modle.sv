`include "alu_reg.sv"

class ref_model #(logic [ADDR_WIDTH-1:0] my_reg [DATA_WIDTH-1:0];
);

    my_transaction t_out;
    //store the previous result
    bit [16-1:0] old_res ;

    alu_reg alu_reg_inst;

    //constructor
    function new();
        my_transaction t_out = new();
        alu_reg_inst = new();
    endfunction

    function my_transaction step(my_transaction t_in);
    this.t_out = t_in;
    this.t_out.is_data_valid = 0;
    if(t_in.reset == 1) begin
        alu_reg_inst.reset();
        t_out.rd_data = 0;
        t_out.res_out = 0;
        return t_out;
    end
   endfunction

// function for write data
function void read_write(my_transaction t_in);
//write mode
if(t_in.enable == 1) begin
    if(t_in.rd_wr == 0)begin
        if(t_in.addr<2)
            alu_reg_inst.write_reg(t_in.addr, t_in.wr_data);
        else if (t_in.addr==2)
                alu_reg_inst.write_reg(t_in.addr, t_in.wr_data[2:0]);
        else if (t_in.addr==3)
                alu_reg_inst.write_reg(t_in.addr, t_in.wr_data[0]);
        end
    else begin
        alu_reg_inst.read_reg(t_in.addr, t_out.rd_data);
        t_out.is_data_valid = 1;
        end

end
endfunction


function void execute(my_transaction t_in);
if(t_in.addr == 3 ) begin
    if(t_in.data == 0)
        t_in.res_out = old_res;
    if(t_in.data == 1)
      oper(t_in);
end
    endfunction

// function for opertion 
 function void oper(my_transaction t_in);
    if(t_in.addr == 2 ) begin
        case (t_in.data_in)
            0: 
                t_out.res_out= 0;
            1:
                t_out.res_out = t_in.A + t_in.B;
                old_res = t_out.res_out;
            2:
                t_out.res_out = t_in.A - t_in.B;
                old_res = t_out.res_out;
            3:
                t_out.res_out = t_in.A * t_in.B;
                old_res = t_out.res_out;
            4:
                if(t_in.B != 0) 
                    t_out.res_out = t_in.A / t_in.B;
                else
                    t_out.res_out = 16'hdead;
                    old_res = t_out.res_out;
            default:    
                t_out.res_out = old_res;
        endcase
        return;
        end

    endfunction

endclass