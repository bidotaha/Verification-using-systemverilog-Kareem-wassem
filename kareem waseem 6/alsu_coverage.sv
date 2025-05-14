package alsu_coverage_pkg;
import alsu_seq_item_pkg::*;
import uvm_pkg::*;
`include "uvm_macros.svh"  
  
  class alsu_coverage extends uvm_component;
    `uvm_component_utils(alsu_coverage)

    uvm_analysis_export #(alsu_seq_item) cov_export;
    uvm_tlm_analysis_fifo # (alsu_seq_item) cov_fifo;
    alsu_seq_item seq_item_cov;

        covergroup cvr_gp ;
       label_A : coverpoint seq_item_cov.A {
        bins A_data_0 = {0};
        bins A_data_max = {MAXPOS};
        bins A_data_min = {MAXNEG};
        bins A_data_default = default;}  

       label_A_red_op : coverpoint seq_item_cov.A iff (seq_item_cov.red_op_A) {
        bins A_data_walking_ones[] = {3'b001,3'b010,3'b100};}

       label_B : coverpoint seq_item_cov.B {
        bins B_data_0 = {0};
        bins B_data_max = {MAXPOS};
        bins B_data_min = {MAXNEG};
        bins B_data_default = default;}  

       label_B_red_op : coverpoint seq_item_cov.B iff (seq_item_cov.red_op_B && !seq_item_cov.red_op_A) {
        bins B_data_walking_ones[] = {3'b001,3'b010,3'b100};}

        label_opcode : coverpoint seq_item_cov.opcode {
        bins bin_shift_rotate[] = {SHIFT,ROTATE};
        bins bin_arith[] = {ADD,MULT};
        illegal_bins bin_invalid[] = {invalid6,invalid7};
        bins opcode_tr = (OR=>XOR=>ADD=>MULT=>SHIFT=>ROTATE);}

        label_opcode_or : coverpoint seq_item_cov.opcode {
        bins bin_or_xor[] = {OR , XOR};}

        label_cin : coverpoint seq_item_cov.cin;

        label_direction : coverpoint seq_item_cov.direction;

        label_serialin : coverpoint seq_item_cov.serial_in;

        cross_add_mult : cross  label_A , label_B , label_opcode 
                        { ignore_bins ig_bins_shift = binsof (label_opcode.bin_shift_rotate);
                          ignore_bins ig_bins_tr = binsof (label_opcode.opcode_tr);}
        
        cross_add_cin : cross label_opcode , label_cin 
                        {   //option.cross_auto_bin_max = 0;
                            bins add_cin = binsof (label_opcode.bin_arith);}

        cross_shift_dir : cross label_opcode , label_direction
                          { //option.cross_auto_bin_max = 0;
                            bins shift_dir = binsof (label_opcode.bin_shift_rotate); }

        label_opcode_shift : coverpoint seq_item_cov.opcode {
                            bins bin_shift = {SHIFT};}                            

        cross_shift_serial : cross label_opcode_shift , label_serialin;

        cross_or_redop_A : cross  label_B , label_A_red_op , label_opcode_or iff (seq_item_cov.red_op_A) 
                        { ignore_bins b_max = binsof (label_B.B_data_max);
                          ignore_bins b_min = binsof (label_B.B_data_min);}

        cross_or_redop_B : cross  label_A , label_B_red_op , label_opcode_or iff (seq_item_cov.red_op_B) 
                        { ignore_bins A_max = binsof (label_A.A_data_max);
                          ignore_bins A_min = binsof (label_A.A_data_min);}

        cross_invalid_case : coverpoint seq_item_cov.opcode iff (seq_item_cov.red_op_A || seq_item_cov.red_op_B)  
                        { bins invalid_case = {invalid6 , invalid7};}
        endgroup 

  function new (string name = "alsu_cov" , uvm_component parent = null);
    super.new (name,parent);
    cvr_gp = new();
  endfunction 

    function void build_phase (uvm_phase phase);
    super.build_phase (phase);
    cov_export = new("cov_export",this);
    cov_fifo = new("cov_fifo",this);
  endfunction

  function void connect_phase(uvm_phase phase);
   super.connect_phase(phase);
   cov_export.connect(cov_fifo.analysis_export);
  endfunction  

  task run_phase (uvm_phase phase);
   super.run_phase(phase);
   forever begin
    cov_fifo.get(seq_item_cov);
    cvr_gp.sample();
   end
  endtask

  endclass 

  endpackage