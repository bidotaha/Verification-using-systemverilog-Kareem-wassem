import uvm_pkg::*;
`include "uvm_macros.svh"
import ALSU_test_pkg::*;

module ALSU_top ();
    bit clk;

    initial begin
        forever #1 clk = ~clk;
    end

    ALSU_if alsuif (clk);
    ALSU DUT (alsuif);

    initial begin
        uvm_config_db#(virtual ALSU_if)::set(null,"uvm_test_top","ALSU_IF",alsuif); 
        run_test ("ALSU_test");
    end
    
endmodule