import testing_pkg ::*;
module alu_tb ();
    byte operand1, operand2, out;
    bit clk, rst;
    opcode_e opcode;
    byte out_ex;

    alu_seq o (.*);

    transaction test1 = new;

    int error_count = 0;
    int correct_count =0;

    initial begin
        clk = 0;
        forever begin
            #1 clk = ~clk;
            test1.clk = clk;
        end
    end
    
    initial begin
        cheack_reset;

        repeat (50000) begin
            assert(test1.randomize);
            opcode = test1.opcode;
            operand1 = test1.operand1;
            operand2 = test1.operand2;
            @(negedge clk);
            cheack_result;
        end

        cheack_reset;

        

        $display("error = %d correct = %d", error_count, correct_count);
        $stop;
    end

   task cheack_result ;
    golden_model ;
    if (rst !== 1) begin
    @(negedge clk);
    if  (out_ex !== out)
       error_count++;
    else 
        correct_count++;
    end
    else begin
    cheack_result_rst;
    end
    endtask

    task golden_model;
	if (rst)
		out_ex <= 0;
	else 
		case (opcode)
			ADD: out_ex <= operand1 + operand2;
			SUB: out_ex <= operand1 - operand2;
			MULT:out_ex <= operand1 * operand2; 
			DIV: out_ex <= operand1 / operand2;
			default: out_ex <= 0;
		endcase
    endtask

   task cheack_reset ;
        rst = 1;
        cheack_result_rst;
        rst = 0;
       
    endtask 

    task cheack_result_rst ;
       @(negedge clk);
       if (out !== 0)
       error_count++;

    else
        correct_count++;

    endtask              
    
endmodule