package counter_pkg;

  class counter_class ;

    parameter WIDTH = 4;
    parameter MAX = {WIDTH{1'b1}};
    parameter MIN = {WIDTH{1'b0}};
    rand logic reset;
    rand logic load_n;
    rand logic ce;
    rand logic [WIDTH-1:0] data_load;
    rand logic up_down;
    bit clk;
    logic [WIDTH-1:0] count_out;
    

    constraint counter_cst {
        reset dist {0 := 1, 1:= 99};
        load_n  dist {0 := 30, 1:= 70};
        ce dist {0 := 30, 1:= 70};  
    }; 

    covergroup counter_g @(posedge clk);
        label1 : coverpoint data_load iff (!load_n && reset);
        label2 : coverpoint count_out iff (reset && ce && up_down);
        label3 : coverpoint count_out iff (reset && ce && up_down) {
          bins overflow = (MAX => MIN);
        }
        label4 : coverpoint count_out iff (reset && ce && !up_down);
        label5 : coverpoint count_out iff (reset && ce && !up_down) {
          bins overflow = (MIN => MAX);
        }        
    endgroup

    function new();
        counter_g = new();            
    endfunction    

  endclass 
    
endpackage
