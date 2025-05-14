module counter_top ();
    bit clk;
    always #1 clk = ~clk;

    counter_if count_in (clk);
    counter dut (count_in);
    counter_tb tb (count_in);
    bind counter counter_sva sv (count_in);
    

endmodule