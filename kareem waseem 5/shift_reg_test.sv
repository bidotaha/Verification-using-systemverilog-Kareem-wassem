////////////////////////////////////////////////////////////////////////////////
// Author: Kareem Waseem
// Course: Digital Verification using SV & UVM
//
// Description: UVM Example
// 
////////////////////////////////////////////////////////////////////////////////
package shift_reg_test_pkg;
import shift_reg_env_pkg::*;
import shift_reg_conf_pkg::*;
import shift_reg_seq_pkg::*;
import shift_reg_seq_item_pkg::*;
import shift_reg_sequencer_pkg::*;
import uvm_pkg::*;
`include "uvm_macros.svh"

class shift_reg_test extends uvm_test;
  // Example 1
  // Do the essentials (factory register & Constructor)
  // Build the enviornment in the build phase
  // Run in the test in the run phase, raise objection, add #100 delay then display a message using `uvm_info, then drop the objection
  `uvm_component_utils (shift_reg_test) 

  shift_reg_env env;
  shift_reg_config shift_reg_cfg;
  virtual shift_reg_if shift_reg_vif;
  shift_reg_main_seq main_seq;
  shift_reg_reset_seq reset_seq;

  function new (string name = "shift_reg_env" , uvm_component parent = null);
    super.new (name,parent);
  endfunction   

  function void build_phase (uvm_phase phase);
    super.build_phase(phase);
    env = shift_reg_env::type_id::create ("env",this);
    shift_reg_cfg = shift_reg_config::type_id::create ("shift_reg_cfg");
    main_seq = shift_reg_main_seq::type_id::create("main_seq");
    reset_seq = shift_reg_reset_seq::type_id::create("reset_seq");

    if (!uvm_config_db#(virtual shift_reg_if)::get(this,"","SHIFT_REG_IF",shift_reg_cfg.shift_reg_vif))
       `uvm_fatal ("build_phase","test - unable to get the virtual interface");

       uvm_config_db#(shift_reg_config)::set(this,"*","CFG",shift_reg_cfg); 

  endfunction

  task run_phase (uvm_phase phase);
    super.run_phase(phase);
    phase.raise_objection(this);

    //reset
    `uvm_info ("run_phase" , "reset asserted" , UVM_LOW)
    reset_seq.start(env.sqr);
    `uvm_info ("run_phase" , "reset deasserted" , UVM_LOW)
    
    //main
    `uvm_info ("run_phase" , "stimulus generation started" , UVM_LOW)
    main_seq.start(env.sqr);
    `uvm_info ("run_phase" , "stimulus generation ended" , UVM_LOW)    

    phase.drop_objection(this);
  endtask

  // Example 2
  // Build the config object in the build phase
  // get the virtual interface and assign it to the virtual interface of the config object
  // set the config obj in the config db
endclass: shift_reg_test
endpackage