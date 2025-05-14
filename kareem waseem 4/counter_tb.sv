import counter_pkg ::*;
module counter_tb (counter_if.TEST count_in);
 
    //counter g (count_in);
    //bind counter counter_sva sva (.*);
    counter_class counter1 = new;

    always @(*) begin
        counter1.clk = count_in.clk;
    end

   initial begin

        count_in.rst_n = 0;
        @(negedge count_in.clk);
        count_in.rst_n = 1;
    
    repeat (9999) begin
        assert (counter1.randomize());
        count_in.rst_n = counter1.reset;
        count_in.load_n = counter1.load_n;
        count_in.ce = counter1.ce;
        count_in.data_load = counter1.data_load;
        count_in.up_down = counter1.up_down;
        counter1.count_out = count_in.count_out;
        @(negedge count_in.clk);
        
    end
    $stop;
   end    

endmodule