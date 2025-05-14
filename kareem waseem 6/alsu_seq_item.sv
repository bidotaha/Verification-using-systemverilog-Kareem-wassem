package alsu_seq_item_pkg;
import uvm_pkg::*;
`include "uvm_macros.svh"

   typedef enum bit [2:0] { OR,XOR,ADD,MULT,SHIFT,ROTATE,invalid6,invalid7 } opcode_e;
  
   localparam MAXPOS = 3, ZERO = 0, MAXNEG = -4;

class alsu_seq_item extends uvm_sequence_item;
  `uvm_object_utils(alsu_seq_item)

    rand logic rst;
    rand logic signed [2:0] A,B;
    rand logic red_op_A,red_op_B;
    rand opcode_e opcode;
    rand logic bypass_A, bypass_B;
    rand logic direction,cin;
    rand logic serial_in;
    bit [2:0]walking_ones[] = '{3'b100,3'b010,3'b001};
    rand logic [3:0] A_rem_values , B_rem_values ;  
    rand logic [3:0] A_max_values , B_max_values ;  
    rand bit[2:0]walking_ones_t , walking_ones_f;  
    rand  opcode_e arr[6];
    bit clk;
    logic [15:0] leds;
    logic [15:0] leds_ex;
    logic [5:0] out;
    logic [5:0] out_ex;     

  function new (string name = "alsu_seq_item");
    super.new (name);
  endfunction  

  function string convert2string();
      return $sformatf("%s rst=%b a=%b b=%b opcode=%s",super.convert2string(),rst,A,B,opcode);
  endfunction    

  function string convert2string_stimulus();
      return $sformatf(" rst=%b a=%b b=%b opcode=%s",rst,A,B,opcode);
  endfunction  

        constraint rst_c{
            rst dist{1:= 2 ,0:= 98};
        }

        //label2
    constraint opcode_c {
          A_rem_values != MAXPOS || MAXNEG || ZERO ; 
          B_rem_values != MAXPOS || MAXNEG || ZERO ; 
          A_max_values == MAXPOS || MAXNEG || ZERO ; 
          B_max_values == MAXPOS || MAXNEG || ZERO ;           
          walking_ones_t inside {walking_ones};
          !(walking_ones_f inside {walking_ones});
        
        (opcode == ADD || opcode == MULT) -> A dist { A_max_values :/ 80};
        (opcode == ADD || opcode == MULT) -> B dist { B_max_values :/ 80};
        
        ((opcode == OR || opcode == XOR) && red_op_A) -> A dist {walking_ones_t:=80,walking_ones_f:=20};
        ((opcode == OR || opcode == XOR) && red_op_A) -> B==0;
        
        ((opcode == OR || opcode == XOR) && red_op_B) -> B dist {walking_ones_t:=80,walking_ones_f:=20};
        ((opcode == OR || opcode == XOR) && red_op_B) -> A ==0;
       }
        
        constraint opcode_dist {
        opcode dist { [invalid6:invalid7] := 20,[OR:ROTATE] := 80};
        }
        
        constraint bypass_dist {
        bypass_A dist { 0:=98 , 1:=2};
        bypass_B dist { 0:=98 , 1:=2};
        }

        constraint red_op_dist {
        red_op_A dist { 0:=50 , 1:=50};
        red_op_B dist { 0:=50 , 1:=50};
        }

        constraint arr_c {
            foreach (arr[i]){
              arr[i] == i;
        }  
        }

endclass

class alsu_seq_item_disable_rst extends alsu_seq_item;
  `uvm_object_utils(alsu_seq_item_disable_rst)

    function new (string name = "alsu_seq_item");
    super.new (name);
  endfunction  
  
        constraint rst_disable{
            rst ==0;
        }
endclass 

endpackage