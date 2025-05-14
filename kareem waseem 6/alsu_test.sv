
package alsu_test_pkg;
import alsu_env_pkg::*;
import alsu_conf_pkg::*;
import alsu_seq_pkg::*;
import uvm_pkg::*;
import alsu_seq_item_pkg::*;
`include "uvm_macros.svh"

class alsu_test extends uvm_test;

  `uvm_component_utils (alsu_test) 

  alsu_env env;
  alsu_config alsu_cfg;
  virtual alsu_if alsu_vif;
  alsu_main1_seq main1_seq;
  alsu_main2_seq main2_seq;
  alsu_main3_seq main3_seq;
  alsu_reset_seq reset_seq;

  function new (string name = "alsu_env" , uvm_component parent = null);
    super.new (name,parent);
  endfunction   

  function void build_phase (uvm_phase phase);
    super.build_phase(phase);
    env = alsu_env::type_id::create ("env",this);
    alsu_cfg = alsu_config::type_id::create ("alsu_cfg");
    main1_seq = alsu_main1_seq::type_id::create("main1_seq");
    main2_seq = alsu_main2_seq::type_id::create("main2_seq");
    main3_seq = alsu_main3_seq::type_id::create("main3_seq");
    reset_seq = alsu_reset_seq::type_id::create("reset_seq");

    alsu_cfg.is_active = UVM_ACTIVE;

    if (!uvm_config_db#(virtual alsu_if)::get(this,"","alsu_IF",alsu_cfg.alsu_vif))
       `uvm_fatal ("build_phase","test - unable to get the virtual interface");

       uvm_config_db#(alsu_config)::set(this,"*","CFG",alsu_cfg); 

    set_type_override_by_type(alsu_seq_item::get_type(),alsu_seq_item_disable_rst::get_type());   

  endfunction

  task run_phase (uvm_phase phase);
    super.run_phase(phase);
    phase.raise_objection(this);

    //reset
    `uvm_info ("run_phase" , "reset asserted" , UVM_LOW)
    reset_seq.start(env.agt.sqr);
    `uvm_info ("run_phase" , "reset deasserted" , UVM_LOW)
    
    //main1
    `uvm_info ("run_phase" , "stimulus generation started 1" , UVM_LOW)
    main1_seq.start(env.agt.sqr);
    `uvm_info ("run_phase" , "stimulus generation ended 1" , UVM_LOW)   

    //main2
    `uvm_info ("run_phase" , "stimulus generation started 2" , UVM_LOW)
    main2_seq.start(env.agt.sqr);
    `uvm_info ("run_phase" , "stimulus generation ended 2" , UVM_LOW)  

    //main1
    `uvm_info ("run_phase" , "stimulus generation started 3" , UVM_LOW)
    main3_seq.start(env.agt.sqr);
    `uvm_info ("run_phase" , "stimulus generation ended 3" , UVM_LOW)          

    //reset
    `uvm_info ("run_phase" , "reset asserted" , UVM_LOW)
    reset_seq.start(env.agt.sqr);
    `uvm_info ("run_phase" , "reset deasserted" , UVM_LOW)     

    phase.drop_objection(this);
  endtask

endclass: alsu_test
endpackage