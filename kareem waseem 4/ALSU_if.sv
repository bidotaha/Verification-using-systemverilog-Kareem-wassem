interface ALSU_if (clk);
    input bit clk;
    logic cin, rst, red_op_A, red_op_B, bypass_A, bypass_B, direction, serial_in;
    logic [2:0] opcode;
    logic signed [2:0] A, B;
    logic [15:0] leds;
    logic [15:0] leds_ex;
    logic [5:0] out;
    logic [5:0] out_ex;    

    modport DUT (
    input clk, cin, rst, red_op_A, red_op_B, bypass_A, bypass_B, direction, serial_in,opcode,A,B,
    output out,leds
    );

    modport GOLDEN_MODEL (
    input clk, cin, rst, red_op_A, red_op_B, bypass_A, bypass_B, direction, serial_in,opcode,A,B,
    output out_ex,leds_ex
    );

    modport TEST (
    output cin, rst, red_op_A, red_op_B, bypass_A, bypass_B, direction, serial_in,opcode,A,B,
    input clk,out,leds,out_ex,leds_ex
    );


endinterface 