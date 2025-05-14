package counter_pkg;

  class counter_class ;
    rand logic reset;
    rand logic load_n;
    rand logic ce;
    rand logic [3:0] data;
    rand logic up_down;

    constraint counter_cst {
        reset dist {0 := 1, 1:= 99};
        load_n  dist {0 := 30, 1:= 70};
        ce dist {0 := 30, 1:= 70};  


    }; 

  endclass 
    
endpackage