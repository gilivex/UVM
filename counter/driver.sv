class driver extends uvm_driver #(transaction);
     `uvm_component_utils(driver)

        virtual inf i_inf;

        function new (string name = "driver", uvm_component parent);
            super.new(name, parent);
        endfunction

        function void build_phase(uvm_phase phase);
            super.build_phase(phase);
            uvm_config_db #(virtual inf)::get(this, "", "inf", i_inf);
        endfunction

        task run_phase(uvm_phase phase);
          transaction tr = new();
            // tr = transaction::type_id::create("tr",this);
 
           forever begin
            seq_item_port.get_next_item(tr);
             @(posedge i_inf.clk) begin
             i_inf.enable <= tr.enable;
             i_inf.data_in <= tr.data_in;
             i_inf.load <= tr.load;

            //  `uvm_info("DRIVER", $sformatf("Data_in = %0d, Load = %0d, enable = %0d", tr.data_in, tr.load,tr.enable), UVM_MEDIUM);
                // $display("Driver: Data_in = %0d, Load = %0d, enable = %0d", tr.data_in, tr.load,tr.enable);
            seq_item_port.item_done();
            end
            end
           endtask
endclass