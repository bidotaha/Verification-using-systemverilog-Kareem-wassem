
import ALSU_pkg::*;
module ALSU_tb ();
    parameter INPUT_PRIORITY = "A";
    parameter FULL_ADDER = "ON";
    logic clk, cin, rst, red_op_A, red_op_B, bypass_A, bypass_B, direction, serial_in;
    logic [2:0] opcode;
    logic signed [2:0] A, B;
    logic [15:0] leds;
    bit [15:0] leds_ex;
    logic [5:0] out;
    bit [5:0] out_ex;

    int error_counter = 0;
    int correct_counter = 0;

    ALSU o1 (A,B,cin,serial_in,red_op_A,red_op_B,opcode,bypass_A,bypass_B,clk,rst,direction,leds,out);
    ALSU_golden_model O4 (out_ex,leds_ex,A,B,opcode,clk,rst,cin,serial_in,red_op_A,red_op_B,bypass_A,bypass_B,direction);


    ALU_class MY_ALU = new;

        covergroup ALSU_G @(posedge clk);

       label_A : coverpoint A {
        bins A_data_0 = {0};
        bins A_data_max = {MAXPOS};
        bins A_data_min = {MAXNEG};
        bins A_data_default = default;}  

       label_A_red_op : coverpoint A iff (red_op_A) {
        bins A_data_walking_ones[] = {1,2,4};}

       label_B : coverpoint B {
        bins B_data_0 = {0};
        bins B_data_max = {MAXPOS};
        bins B_data_min = {MAXNEG};
        bins B_data_default = default;}  

       label_B_red_op : coverpoint B iff (red_op_B) {
        bins B_data_walking_ones[] = {1,2,4};}

        label_opcode : coverpoint opcode {
        bins bin_shift[] = {SHIFT,ROTATE};
        bins bin_arith[] = {ADD,MULT};
        bins bin_bitwise[] = {OR,XOR};
        illegal_bins bin_invalid[] = {invalid6,invalid7};
        bins opcode_tr = (0 => 1 => 2 => 3 => 4 => 5);}

        endgroup

        ALSU_G my_alu_g;

        initial begin 
          my_alu_g = new; 
          end

         always @(posedge clk) begin
               if (!rst && !bypass_A && !bypass_B) begin
               my_alu_g.sample();
          end
         end


        initial begin
        clk = 0;
        forever begin
            #1 clk = ~clk;
        end
    end

    initial begin
        //1
        cheack_reset;

        //2
        MY_ALU.OP_cns.constraint_mode(0);
        repeat (90000) begin
            assert (MY_ALU.randomize());
            rst = MY_ALU.rst;
            red_op_A = MY_ALU.red_op_A;
            red_op_B = MY_ALU.red_op_B;
            bypass_A = MY_ALU.bypass_A;
            bypass_B = MY_ALU.bypass_B;
            direction = MY_ALU.direction;
            cin = MY_ALU.cin;
            serial_in = MY_ALU.serial;
            A = MY_ALU.A;
            B = MY_ALU.B;
            opcode = MY_ALU.my_opcode;
            cheack_result;
        end

        //3
        cheack_reset;

        //4
        MY_ALU.OP_cns.constraint_mode(1);
        MY_ALU.ALU_cns.constraint_mode(0);
        rst = 0;
        red_op_A = 0;
        red_op_B = 0;
        bypass_A = 0;
        bypass_B = 0;
        repeat (900000) begin
            assert (MY_ALU.randomize());
            cheack_result ;
        end

        //5
        cheack_reset;
        //6
        opcode = 0;
        repeat(6) begin
            @(negedge clk)
            opcode++;
        end

        //7
        foreach (MY_ALU.op[i]) begin
    opcode = MY_ALU.op[i];
    repeat (100) begin
        assert (MY_ALU.randomize() with { my_opcode == opcode; });
        cheack_result;
    end
        end

    

            $display("error_counter = %d  correct_counter = %d",error_counter,correct_counter);
            $stop;  
    end

   task cheack_result ;
      @(negedge clk);
      if ((out_ex != out) || (leds_ex != leds)) begin
         $display("%t error",$time);
         error_counter++;
      end
      else 
        correct_counter++;   
       
   endtask

   task cheack_reset ;
        rst = 0;
        @(negedge clk);
        cheack_result ;
        rst = 1;
       
    endtask      
        

endmodule

