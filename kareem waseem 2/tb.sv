import pkg ::*;
module tb2 ;
    exercisel mytest;
    initial begin
        mytest = new;
        repeat (20) begin
            assert (mytest.randomize()) 
            
        end
    end





endmodule