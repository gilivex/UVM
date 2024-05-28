`include "alu_reg.sv"

class ref_model;

    // my_transaction t_out;
    //store the previous result
    bit [16-1:0] old_res =0 ;

    alu_reg alu_reg_inst;

    //constructor
    function new();
        // t_out = new();
        alu_reg_inst = new();
        old_res = 0;
    endfunction

// our "main" function that will be called by the scoreboard and  
    function my_transaction step(my_transaction t_in);
    if(t_in.reset == 1) 
        return reset(t_in);
        if(t_in.enable == 1) begin
            //write mode
            if(t_in.rd_wr == 0) 
            write_to_alu(t_in);
            // sending the t_in transaction to the read function and reciving an update transaction 
            // from the function
            else
            t_in = read_to_alu(t_in);
        // there always will be an execute operation 0/1 not depending on the rest of the memory operations
       t_in = execute(t_in);
            return t_in;   
    end
    return t_in;
   endfunction
 // function for reset  
function my_transaction reset(my_transaction t_in);
    alu_reg_inst.reset();
    t_in.rd_data = 0;
    t_in.res_out = 0;
    old_res = 0;
    return t_in;
    endfunction

// function for write data
function void write_to_alu(my_transaction t_in);
//write mode
        if(t_in.addr < 2)begin
            alu_reg_inst.write_reg(t_in.addr, t_in.wr_data);
        if (t_in.addr == 2)
                alu_reg_inst.write_reg(t_in.addr, t_in.wr_data[2:0]);
        if (t_in.addr == 3)
                alu_reg_inst.write_reg(t_in.addr, t_in.wr_data[0]);
        end 
endfunction
//function for read data
function my_transaction read_to_alu(my_transaction t_in);
        t_in.rd_data = alu_reg_inst.read_reg(t_in.addr);
        //very important to set the data valid flag to 1 confirm that
        // the data is valid and we can take this transaction as a valid transaction
        t_in.is_data_valid = 1;
        return t_in;
endfunction

// function for execute the alu operation if execute is 1
function my_transaction execute(my_transaction t_in);
    if(alu_reg_inst.is_exc_on() == 0)begin
        t_in.res_out = old_res;
        return t_in;
    end else
      return oper(t_in);

    endfunction

// function for opertion 
 function my_transaction oper(my_transaction t_in);
  begin
         case (alu_reg_inst.read_reg(2)[2:0])
            0: t_in.res_out = 0;

            1: t_in.res_out = alu_reg_inst.read_reg(0) + alu_reg_inst.read_reg(1);

            2: t_in.res_out = alu_reg_inst.read_reg(0) - alu_reg_inst.read_reg(1);

            3: t_in.res_out = alu_reg_inst.read_reg(0) * alu_reg_inst.read_reg(1);

            4: if(alu_reg_inst.read_reg(1) != 0) 
                t_in.res_out = alu_reg_inst.read_reg(0) / alu_reg_inst.read_reg(1);
                else
                t_in.res_out = 16'hdead;

            default: t_in.res_out = old_res;
  endcase
              old_res = t_in.res_out;

        return t_in;
        end

    endfunction

endclass