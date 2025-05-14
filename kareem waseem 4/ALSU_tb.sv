import ALSU_pkg::*;
module ALSU_tb ( ALSU_if.TEST alsuif);

    int error_counter = 0;
    int correct_counter = 0;

    ALU_class MY_ALU = new;
        
         always @(posedge alsuif.clk) begin
               if (!alsuif.rst && !alsuif.bypass_A && !alsuif.bypass_B) begin
               MY_ALU.ALSU_G.sample();
          end
         end

    always @(*) begin
        MY_ALU.clk = alsuif.clk;
    end

    initial begin
        //1
        cheack_reset;        
        //2
        repeat (99999) begin
            assert (MY_ALU.randomize());
            alsuif.rst = MY_ALU.rst;
            alsuif.red_op_A = MY_ALU.red_op_A;
            alsuif.red_op_B = MY_ALU.red_op_B;
            alsuif.bypass_A = MY_ALU.bypass_A;
            alsuif.bypass_B = MY_ALU.bypass_B;
            alsuif.direction = MY_ALU.direction;
            alsuif.cin = MY_ALU.cin;
            alsuif.serial_in = MY_ALU.serial_in;
            alsuif.A = MY_ALU.A;
            alsuif.B = MY_ALU.B;
            alsuif.opcode = MY_ALU.opcode;
            cheack_result;
        end
        //3
        cheack_reset;

            $display("error_counter = %d  correct_counter = %d",error_counter,correct_counter);
            $stop;  
    end

   task cheack_result ;
      @(negedge alsuif.clk);
      if ((alsuif.out_ex != alsuif.out) || (alsuif.leds_ex != alsuif.leds)) begin
         $display("%t error",$time);
         error_counter++;
      end
      else 
        correct_counter++;   
       
   endtask

   task cheack_reset ;
        alsuif.rst = 0;
        @(negedge alsuif.clk);
        cheack_result ;
        alsuif.rst = 1;
    endtask      
        

endmodule

