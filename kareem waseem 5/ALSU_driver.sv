package ALSU_driver_pkg;
import ALSU_config_pkg::*;
import uvm_pkg::*;
`include "uvm_macros.svh"

    class ALSU_driver extends uvm_driver;
       `uvm_component_utils(ALSU_driver)
      
  virtual ALSU_if ALSU_vif;
  ALSU_config ALSU_cfg;

  function new (string name = "ALSU_driver" , uvm_component parent = null);
    super.new (name,parent);
  endfunction   

  function void build_phase (uvm_phase phase);
    super.build_phase(phase);

    if (!uvm_config_db#(ALSU_config)::get(this,"","CFG",ALSU_cfg))
       `uvm_fatal ("build_phase","unable to get configuration object"); 
  endfunction

  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    ALSU_vif = ALSU_cfg.ALSU_vif;  /////
  endfunction

  task run_phase (uvm_phase phase);
    super.run_phase(phase);
     ALSU_vif.rst = 0;
     ALSU_vif.cin = 0;
     ALSU_vif.red_op_B = 0;
     ALSU_vif.red_op_A = 0;
     ALSU_vif.bypass_B = 0;
     ALSU_vif.bypass_A = 0;
     ALSU_vif.direction = 0;
     ALSU_vif.serial_in = 0;
     ALSU_vif.opcode = 0;
     ALSU_vif.A = 0;
     ALSU_vif.B = 0;    
     @(negedge ALSU_vif.clk);
     ALSU_vif.rst = 1;
     
     forever begin
        @(negedge ALSU_vif.clk);
        ALSU_vif.A = $random;
        ALSU_vif.B = $random;        
     end
    
  endtask    
    endclass 
endpackage
