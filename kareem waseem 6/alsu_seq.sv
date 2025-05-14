package alsu_seq_pkg;
import uvm_pkg::*;
import alsu_seq_item_pkg::*;
`include "uvm_macros.svh"

class alsu_reset_seq extends uvm_sequence #(alsu_seq_item);
  `uvm_object_utils(alsu_reset_seq)
   alsu_seq_item seq_item;

    function new(string name = "alsu_reset_seq");
        super.new(name);
    endfunction 

    task body;
       seq_item = alsu_seq_item::type_id::create("seq_item");
       start_item(seq_item);
       seq_item.rst = 1;
       finish_item (seq_item);
    endtask
endclass 

class alsu_main1_seq extends uvm_sequence #(alsu_seq_item);
  `uvm_object_utils(alsu_main1_seq)
   alsu_seq_item seq_item;

    function new(string name = "alsu_main1_seq");
        super.new(name);
    endfunction 

    task body;
       seq_item = alsu_seq_item::type_id::create("seq_item");
       seq_item.arr_c.constraint_mode(0);
       repeat (999) begin 
       start_item(seq_item);
       assert (seq_item.randomize());
       finish_item (seq_item);
       end
    endtask
endclass 

class alsu_main2_seq extends uvm_sequence #(alsu_seq_item);
  `uvm_object_utils(alsu_main2_seq)
   alsu_seq_item seq_item;

    function new(string name = "alsu_main2_seq");
        super.new(name);
    endfunction 

    task body;
       seq_item = alsu_seq_item::type_id::create("seq_item");
       seq_item.constraint_mode(0);
       seq_item.arr_c.constraint_mode(1);
       repeat (999) begin 
       start_item(seq_item);
       assert (seq_item.randomize());
       finish_item (seq_item);
       end
    endtask
endclass

class alsu_main3_seq extends uvm_sequence #(alsu_seq_item);
  `uvm_object_utils(alsu_main3_seq)
   alsu_seq_item seq_item;

    function new(string name = "alsu_main3_seq");
        super.new(name);
    endfunction 

    task body;
       seq_item = alsu_seq_item::type_id::create("seq_item");
       seq_item.constraint_mode(0);
       seq_item.arr_c.constraint_mode(1);
       for (int i=0 ; i<6 ; i = i+1) begin 
       start_item(seq_item);
       assert (seq_item.randomize());
       seq_item.opcode = seq_item.arr[i];
       finish_item (seq_item);
       end
    endtask
endclass
endpackage