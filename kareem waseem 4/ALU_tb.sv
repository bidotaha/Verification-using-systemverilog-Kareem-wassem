module ALU_4_bit_tb;
    reg clk;
    reg reset;
    reg [1:0] Opcode;         // The opcode
    reg signed [3:0] A;       // Input data A in 2's complement
    reg signed [3:0] B;       // Input data B in 2's complement
    wire signed [4:0] C;      // ALU output in 2's complement
    logic signed [4:0] expected;

    ALU_4_bit t (.*);
    bind ALU_4_bit ALU_sva sva (clk, reset, Opcode, A, B, C);

    // Clock generation
    initial begin
        clk = 0;
        forever #1 clk = ~clk;
    end

    initial begin

        repeat (10000) begin
            Opcode = $random;
            A = $random;  
            B = $random;
            reset = $random;

            @(negedge clk);

        end

        $stop;        
    end
endmodule
