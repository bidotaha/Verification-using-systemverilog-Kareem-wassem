module ALU_4_bit_tb ;
    reg  clk;
    reg  reset;
    reg  [1:0] Opcode;	// The opcode
    reg  signed [3:0] A;	// Input data A in 2's complement
    reg  signed [3:0] B;	// Input data B in 2's complement
    wire signed [4:0] C; // ALU output in 2's complement
   ALU_4_bit t (.*);
 
   int error_count = 0;
   int correct_count =0;

   initial begin
    clk = 0;
    forever #1 clk = ~clk;
   end

   task cheack_result ( input signed [4:0] out);
    @(negedge clk);
    if (C != out) begin 
       $display ("error");
       error_count++;
    end
    else begin
        $display ("correct");
        correct_count++;
    end
    endtask 
    
    initial begin
        //label1
        reset = 1;
        cheack_result (0);
        reset = 0;

        //label2
        Opcode = 2'b00;
        A = $random;
        B = $random;
        cheack_result (A+B);

        //label3
        reset = 1;
        cheack_result (0);
        reset = 0;

        //label4
        Opcode = 2'b00;
        A = $random;
        B = $random;
        cheack_result (A+B);                  

        //label5
        Opcode = 2'b01;
        A = $random;
        B = $random;
        cheack_result (A-B);

        //label6
        Opcode = 2'b01;
        A = $random;
        B = $random;
        cheack_result (A-B);

        //label7
        Opcode = 2'b10;
        A = $random;
        cheack_result (~A);

        //label8
        Opcode = 2'b10;
        A = $random;
        cheack_result (~A);

        //label9
        Opcode = 2'b11;
        B = $random;
        cheack_result (|B);

        //label10
        Opcode = 2'b11;
        B = $random;
        cheack_result (|B);

        //label11
        Opcode = 2'b00;
        A = 4'b1111;
        B = $random;
        cheack_result (A+B);

        //label12
        Opcode = 2'b01;
        A = 4'b0000;
        B = $random;
        cheack_result (A-B);

        //label13
        Opcode = 2'b10;
        A = $1111;
        cheack_result (~A);                

        $display("error = %d correct = %d", error_count, correct_count);
        $stop;        
    end

    endmodule