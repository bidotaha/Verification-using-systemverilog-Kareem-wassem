
import uvm_pkg::*;
`include "uvm_macros.svh"
import alsu_test_pkg::*;

module alsu_top();

  bit clk;

  initial begin
    forever begin
      #1 clk = ~clk;
    end
  end
  
  alsu_if alsuif (clk);
  ALSU dut (alsuif);
  ALSU_golden_model dut1 (alsuif);
  bind ALSU ALSU_sva assertion (alsuif);

  initial begin
    uvm_config_db#(virtual alsu_if)::set(null,"uvm_test_top","alsu_IF",alsuif); 
    run_test("alsu_test");
  end

endmodule