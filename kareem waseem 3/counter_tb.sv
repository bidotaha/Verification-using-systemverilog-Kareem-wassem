import counter_pkg::*;
module counter_tb ();

    parameter WIDTH = 4;
    logic clk;
    logic rst_n;
    logic load_n;
    logic up_down;
    logic ce;
    logic [WIDTH-1:0] data_load;
    logic [WIDTH-1:0] count_out;
    logic max_count;
    logic zero;

    logic [WIDTH-1:0] count_out_ex;
    int error_counter = 0;
    int correct_counter = 0;
 
    counter #(.WIDTH(WIDTH)) g (.*);

    counter_class counter1 = new;

    initial begin
        clk = 0;
        forever begin
            #1 clk = ~clk;
           counter1.clk = clk;
        end
    end

   task cheack_result (input [WIDTH-1:0] x);
      
      @(negedge clk);
      if (x != count_out) begin
         $display("%t error",$time);
         error_counter++;
      end
      else 
        correct_counter++;   
       
   endtask 

   task cheack_reset ;
        rst_n = 0;
        @(negedge clk);
        cheack_result (0);
        rst_n = 1;
       
    endtask

    task cheack_max ;
       @(negedge clk);
       if (max_count)
         correct_counter++;
      else begin
         $display("%t error",$time);        
        correct_counter++;         
      end
    endtask 

    task cheack_zero ;
       @(negedge clk);
       if (zero)
         correct_counter++;
      else begin
         $display("%t error",$time);        
        correct_counter++;         
      end
    endtask   
   
   initial begin
    ///label1/////
    cheack_reset;
    //////label2////
    load_n = 0;
    data_load = 4'b0001;
    cheack_result (data_load);
    load_n = 1;
    ///label3/////
    cheack_reset;    
    ////////label4//////
    ce = 1;
    up_down = 0;
    cheack_result (count_out-1);
    up_down = 1;
    cheack_result(count_out +1);    
    //////label5////
    ce = 0;
    load_n = 0;
    data_load = 4'b0000;
    cheack_result (data_load);
    cheack_zero ;
    load_n = 1;
    //////label6////
    ce = 1;
    load_n = 0;
    data_load = 4'b0000;
    cheack_result (data_load);
    cheack_zero ;
    load_n = 1;    
    ////////label7//////
    up_down = 0;
    cheack_result (count_out-1);
    up_down = 1;
    cheack_result(count_out +1);
    //////label8////
    load_n = 0;
    data_load = 4'b0100;
    cheack_result (data_load);
    load_n = 1;
    ////////label9//////
    up_down = 0;
    cheack_result (count_out-1);
    up_down = 1;
    cheack_result(count_out +1);
    //////label10////
    load_n = 0;
    data_load = 4'b1111;
    cheack_result (data_load);
    cheack_max ;
    load_n = 1;    
    //////label11////
    load_n = 0;
    data_load = 4'b0010;
    cheack_result (data_load);
    load_n = 1;   
    //////label12////
    load_n = 0;
    data_load = 4'b1100;
    cheack_result (data_load);
    load_n = 1;     
    ///label13/////
    cheack_reset;    
    
    /// 14
    
     repeat (9000) begin
        assert (counter1.randomize());
        rst_n = counter1.reset;
        load_n = counter1.load_n;
        ce = counter1.ce;
        data_load = counter1.data_load;
        up_down = counter1.up_down;
        counter1.count_out = count_out;
        golden_model ;
        cheack_out ;
        
    end
    
    $display("error_counter = %d  correct_counter = %d",error_counter,correct_counter);
    $stop;
   end    

   task golden_model ;
    if (!rst_n)
        count_out_ex <= 0;
    else if (!load_n)
        count_out_ex <= data_load;
    else if (ce)
        if (up_down)
            count_out_ex <= count_out_ex + 1;
        else 
            count_out_ex <= count_out_ex - 1;
   endtask 

   task cheack_out ;
      
      @(negedge clk);
      if (count_out_ex != count_out) begin
         $display("%t error",$time);
         error_counter++;
      end
      else 
        correct_counter++;   
       
   endtask 

endmodule