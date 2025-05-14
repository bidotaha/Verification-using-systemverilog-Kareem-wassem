module register_tb ();
      logic clk;
	  logic reset;
	  logic write;
	  logic [15:0] data_in;
	  logic [2:0] address;
	  logic [15:0] data_out;

      config_reg d (.*);

     typedef string str;
     typedef logic [15:0] reg_val;
     typedef reg_val assoc_t [str];

     assoc_t reset_assoc;

      typedef enum bit[15:0] {adc0_reg ,
                              adc1_reg ,
                              temp_sensor0_reg ,
                              temp_sensor1_reg ,
                              analog_test ,
                              digital_test ,
                              amp_gain ,
                              digital_config } reg_mame;

        reg_mame reg_addr;

        task automatic init_reset;
            reg_addr = reg_addr.first;

            reset_assoc[reg_addr] = 16'hffff;
            reg_addr = reg_addr.next;

            reset_assoc[reg_addr] = 16'h0000;
            reg_addr = reg_addr.next;            

            reset_assoc[reg_addr] = 16'h0000;
            reg_addr = reg_addr.next;

            reset_assoc[reg_addr] = 16'h0000;
            reg_addr = reg_addr.next;

            reset_assoc[reg_addr] = 16'hABCD;
            reg_addr = reg_addr.next;

            reset_assoc[reg_addr] = 16'h0000;
            reg_addr = reg_addr.next;

            reset_assoc[reg_addr] = 16'h0000;
            reg_addr = reg_addr.next;

            reset_assoc[reg_addr] = 16'h1;
            reg_addr = reg_addr.next;                                                            

        endtask   

          task do_reset;
             @(negedge clk);
             reset = 1;
             @(negedge clk);
             reset = 0;
  endtask           

  task cheack_result (input assoc_t data_out_ex);
  @(negedge clk)
      if (data_out_ex !== data_out) begin
      $display("Expected: %h, Got: %h", data_out_ex,data_out);
    end else begin
      $display("PASS");
    end

  endtask   

              initial begin
        clk = 0;
        forever begin
            #1 clk = ~clk;
        end
    end

    initial begin
        init_reset;

        reset = 0;
        write = 0;
        data_in = 0;
        address = 0;

        do_reset;
        // reset
        reg_addr = reg_addr.first;
        for (int i = 0 ; i < reg_addr.num ; i++) begin
            address = reg_addr;
            cheack_result (reset_assoc[reg_addr]);
            reg_addr = reg_addr.next;
        end
        //zero
        reg_addr = reg_addr.first;
        for (int i = 0 ; i < reg_addr.num ; i++) begin
            address = reg_addr;
            write = 1;
            data_in = 16'hffff;
            @(posedge clk);
            cheack_result (16'hffff);
            reg_addr = reg_addr.next;
        end        
        //one
        reg_addr = reg_addr.first;
        for (int i = 0 ; i < reg_addr.num ; i++) begin
            address = reg_addr;
            write = 1;
            data_in = 16'h0000;
            @(posedge clk);
            cheack_result (16'h0000);
            reg_addr = reg_addr.next;
        end        
        //
        reg_addr = reg_addr.first;
        for (int i = 0 ; i < reg_addr.num ; i++) begin
            address = reg_addr;
            write = 1;
            data_in = 16'h1;
            for (int j ; j<16 ; j++) begin
                @(posedge clk);
                cheack_result(data_in);
                data_in = data_in*2;
            end
            reg_addr = reg_addr.next;
        end    

        do_reset;

        reg_addr = reg_addr.first;
        for (int i = 0 ; i < reg_addr.num ; i++) begin
            address = reg_addr;
            cheack_result (reset_assoc[reg_addr]);
            reg_addr = reg_addr.next;
        end            
    end

endmodule