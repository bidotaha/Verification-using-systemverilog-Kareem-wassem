package ALU_pkg;
   
   typedef enum { opcode0,opcode1,opcode2,opcode3,opcode4,opcode5,invalid6,invalid7 } opcode_e;
  
   localparam MAXPOS = 3, ZERO = 0, MAXNEG = -4;
    
   class ALU_class ;
    rand logic rst;
    rand logic signed [2:0] A,B;
    rand logic red_op_A,red_op_B;
    rand opcode_e my_opcode;
    rand logic bypass_A, bypass_B;
    rand logic direction,cin;
    rand logic serial;

    constraint ALU_cns {
        //label1
        rst dist { 0:=99 , 1:=1};
        //label2
        (my_opcode == opcode2 || my_opcode == opcode3) -> A dist { MAXNEG,MAXPOS,ZERO :/ 60};
        (my_opcode == opcode2 || my_opcode == opcode3) -> B dist { MAXNEG,MAXPOS,ZERO :/ 60};
        //label3
        (my_opcode == opcode0 || my_opcode == opcode1 && red_op_A ==1) -> A dist { 1,2,4 :/ 80}; 
        (my_opcode == opcode0 || my_opcode == opcode1 && red_op_A ==1) -> B dist { 0 := 100};
        //label4
        (my_opcode == opcode0 || my_opcode == opcode1 && red_op_B ==1) -> B dist { 1,2,4 :/ 80};
        (my_opcode == opcode0 || my_opcode == opcode1 && red_op_B ==1) -> A dist { 0 := 100};
        //label5
        my_opcode dist { [invalid6:invalid7] := 20,[opcode0:opcode5] := 80};
        //label6
        bypass_A dist { 0:=80 , 1:=20};
        bypass_B dist { 0:=80 , 1:=20};
    } 
    
   endclass 
    
endpackage