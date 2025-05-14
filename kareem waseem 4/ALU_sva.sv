module ALU_sva (
    input logic clk,
    input logic reset,
    input logic [1:0] Opcode,
    input logic signed [3:0] A,
    input logic signed [3:0] B,
    input logic signed [4:0] C
);

    // A + B 
    property add_check;
        @(posedge clk) disable iff (reset)
            (Opcode == 2'b00) |=> (C == ($past(A) + $past(B)));
    endproperty
    assert property (add_check) else $error("Addition failed: C != A + B");
    cover property (add_check);

    // A - B
property sub_check;
    @(posedge clk) disable iff (reset)
        (Opcode == 2'b01) |=> (C == ($past(A) - $past(B)));
endproperty
    assert property (sub_check) else $error("Subtraction failed: C != A - B");
    cover property (sub_check);

    // ~A (bitwise NOT of A)
    property not_a_check;
        @(posedge clk) disable iff (reset)
            (Opcode == 2'b10) |=> (C == ~$past(A));
    endproperty
    assert property (not_a_check) else $error("Bitwise NOT of A failed");
    cover property (not_a_check);

    // Reduction OR of B
    property reduction_or_check;
        @(posedge clk) disable iff (reset)
            (Opcode == 2'b11) |=> (C == (|$past(B)));
    endproperty
    assert property (reduction_or_check) else $error("Reduction OR of B failed");
    cover property (reduction_or_check);

    // Reset output
    property reset_check;
        @(posedge clk) disable iff (!reset)
            (reset) |=> (C == 5'b0);
    endproperty
    assert property (reset_check) else $error("Reset failed: C != 0");
    cover property (reset_check);

endmodule
