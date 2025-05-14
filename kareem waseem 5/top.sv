////////////////////////////////////////////////////////////////////////////////
// Author: Kareem Waseem
// Course: Digital Verification using SV & UVM
//
// Description: UVM Example
// 
////////////////////////////////////////////////////////////////////////////////
import uvm_pkg::*;
`include "uvm_macros.svh"
import shift_reg_test_pkg::*;

module top();
  // Example 1
  // Clock generation
  // Instantiate the interface and DUT
  // run test using run_test task
  bit clk;

  initial begin
    forever begin
      #1 clk = ~clk;
    end
  end
  
  shift_reg_if shift_regif (clk);
  shift_reg dut (clk,shift_regif.reset,shift_regif.serial_in,shift_regif.direction,shift_regif.mode,shift_regif.datain,shift_regif.dataout);

  initial begin
    uvm_config_db#(virtual shift_reg_if)::set(null,"uvm_test_top","SHIFT_REG_IF",shift_regif); 
    run_test("shift_reg_test");
  end

  // Example 2
  // Set the virtual interface for the uvm test
endmodule