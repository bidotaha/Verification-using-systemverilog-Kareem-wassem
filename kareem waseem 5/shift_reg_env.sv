////////////////////////////////////////////////////////////////////////////////
// Author: Kareem Waseem
// Course: Digital Verification using SV & UVM
//
// Description: UVM Example
// 
////////////////////////////////////////////////////////////////////////////////
package shift_reg_env_pkg;
import uvm_pkg::*;
import shift_reg_driver_pkg::*;
import shift_reg_sequencer_pkg::*;
import shift_reg_seq_item_pkg::*;
`include "uvm_macros.svh"

class shift_reg_env extends uvm_env;
  // Example 1
  // Do the essentials (factory register & Constructor)
  `uvm_component_utils (shift_reg_env)  

  shift_reg_driver driver;
  shift_reg_sequencer sqr;
   
  function new (string name = "shift_reg_env" , uvm_component parent = null);
    super.new (name,parent);
  endfunction 

  function void build_phase (uvm_phase phase);
    super.build_phase (phase);
    driver = shift_reg_driver::type_id::create ("driver",this);
    sqr = shift_reg_sequencer::type_id::create ("sqr",this);
    
  endfunction

  function void connect_phase (uvm_phase phase);
     driver.seq_item_port.connect(sqr.seq_item_export);
  endfunction
  // Example 2
  // Build the driver in the build phase
endclass
endpackage