package shift_reg_seq_pkg;
import uvm_pkg::*;
import shift_reg_seq_item_pkg::*;
`include "uvm_macros.svh"

class shift_reg_reset_seq extends uvm_sequence #(shift_reg_seq_item);
  `uvm_object_utils(shift_reg_reset_seq)
   shift_reg_seq_item seq_item;

    function new(string name = "shift_reg_reset_seq");
        super.new(name);
    endfunction //new()

    task body;
       seq_item = shift_reg_seq_item::type_id::create("seq_item");
       start_item(seq_item);
       seq_item.reset = 1;
       seq_item.datain = 0;
       seq_item.serial_in = 0;
       seq_item.direction = 0;
       seq_item.mode = 0;
       finish_item (seq_item);
    endtask
endclass //className

class shift_reg_main_seq extends uvm_sequence #(shift_reg_seq_item);
  `uvm_object_utils(shift_reg_main_seq)
   shift_reg_seq_item seq_item;

    function new(string name = "shift_reg_main_seq");
        super.new(name);
    endfunction //new()

    task body;
       seq_item = shift_reg_seq_item::type_id::create("seq_item");
       repeat (1000) begin 
       start_item(seq_item);
       assert (seq_item.randomize());
       finish_item (seq_item);
       end
    endtask
endclass //className


endpackage