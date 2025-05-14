import ALU_pkg ::*;
module ALU ();
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
 
    ALSU o (A,B,cin,serial_in,red_op_A,red_op_B,opcode,bypass_A,bypass_B,clk,rst,direction,leds,out);
    ALSU O2 (A,B,cin,serial_in,red_op_A,red_op_B,opcode,bypass_A,bypass_B,clk,rst,direction,leds_ex,out_ex);

        initial begin
        clk = 0;
        forever begin
            #1 clk = ~clk;
        end
    end

    ALU_class my_alu;
    initial begin

        //1
        cheack_reset;

        //2
        my_alu = new;
        repeat (90000) begin
            assert (my_alu.randomize());
            rst = my_alu.rst;
            red_op_A = my_alu.red_op_A;
            red_op_B = my_alu.red_op_B;
            bypass_A = my_alu.bypass_A;
            bypass_B = my_alu.bypass_B;
            direction = my_alu.direction;
            cin = my_alu.cin;
            serial_in = my_alu.serial;
            A = my_alu.A;
            B = my_alu.B;
            opcode = my_alu.my_opcode;
            cheack_result;
        end

        //3
        cheack_reset;

        //4
        repeat (90000) begin
            assert (my_alu.randomize());
            cheack_result ;
        end

        //5
        cheack_reset;        

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