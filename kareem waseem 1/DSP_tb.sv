module DSP_tb;
reg  [17:0] A, B, D;
reg  [47:0] C;
reg clk, rst_n;
wire  [47:0] P;
DSP o (.*);

   int error_count = 0;
   int correct_count =0;
   reg [47:0] p_expected,mult_out;
   reg [17:0] adder_out;
   

initial begin
    clk = 0;
    forever begin
        #1 clk = ~clk;
    end
end

task cheack_result_rst (input [47:0] out);
    @(negedge clk);
    if (out != P) begin
        $display ("error");
        error_count++;
    end
    else begin
        $display ("correct");
        correct_count++;
    end    
endtask 

task cheack_result_p;
    repeat (4) @(negedge clk);
    adder_out = B + D;
    mult_out = adder_out * A;
    p_expected = mult_out + C;
    if (p_expected != P) begin
        $display("%t error",$time);
        error_count++;
    end
   else begin
    $display ("%t correct",$time);
    correct_count++;
   end     
   endtask

initial begin
    // label1
    rst_n = 0;
    @(negedge clk);
    cheack_result_rst(0);
    @(negedge clk);
    rst_n = 1;

    //label 2 
    repeat(100) begin

        A = $random;
        B = $random;
        C = $random;
        D = $random;
        cheack_result_p;
    end

    // label1
    rst_n = 0;
    @(negedge clk);
    cheack_result_rst(0);
    @(negedge clk);
    rst_n = 1;    
    
        $display("error = %d correct = %d", error_count, correct_count);
        $stop;      
end

endmodule 