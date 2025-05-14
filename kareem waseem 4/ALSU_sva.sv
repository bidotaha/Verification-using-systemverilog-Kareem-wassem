import ALSU_pkg::*;
module ALSU_sva ( ALSU_if.DUT alsuif );

    property reset_check;
        @(posedge alsuif.clk) (alsuif.rst) |=> (alsuif.out == 0 && alsuif.leds == 0);
    endproperty
    assert property (reset_check) else $error(" error in rst ");
    cover property (reset_check);

    property leds_check;
        @(posedge alsuif.clk) disable iff (alsuif.rst)
            (ALSU.invalid) |=> (alsuif.leds ==~$past(alsuif.leds));
    endproperty
    assert property (leds_check) else $error(" error in leds ");
    cover property (leds_check);

property check1;
    @(posedge alsuif.clk) disable iff (alsuif.rst)
        (alsuif.bypass_A && alsuif.bypass_B && (INPUT_PRIORITY == "A")) 
        |=> (alsuif.out == $past(alsuif.A));
endproperty
assert property (check1) else $error("error in check1 (A priority)");

cover property (check1);



     
endmodule

