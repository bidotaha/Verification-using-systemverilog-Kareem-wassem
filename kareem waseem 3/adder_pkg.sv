package adder_pkg;

enum { MAXPOS = 7, ZERO = 0, MAXNEG = -8 } pos_neg;

class adder_class;
 
rand logic signed [3:0] a,b;    
rand bit rst;            

constraint rst_con {
    rst dist { 1 := 2 , 0:= 98};
}

constraint a_b_con {
    a dist { MAXPOS,ZERO,MAXNEG :/ 70 };
}

endclass

endpackage