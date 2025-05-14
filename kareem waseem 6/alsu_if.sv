interface alsu_if (clk);
   parameter INPUT_PRIORITY = "A";
   parameter FULL_ADDER = "ON";
    input bit clk;
    logic [1:0] cin ;
    logic rst, red_op_A, red_op_B, bypass_A, bypass_B, direction, serial_in;
    logic [2:0] opcode;
    logic signed [2:0] A, B;
    logic [15:0] leds;
    logic [15:0] leds_ex;
    logic signed [5:0] out;
    logic signed [5:0] out_ex;    

    modport DUT (
    input clk, cin, rst, red_op_A, red_op_B, bypass_A, bypass_B, direction, serial_in,opcode,A,B,
    output out,leds
    );

    modport GOLDEN_MODEL (
    input clk, cin, rst, red_op_A, red_op_B, bypass_A, bypass_B, direction, serial_in,opcode,A,B,
    output out_ex,leds_ex
    );

endinterface 