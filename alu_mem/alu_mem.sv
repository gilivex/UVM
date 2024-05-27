module alu_mem #(

    parameter int DATA_WIDTH =2;
    parameter int ADDR_WIDTH = 8;
)

(inf.DUT i_inf);


    // input port
    //Address for writing or reading
    reg [ADDR_WIDTH-1:0] addr;
    //write data drive by master
    bit wr_data;
    // 0-write, 1-read
    bit rd_wr;
    //enable for write or read
    bit enable;


    // output port
    //read data drive by slave
    biregt [DATA_WIDTH-1:0] rd_data;
    //output result
    reg [16-1:0] res_out = 0;
    

    // internal register
    reg  [2**DATA_WIDTH-1:0] mem [ADDR_WIDTH-1:0] ;
    // internal register A
    reg  [ADDR_WIDTH-1:0] A;
    // internal register B
    reg  [ADDR_WIDTH-1:0] B;
    // internal register OPERETION REG
    reg  [ADDR_WIDTH-1:0] OP_REG;
    // internal register EXUCUTE REG
    reg  [ADDR_WIDTH-1:0] EX_REG;

   // local mem 
     reg [16-1:0] old_res;

    //functional code

    always @(posedge i_inf.clk or posedge i_inf.reset) begin
        if(i_inf.reset) begin
            A <= 0;
            B <= 0;
            OP_REG <= 0;
            EX_REG <= 0;
            old_res <= 0;
        end

        if(EX_REG == 1) begin    
           case (OP_REG)
            0: res_out <= 0;
                old_res <= 0;
            1: res_out <= A + B;
                old_res <= res_out;
            2: res_out <= A - B;
                old_res <= res_out;
            3: res_out <= A * B;
                old_res <= res_out;
            4: if(B != 0) res_out <= A / B;
                else res_out <= 0xDEAD;
                old_res <= res_out;
            default: res_out <=old_res;
           endcase
        else (EX_REG == 0) begin
            res_out <= old_res;
    end
    end
end

    endmodule   