import adder_pkg::*;
module adder_tb ();
logic signed [4:0] c;     // output
logic signed [3:0] a,b;    // input 
bit clk,rst;             // input 
logic signed [4:0] c_expected;     

int error_count = 0;
int correct_count = 0;

adder_class my_adder = new;

 adder q1 (.*); 

initial begin
    clk = 0;
    forever begin
       #1  clk = ~clk;
    end
end

covergroup adder_g @(posedge clk);

  covgrp_a : coverpoint a {
    bins data_a_0 = {ZERO};
    bins data_a_max = {MAXPOS};
    bins data_a_min = {MAXNEG};
    bins data_a_default = default;
  }  

  covgrp_b : coverpoint b {
    bins data_b_0 = {ZERO};
    bins data_b_max = {MAXPOS};
    bins data_b_min = {MAXNEG};
    bins data_b_default = default;
  }   

  covrrp_a_t : coverpoint a {
    bins data_a_0_max = ( ZERO => MAXPOS);
    bins data_a_max_min = ( MAXPOS => MAXNEG);
    bins data_a_min_max = ( MAXNEG => MAXPOS);  
  }

  covrrp_b_t : coverpoint a {
    bins data_b_0_max = ( ZERO => MAXPOS);
    bins data_b_max_min = ( MAXPOS => MAXNEG);
    bins data_b_min_max = ( MAXNEG => MAXPOS);  
  }  

endgroup

adder_g my_adder_g ;

initial begin
    my_adder_g = new;
end

 always @(posedge clk) begin
    if (!rst)
      my_adder_g.sample();
 end
    task  assert_rst;
        rst = 1;
        @(negedge clk);
        if (c !== 5'b0) begin
            $display ("not correct");
            error_count++;
            $stop;
        end
        else
            correct_count++;  
        rst = 0; 
    endtask

    task golden_model;
        if (rst)
           c_expected = 0;
        else 
           c_expected = a + b;

    endtask

        task  cheack_result;
          @(negedge clk);
          if (c_expected !== c) begin
             $display("not correct for a=%b b=%b", a, b);
             error_count++;
             $stop;
          end    
          else 
             correct_count++; 
    endtask

initial begin
    
    //1
    assert_rst ;

   //2 
        repeat (9000) begin
            assert (my_adder.randomize());
            rst = my_adder.rst;
            a = my_adder.a;
            b = my_adder.b;
            golden_model;
            cheack_result;
        end

    //3
    assert_rst;    

    $display (" %t : error_count = %d correct_count = %d",$time ,error_count,correct_count);
    $stop;
end

endmodule