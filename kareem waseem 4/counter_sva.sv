import counter_pkg ::*;
module counter_sva (counter_if.DUT count_in);

    always_comb begin
     if(!count_in.rst_n)
     a_reset: assert final(count_in.count_out == 0);
end

    property load_check;
        @(posedge count_in.clk) disable iff (!count_in.rst_n)
            (!count_in.load_n) |=> (count_in.count_out == $past(count_in.data_load));
    endproperty
    assert property (load_check) else $error(" error in load ");
    cover property (load_check);

    property notchange_check;
        @(posedge count_in.clk) disable iff (!count_in.rst_n)
            (count_in.load_n && !count_in.ce) |=> (count_in.count_out == $past(count_in.count_out));
    endproperty
    assert property (notchange_check) else $error(" error in not change ");
    cover property (notchange_check);    

    property increment_check;
        @(posedge count_in.clk) disable iff (!count_in.rst_n)
            (count_in.load_n && count_in.ce && count_in.up_down) |=> (count_in.count_out == $past(count_in.count_out) + 1'b1);
    endproperty
    assert property (increment_check) else $error(" error in increment ");
    cover property (increment_check);

    property decrement_check;
        @(posedge count_in.clk) disable iff (!count_in.rst_n)
            (count_in.load_n && count_in.ce && !count_in.up_down) |=> (count_in.count_out == $past(count_in.count_out) - 1'b1);
    endproperty
    assert property (decrement_check) else $error(" error in decrement ");
    cover property (decrement_check);    

    property max_check;
        @(posedge count_in.clk) disable iff (!count_in.rst_n)
            (count_in.count_out == {WIDTH{1'b1}}) |-> (count_in.max_count);
    endproperty
    assert property (max_check) else $error(" error in max ");
    cover property (max_check);   

    property zero_check;
        @(posedge count_in.clk) disable iff (!count_in.rst_n)
            (count_in.count_out == {WIDTH{1'b0}}) |-> (count_in.zero);
    endproperty
    assert property (zero_check) else $error(" error in zero ");
    cover property (zero_check);      

endmodule