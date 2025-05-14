package ALSU_test_pkg;
import ALSU_env_pkg::*;
import ALSU_config_pkg::*;
import uvm_pkg::*;
`include "uvm_macros.svh"

class ALSU_test extends uvm_test;
  `uvm_component_utils(ALSU_test)

  ALSU_env env;
  ALSU_config ALSU_cfg;
  virtual ALSU_if ALSU_vif;

  function new (string name = "shift_reg_env" , uvm_component parent = null);
    super.new (name,parent);
  endfunction 

  function void build_phase (uvm_phase phase);
    super.build_phase (phase);
    env = ALSU_env::type_id::create("env",this);
    ALSU_cfg = ALSU_config::type_id::create("ALSU_cfg");

    if (! uvm_config_db #(virtual ALSU_if)::get(this,"","ALSU_IF",ALSU_cfg.ALSU_vif))
      `uvm_fatal("build_phase"," unable to get the virtual interface ");

      uvm_config_db#(ALSU_config)::set(this,"*","CFG",ALSU_cfg); 
      
  endfunction

  task run_phase (uvm_phase phase);
    super.run_phase(phase);
    phase.raise_objection(this);
    #100; `uvm_info("run_phase","welcome to the uvm",UVM_MEDIUM)
    phase.drop_objection(this);
    
  endtask //run_phase

endclass 
endpackage