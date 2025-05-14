package alu_pkg;

     typedef enum bit [1:0] { Add,Sub,Not_A,ReductionOR_B } opcode_e;

     class ALU_class ;

     rand bit  reset;
     rand opcode_e opcode;
     rand reg signed [3:0] A;
     rand reg signed [3:0] B;

    constraint ALU_reset {
        reset dist { 0:=99 , 1:=1};
    }     
        endclass
    
endpackage