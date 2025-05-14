module adder ( output reg signed [4:0] c,
               input signed [3:0] a,b,
               input clk,rst);
    always @ (posedge clk , posedge rst ) begin
        if (rst)
           c <= 5'b00000;
        else 
           c <= a + b;
    end  
endmodule