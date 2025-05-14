package alsu_sco_pkg;
import alsu_seq_item_pkg::*;
import uvm_pkg::*;
`include "uvm_macros.svh"  
  
  class alsu_sco extends uvm_scoreboard;
    `uvm_component_utils(alsu_sco)

    uvm_analysis_export #(alsu_seq_item) sb_export;
    uvm_tlm_analysis_fifo # (alsu_seq_item) sb_fifo;
    alsu_seq_item seq_item_sb;
    logic [5:0] dataout_ref;
    int error_count = 0;
    int correct_count = 0;
  function new (string name = "alsu_sco" , uvm_component parent = null);
    super.new (name,parent);
  endfunction 

    function void build_phase (uvm_phase phase);
    super.build_phase (phase);
    sb_export = new("sb_export",this);
    sb_fifo = new("sb_fifo",this);
  endfunction

  function void connect_phase(uvm_phase phase);
   super.connect_phase(phase);
   sb_export.connect(sb_fifo.analysis_export);
  endfunction  

  task run_phase (uvm_phase phase);
   super.run_phase(phase);
   forever begin
    sb_fifo.get(seq_item_sb);
    if ((seq_item_sb.out != seq_item_sb.out_ex) && (seq_item_sb.leds != seq_item_sb.leds_ex)) begin
        `uvm_error("run_phase",$sformatf("compartion failled while ref = %b",seq_item_sb.out_ex))
        error_count++;
    end
    else 
       correct_count++;
   end
  endtask

  function void report_phase (uvm_phase phase);
   super.report_phase(phase);
   `uvm_info("report_phase",$sformatf("corect = %d",correct_count) , UVM_MEDIUM)
   `uvm_info("report_phase",$sformatf("error = %d",error_count) , UVM_MEDIUM)
  endfunction
  endclass 
  endpackage