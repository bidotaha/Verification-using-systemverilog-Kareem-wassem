module priority_enc_tb ;
reg  clk;
reg  rst;
reg  [3:0] D;	
wire  [1:0] Y;	
wire valid;

priority_enc p (.*);
bind priority_enc priority_sva sv (.*);

   int error_count = 0;
   int correct_count =0;

   initial begin
    clk = 0;
    forever #1 clk = ~clk;
   end

   task cheack_result_y ( input [1:0] out);
    @(negedge clk);
    if (out != Y) begin 
       $display ("error");
       error_count++;
    end
    else begin
        $display ("correct");
        correct_count++;
    end
    endtask

   task cheack_result_valid ( input valid_expected);
    @(negedge clk);
    if (valid_expected != valid) begin 
       $display ("error");
       error_count++;
    end
    else begin
        $display ("correct");
        correct_count++;
    end
    endtask    

   initial begin
    // label1
    rst = 1;
    cheack_result_y (0);
    rst = 0;

    // label 2
    D = 4'b1000;
    cheack_result_y (0);
    cheack_result_valid (|D);

    // label3
    rst = 1;
    cheack_result_y (0);
    rst = 0; 

    // label 4
    D = 4'b1100;
    cheack_result_y (1);
    cheack_result_valid (|D);

    // label 5
    D = 4'b0100;
    cheack_result_y (1);
    cheack_result_valid (|D);

    // label 6
    D = 4'b1010;
    cheack_result_y (2);
    cheack_result_valid (|D);

    // label 7
    D = 4'b1110;
    cheack_result_y (2);
    cheack_result_valid (|D);

    // label 8
    D = 4'b1111;
    cheack_result_y (3);
    cheack_result_valid (|D);

    // label 9
    D = 4'b1000;
    cheack_result_y (0);
    cheack_result_valid (|D);

    // label 10
    D = 4'b0111;
    cheack_result_y (3);  
    cheack_result_valid (|D);

    // label 11
    D = 4'b0000;
    cheack_result_valid (|D);

    // label 12
    D = 4'b0011;
    cheack_result_y (3);
    cheack_result_valid (|D);   

    repeat (100) begin
      D = $random;
      @(negedge clk);
    end 

        $display("error = %d correct = %d", error_count, correct_count);
        $stop;  
   end


endmodule
