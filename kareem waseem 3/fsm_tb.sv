import fsm_pkg ::*;
module fsm_tb ();
	logic clk, rst, x;
	logic y;
	logic [9:0] users_count;

    fsm_transaction my_fsm1 = new;

    int error_count = 0;
    int correct_count =0;

    state_e cs = IDLE;
    state_e ns;

     FSM_010 l (.*);

   initial begin
    clk = 0;
    forever begin
      #1 clk = ~clk;
      my_fsm1.clk = clk;
    end
   end

    initial begin
        x = 0;

        cheack_reset;

        repeat (9000) begin
            assert (my_fsm1.randomize());
            rst = my_fsm1.rst;
            x = my_fsm1.x;
            cheack_result(my_fsm1);
        end

        repeat (9000) begin
            assert (my_fsm1.randomize());
            x = my_fsm1.x;
            rst = 0;
            my_fsm1.rst=0;
            cheack_result(my_fsm1);
        end
        $display("error = %d correct = %d", error_count, correct_count);
        $stop;        
    end 
    
   task cheack_result (input fsm_transaction my_fsm2);
    golden_model (my_fsm2);
    if (my_fsm2.rst !== 1) begin
    @(negedge clk);
    if ( (my_fsm2.y_exp !== y) || (my_fsm2.users_count_exp !== users_count) )begin 
       $display ("error in out");
       error_count++;
    end
    else begin
        //$display ("correct");
        correct_count++;
    end
    end
    else begin
    cheack_result_rst;
    end
    endtask 

    task golden_model (input fsm_transaction my_fsm3) ;
		case (cs)
			IDLE: begin
				if (my_fsm3.x)
					ns = IDLE;
				else 
					ns = ZERO;
            end
			ZERO: begin
				if (my_fsm3.x)
					ns = ONE;
				else 
					ns = ZERO;
            end
			ONE: begin
				if (my_fsm3.x)
					ns = IDLE;
				else 
					ns = STORE;
            end
			STORE: begin
				if (my_fsm3.x)
					ns = IDLE;
				else 
					ns = ZERO;
            end
		endcase    
        @(posedge clk) ;
		if(my_fsm3.rst) begin
			cs <= IDLE;
            my_fsm3.users_count_exp <= 0;
		end
		else begin
           if (cs == STORE)
        my_fsm3.users_count_exp++;
       cs = ns;
        end
         my_fsm3.y_exp = (cs == STORE)? 1:0;        

    endtask 

   task cheack_reset ;
        rst = 1;
        cheack_result_rst;
        rst = 0;
       
    endtask  

    task cheack_result_rst ;
       @(negedge clk);
       if ((y !== 0) && (users_count !== 0)) begin
       $display ("error in rst");
       error_count++;
    end
    else begin
      //  $display ("correct");
        correct_count++;
    end

    endtask 

       

endmodule