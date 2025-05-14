package shift_reg_seq_item_pkg;
import uvm_pkg::*;
`include "uvm_macros.svh"

class shift_reg_seq_item extends uvm_sequence_item;
  `uvm_object_utils(shift_reg_seq_item);

  rand logic reset;
  rand logic serial_in, direction, mode;
  rand logic [5:0] datain;
  logic [5:0] dataout;

  function new (string name = "shift_reg_seq_item");
    super.new (name);
  endfunction  

endclass

endpackage