package testing_pkg;

  typedef enum  {ADD,SUB,MULT,DIV,OR} opcode_e;

    class transaction;
      rand opcode_e opcode;
      rand byte operand1;
      rand byte operand2;
      bit clk;

      covergroup covcode @(posedge clk);
             opcode_label : coverpoint opcode {
                bins add_sub = {ADD,SUB};
                bins add__sub = (ADD => SUB);
                illegal_bins div = {DIV};
             } 
             oprand_label : coverpoint operand1 {
                bins maxneg  = {-128};
                bins zero  = {0};
                bins maxpos  = {127};
                bins opbin = default;
             }
              a : cross opcode_label , oprand_label
              { bins add_sub_max = binsof(opcode_label.add_sub) && binsof(oprand_label.maxneg);
                bins add_sub_neg = binsof(opcode_label.add_sub) && binsof(oprand_label.maxpos);
                option.weight=5;
                //option.cross_auto_bin_max=0;
                }
      endgroup

 
             function new();
                covcode = new();
                
             endfunction

        
    endclass //className

endpackage