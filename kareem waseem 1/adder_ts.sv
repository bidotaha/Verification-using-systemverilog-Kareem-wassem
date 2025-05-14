module adder_ts ();
wire signed [4:0] c;     // output
reg signed [3:0] a,b;    // input 
reg clk,rst;             // input 

localparam MAXPOS = 7, ZERO = 0, MAXNEG = -8;
int error_count = 0;
int correct_count = 0;

adder q1 (c,a,b,clk,rst);
// adder q1 (.*); when the same name 

initial begin
    clk = 0;
    forever begin
       #1  clk = ~clk;
    end
end

    task  assert_rst ();
        rst = 1;
        @(negedge clk);
        if (c !== 5'b0) begin
            $display ("not correct");
            error_count++;
            $stop;
        end
        else
            correct_count++;  
        rst = 0; 
    endtask

        task  cheack_result ( input signed [4:0] c_expected);
          @(negedge clk);
          if (c !== c_expected) begin
             $display("not correct for a=%b b=%b", a, b);
             error_count++;
             $stop;
          end    
          else 
             correct_count++; 
    endtask

initial begin
    a = 0;
    b = 0;

    // adder_1

     assert_rst;

    // adder_2

    assert_rst;     

    // adder_3 

    a = MAXPOS;
    b = MAXNEG;   
    cheack_result (-1);

    // adder_4 
    a = MAXPOS;
    b = ZERO;
    cheack_result (7);

    // adder_5 
    a = MAXPOS;
    b = MAXPOS;
    cheack_result (14);

    // adder_6 
   
    a = ZERO;
    b = MAXNEG;
    cheack_result (-8);

    // adder_7

    a = ZERO;
    b = ZERO;
    cheack_result (0);

    // adder_8

    a = ZERO;
    b = MAXPOS;
    cheack_result (7);

    // adder_9

    a = MAXNEG;
    b = MAXNEG;
    cheack_result (-16);

    // adder_10

    a = MAXNEG;
    b = ZERO;
    cheack_result (-8);

    // adder_11

    a = MAXNEG;
    b = MAXPOS;
    cheack_result (-1);
    
    // adder_12 

    a = MAXPOS;
    b = MAXNEG;   
    cheack_result (-1);


    $display (" %t : error_count = %d correct_count = %d",$time ,error_count,correct_count);
    $stop;
end

endmodule