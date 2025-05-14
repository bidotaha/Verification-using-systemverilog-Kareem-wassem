module ram_tb ();
    localparam TESTS = 100;
    logic clk;
    logic write;
    logic read;
    logic [7:0] data_in;
    logic [15:0] address;
    logic [7:0] data_out;
    logic [7:0] data_out_ex;

    int address_array[TESTS];
    int data_to_write_array[TESTS];
    int data_read_expect_assoc [int];
    int data_read_queue[$];

    int error_counter = 0;
    int correct_counter = 0;
    int i = 0;

    my_mem t (.*);

    initial begin
        clk = 0;
        forever begin
            #1 clk = ~clk;
        end
    end    

   task golden_model;
       data_out_ex = data_read_expect_assoc[address_array[i]];
   endtask         
   
   task stimulus_gen ;
     for (i=0 ; i<TESTS ; i++) begin
       address_array[i] = $urandom_range(0,65535);
       data_to_write_array[i] = $urandom_range(0,255);
       data_read_expect_assoc[address_array[i]] = {~^data_to_write_array[i], data_to_write_array[i]};
     end 
   endtask

      task cheack_result ;
      @(negedge clk);
      if (data_out_ex != data_out) begin
         $display("%t error",$time);
         error_counter++;
      end
      else 
        correct_counter++;   

        data_read_queue.push_back (data_out);
       
      endtask

      initial begin
         write = 0;
         read = 0;
         data_in = 0;
         address = 0;
         //1
         stimulus_gen;

         for (i=0 ; i<TESTS ; i++) begin
            @(negedge clk);
            address = address_array[i];
            data_in = data_to_write_array[i];
            read = 0;
            write = 1;
         end
         //2
         @(negedge clk);
         write = 0;

        for (i=0 ; i<TESTS ; i++) begin
            @(negedge clk);
            address = address_array[i];
            read = 1;
            write = 0;
            golden_model;
            @(posedge clk);
            cheack_result;
         end         
        
        read = 0;

        //3  display output 

        while (data_read_queue.size() > 0) begin
         $display (" data = %0h ",data_read_queue.pop_front());
        end

        $display("error_counter = %d  correct_counter = %d",error_counter,correct_counter);
        $stop; 
      end

    

endmodule