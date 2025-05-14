import alu_pkg ::*;
module ALU_tb ;
    reg  clk;
    reg  reset;
    opcode_e opcode;	// The opcode
    reg  signed [3:0] A;	// Input data A in 2's complement
    reg  signed [3:0] B;	// Input data B in 2's complement
    wire signed [4:0] C; // ALU output in 2's complement

    wire signed [4:0] C_ex;

   ALU_4_bit t (clk,reset,opcode,A,B,C);
   ALU_4_bit k (clk,reset,opcode,A,B,C_ex);

   ALU_class my_ALU_class = new();
 
   int error_count = 0;
   int correct_count =0;

   initial begin
    clk = 0;
    forever #1 clk = ~clk;
   end

   task cheack_result ;
    @(negedge clk);
    if (C != C_ex) begin 
       $display ("error");
       error_count++;
    end
    else begin
        $display ("correct");
        correct_count++;
    end
    endtask 

   task cheack_reset ;
        reset = 0;
        @(negedge clk);
        cheack_result ;
        reset = 1;
       
    endtask      
    
    initial begin
        //1
        cheack_reset;

        //2
        repeat (1000) begin
            assert (my_ALU_class.randomize());
            reset = my_ALU_class.reset;
            A = my_ALU_class.A;
            B = my_ALU_class.B;
            opcode = my_ALU_class.opcode;
            cheack_result;
        end

        //3
        cheack_reset;

        //4
        repeat (90000) begin
            assert (my_ALU_class.randomize());
            cheack_result ;
        end

        //5
        cheack_reset; 

        $display("error = %d correct = %d", error_count, correct_count);
        $stop;        
    end

    endmodule