package ALSU_pkg;

   parameter INPUT_PRIORITY = "A";
   parameter FULL_ADDER = "ON";

   typedef enum bit [2:0] { OR,XOR,ADD,MULT,SHIFT,ROTATE,invalid6,invalid7 } opcode_e;
  
   localparam MAXPOS = 3, ZERO = 0, MAXNEG = -4;
    
   class ALU_class ;
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
    rand  opcode_e op[6];
    bit clk;

        constraint rst_con{
            rst dist{1:= 2 ,0:= 98};
        }

        //label2
    constraint ALU_cns {
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

        constraint unique_arr {
            foreach (op[i]){
                op [i] inside {[OR:ROTATE]};
                if (i == 1)
                    op [i] dist {OR :/50 , [XOR : ROTATE] :/ 50};
                foreach (op[j]){
                    if (i > j )
                        op [i] != op [j];
                    }
                }
        }

        covergroup ALSU_G @(posedge clk);
       label_A : coverpoint A {
        bins A_data_0 = {0};
        bins A_data_max = {MAXPOS};
        bins A_data_min = {MAXNEG};
        bins A_data_default = default;}  

       label_A_red_op : coverpoint A iff (red_op_A) {
        bins A_data_walking_ones[] = {3'b001,3'b010,3'b100};}

       label_B : coverpoint B {
        bins B_data_0 = {0};
        bins B_data_max = {MAXPOS};
        bins B_data_min = {MAXNEG};
        bins B_data_default = default;}  

       label_B_red_op : coverpoint B iff (red_op_B && !red_op_A) {
        bins B_data_walking_ones[] = {3'b001,3'b010,3'b100};}

        label_opcode : coverpoint opcode {
        bins bin_shift_rotate[] = {SHIFT,ROTATE};
        bins bin_arith[] = {ADD,MULT};
        illegal_bins bin_invalid[] = {invalid6,invalid7};
        bins opcode_tr = (OR=>XOR=>ADD=>MULT=>SHIFT=>ROTATE);}

        label_opcode_or : coverpoint opcode {
        bins bin_or_xor[] = {OR , XOR};}

        label_cin : coverpoint cin;

        label_direction : coverpoint direction;

        label_serialin : coverpoint serial_in;

        cross_add_mult : cross  label_A , label_B , label_opcode 
                        { ignore_bins ig_bins_shift = binsof (label_opcode.bin_shift_rotate);
                          ignore_bins ig_bins_tr = binsof (label_opcode.opcode_tr);}
        
        cross_add_cin : cross label_opcode , label_cin 
                        {   //option.cross_auto_bin_max = 0;
                            bins add_cin = binsof (label_opcode.bin_arith);}

        cross_shift_dir : cross label_opcode , label_direction
                          { //option.cross_auto_bin_max = 0;
                            bins shift_dir = binsof (label_opcode.bin_shift_rotate); }

        label_opcode_shift : coverpoint opcode {
                            bins bin_shift = {SHIFT};}                            

        cross_shift_serial : cross label_opcode_shift , label_serialin;

        cross_or_redop_A : cross  label_B , label_A_red_op , label_opcode_or iff (red_op_A) 
                        { ignore_bins b_max = binsof (label_B.B_data_max);
                          ignore_bins b_min = binsof (label_B.B_data_min);}

        cross_or_redop_B : cross  label_A , label_B_red_op , label_opcode_or iff (red_op_B) 
                        { ignore_bins A_max = binsof (label_A.A_data_max);
                          ignore_bins A_min = binsof (label_A.A_data_min);}

        cross_invalid_case : coverpoint opcode iff (red_op_A || red_op_B)  
                        { bins invalid_case = {invalid6 , invalid7};}
        endgroup    

    function new();
        ALSU_G = new();            
    endfunction         
endclass    
    
endpackage
