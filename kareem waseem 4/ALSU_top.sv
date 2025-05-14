module ALSU_top ();
    bit clk;
    always #1 clk = ~clk;

    ALSU_if alsuif (clk);
    ALSU DUT (alsuif);
    ALSU_golden_model GOLDEN_MODEL (alsuif);
    ALSU_tb TEST (alsuif);
    bind ALSU ALSU_sva sv (alsuif);
    

endmodule