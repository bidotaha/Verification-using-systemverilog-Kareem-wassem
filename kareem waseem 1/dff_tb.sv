module dff_tb1 ();
parameter USE_EN = 1;
logic clk, rst, d, en;
logic q;
logic q_ex;

dff r (.*);

    int error_counter = 0;
    int correct_counter = 0;

task golden_model ;
  if (rst)
      q_ex <= 0;
   else
      if(USE_EN)
         if (en)
            q_ex <= d;
      else 
         q_ex <= d;
    
endtask //automatic

   task cheack_result ;
      @(negedge clk);
      if (q_ex != q) begin
         $display("%t error",$time);
         error_counter++;
      end
      else 
        correct_counter++;   
       
   endtask

   task cheack_reset ;
        rst = 1;
        @(negedge clk);
        cheack_result ;
        rst = 0;
       
    endtask   

        initial begin
        clk = 0;
        forever begin
            #1 clk = ~clk;
        end
    end

    initial begin
        // 1
        cheack_reset ;

        //2
        repeat (400) begin
            d = $random;
            en = $random;
            golden_model ;
            cheack_result ;
        end 

        // 3
        cheack_reset ;        

            $display("error_counter = %d  correct_counter = %d",error_counter,correct_counter);
            $stop;  
    end

endmodule

module dff_tb2 ();
parameter USE_EN = 0;
logic clk, rst, d, en;
logic q;
logic q_ex;

dff r (.*);

    int error_counter = 0;
    int correct_counter = 0;

task golden_model ;
  if (rst)
      q_ex <= 0;
   else
      if(USE_EN)
         if (en)
            q_ex <= d;
      else 
         q_ex <= d;
    
endtask //automatic

   task cheack_result ;
      @(negedge clk);
      if (q_ex != q) begin
         $display("%t error",$time);
         error_counter++;
      end
      else 
        correct_counter++;   
       
   endtask

   task cheack_reset ;
        rst = 1;
        @(negedge clk);
        cheack_result ;
        rst = 0;
       
    endtask   

        initial begin
        clk = 0;
        forever begin
            #1 clk = ~clk;
        end
    end

    initial begin
        // 1
        cheack_reset ;

        //2
        repeat (400) begin
            d = $random;
            en = $random;
            golden_model ;
            cheack_result ;
        end 

        // 3
        cheack_reset ;        

            $display("error_counter = %d  correct_counter = %d",error_counter,correct_counter);
            $stop;  
    end

endmodule