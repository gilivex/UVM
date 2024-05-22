class driver extends uvm_driver #(transaction);
     `uvm_component_utils(driver)

        virtual inf vinf;

        function new (string name = "driver", uvm_component parent);
            super.new(name, parent);
        endfunction

        function void build_phase(uvm_phase phase);
            super.build_phase(phase);
            uvm_config_db #(virtual inf)::get(this, "", "inf", vinf);
        endfunction

        task run_phase(uvm_phase phase);
          transaction trans = new();
 
           forever begin
            seq_item_port.get_next_item(trans);
             @(posedge vinf.clk) begin
            vinf.write_en <= trans.write_en;
            vinf.read_en <= trans.read_en;
            vinf.data_in <= trans.data_in;
            
            seq_item_port.item_done();
            end
            end
           endtask
endclass