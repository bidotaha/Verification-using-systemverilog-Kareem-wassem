package fsm_pkg;

   typedef enum { STORE,IDLE,ZERO,ONE } state_e;

   class fsm_transaction ;
      rand bit x,rst;
      bit y_exp ;
      bit [9:0] users_count_exp;
      bit clk;

    constraint fsm_reset {
        rst dist { 0:=99 , 1:=1};
    }        
    constraint x_reset {
        x dist { 0:=67 , 1:=33};
    }      

    covergroup FSM_G @(posedge clk);
     
      label1 : coverpoint x {
        bins t_x = (0 => 1 => 0);
      }
      
    endgroup    

    function new();
        FSM_G = new;
        
    endfunction
   endclass
    
endpackage
