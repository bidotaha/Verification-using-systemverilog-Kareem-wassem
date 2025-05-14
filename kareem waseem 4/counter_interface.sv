interface counter_if (clk);
    parameter WIDTH = 4;
     input bit clk;
     logic rst_n;
     logic load_n;
     logic up_down;
     logic ce;
     logic [WIDTH-1:0] data_load;
     logic [WIDTH-1:0] count_out;
     logic max_count;
     logic zero;

    modport TEST (
        output rst_n, load_n, up_down, ce, data_load,
        input count_out, clk, max_count, zero
    );

    modport DUT (
        input clk, rst_n, load_n, up_down, ce, data_load,
        output count_out, max_count, zero
    );
endinterface //counter_if
