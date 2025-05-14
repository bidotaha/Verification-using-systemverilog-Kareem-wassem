package ALSU_pkg;
   
   typedef enum bit [2:0] { OR,XOR,ADD,MULT,SHIFT,ROTATE,invalid6,invalid7 } opcode_e;
  
   localparam MAXPOS = 3, ZERO = 0, MAXNEG = -4;
    
   class ALU_class ;
    rand logic rst;
    rand logic signed [2:0] A,B;
    rand logic red_op_A,red_op_B;
    rand opcode_e my_opcode;
    rand logic bypass_A, bypass_B;
    rand logic direction,cin;
    rand logic serial;
   rand  opcode_e op[6];

    constraint ALU_cns {
        //label1
        rst dist { 0:=99 , 1:=1};
        //label2
        (my_opcode == ADD || my_opcode == MULT) -> A dist { MAXNEG,MAXPOS,ZERO :/ 60};
        (my_opcode == ADD || my_opcode == MULT) -> B dist { MAXNEG,MAXPOS,ZERO :/ 60};
        //label3
        (my_opcode == OR || my_opcode == XOR && red_op_A ==1) -> A dist { 1,2,4 :/ 80}; 
        (my_opcode == OR || my_opcode == XOR && red_op_A ==1) -> B dist { 0 := 100};
        //label4
        (my_opcode == OR || my_opcode == XOR && red_op_B ==1) -> B dist { 1,2,4 :/ 80};
        (my_opcode == OR || my_opcode == XOR && red_op_B ==1) -> A dist { 0 := 100};
        //label5
        my_opcode dist { [invalid6:invalid7] := 20,[OR:ROTATE] := 80};
        //label6
        bypass_A dist { 0:=80 , 1:=20};
        bypass_B dist { 0:=80 , 1:=20};
    }
   constraint OP_cns {
        foreach (op[i])
          op[i] inside {OR,XOR,ADD,MULT,SHIFT,ROTATE};}

    
endclass    
    
endpackage
