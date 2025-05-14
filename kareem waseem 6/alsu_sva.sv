
module ALSU_sva ( alsu_if.DUT alsuif );

   parameter INPUT_PRIORITY = "A";
   parameter FULL_ADDER = "ON";
   
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
        ( !ALSU.invalid && ALSU.bypass_A_reg && ALSU.bypass_B_reg ) |=> 
           (alsuif.out == (( INPUT_PRIORITY == "A" ) ? $past(ALSU.A_reg) : $past(ALSU.B_reg)));
endproperty
assert property (check1) else $error("error in check1 (A priority)");
cover property (check1);

property check2;
    @(posedge alsuif.clk) disable iff (alsuif.rst)
        ( !ALSU.invalid && ALSU.bypass_A_reg && !ALSU.bypass_B_reg ) |=> 
           (alsuif.out == $past(ALSU.A_reg));
endproperty
assert property (check2) else $error("error in check2");
cover property (check2);

property check3;
    @(posedge alsuif.clk) disable iff (alsuif.rst)
        ( !ALSU.invalid && !ALSU.bypass_A_reg && ALSU.bypass_B_reg ) |=> 
           (alsuif.out == $past(ALSU.B_reg));
endproperty
assert property (check3) else $error("error in check3");
cover property (check3);

property check4;
    @(posedge alsuif.clk) disable iff (alsuif.rst)
        ( !ALSU.bypass_A_reg && !ALSU.bypass_B_reg && !ALSU.invalid && (ALSU.opcode_reg == 3'b000) && ALSU.red_op_A_reg && ALSU.red_op_B_reg) |=> 
           (alsuif.out == (( INPUT_PRIORITY == "A" ) ? |$past(ALSU.A_reg) : |$past(ALSU.B_reg)));
endproperty
assert property (check4) else $error("error in check4");
cover property (check4);

property check5;
    @(posedge alsuif.clk) disable iff (alsuif.rst)
        ( !ALSU.bypass_A_reg && !ALSU.bypass_B_reg && !ALSU.invalid && (ALSU.opcode_reg == 3'b000) && ALSU.red_op_A_reg && !ALSU.red_op_B_reg) |=> 
           (alsuif.out == |$past(ALSU.A_reg));
endproperty
assert property (check5) else $error("error in check5");
cover property (check5);

property check6;
    @(posedge alsuif.clk) disable iff (alsuif.rst)
        ( !ALSU.bypass_A_reg && !ALSU.bypass_B_reg && !ALSU.invalid && (ALSU.opcode_reg == 3'b000) && !ALSU.red_op_A_reg && ALSU.red_op_B_reg) |=> 
           (alsuif.out == |$past(ALSU.B_reg));
endproperty
assert property (check6) else $error("error in check6");
cover property (check6);

property check7;
    @(posedge alsuif.clk) disable iff (alsuif.rst)
        ( !ALSU.bypass_A_reg && !ALSU.bypass_B_reg && !ALSU.invalid && (ALSU.opcode_reg == 3'b000) && !ALSU.red_op_A_reg && !ALSU.red_op_B_reg) |=> 
           (alsuif.out == $past(ALSU.A_reg) | $past(ALSU.B_reg));
endproperty
assert property (check7) else $error("error in check7");
cover property (check7);

property check8;
    @(posedge alsuif.clk) disable iff (alsuif.rst)
        ( !ALSU.bypass_A_reg && !ALSU.bypass_B_reg && !ALSU.invalid && (ALSU.opcode_reg == 3'b001) && ALSU.red_op_A_reg && ALSU.red_op_B_reg) |=> 
           (alsuif.out == (( INPUT_PRIORITY == "A" ) ? ^$past(ALSU.A_reg) : ^$past(ALSU.B_reg)));
endproperty
assert property (check8) else $error("error in check8");
cover property (check8);

property check9;
    @(posedge alsuif.clk) disable iff (alsuif.rst)
        ( !ALSU.bypass_A_reg && !ALSU.bypass_B_reg && !ALSU.invalid && (ALSU.opcode_reg == 3'b001) && ALSU.red_op_A_reg && !ALSU.red_op_B_reg) |=> 
           (alsuif.out == ^$past(ALSU.A_reg));
endproperty
assert property (check9) else $error("error in check9");
cover property (check9);

property check10;
    @(posedge alsuif.clk) disable iff (alsuif.rst)
        ( !ALSU.bypass_A_reg && !ALSU.bypass_B_reg && !ALSU.invalid && (ALSU.opcode_reg == 3'b001) && !ALSU.red_op_A_reg && ALSU.red_op_B_reg) |=> 
           (alsuif.out == ^$past(ALSU.B_reg));
endproperty
assert property (check10) else $error("error in check10");
cover property (check10);

property check11;
    @(posedge alsuif.clk) disable iff (alsuif.rst)
        ( !ALSU.bypass_A_reg && !ALSU.bypass_B_reg && !ALSU.invalid && (ALSU.opcode_reg == 3'b001) && !ALSU.red_op_A_reg && !ALSU.red_op_B_reg) |=> 
           (alsuif.out == $past(ALSU.A_reg) ^ $past(ALSU.B_reg));
endproperty
assert property (check11) else $error("error in check11");
cover property (check11);

property check12;
    @(posedge alsuif.clk) disable iff (alsuif.rst)
        ( !ALSU.bypass_A_reg && !ALSU.bypass_B_reg && !ALSU.invalid && (ALSU.opcode_reg == 3'b010)) |=> 
           (alsuif.out == (( FULL_ADDER == "ON" ) ? $past(ALSU.A_reg)+$past(ALSU.B_reg)+$past(ALSU.cin_reg) : $past(ALSU.A_reg)+$past(ALSU.B_reg)));
endproperty
assert property (check12) else $error("error in check9");
cover property (check12);

property check13;
    @(posedge alsuif.clk) disable iff (alsuif.rst)
        ( !ALSU.bypass_A_reg && !ALSU.bypass_B_reg && !ALSU.invalid && (ALSU.opcode_reg == 3'b011)) |=> 
           (alsuif.out == $past(ALSU.A_reg) * $past(ALSU.B_reg));
endproperty
assert property (check13) else $error("error in check13");
cover property (check13);

property check14;
    @(posedge alsuif.clk) disable iff (alsuif.rst)
        ( !ALSU.bypass_A_reg && !ALSU.bypass_B_reg && !ALSU.invalid && (ALSU.opcode_reg == 3'b100) && ALSU.direction_reg) |=> 
           (alsuif.out == {$past(alsuif.out[4:0]), $past(ALSU.serial_in_reg)});
endproperty
assert property (check14) else $error("error in check14");
cover property (check14);

property check15;
    @(posedge alsuif.clk) disable iff (alsuif.rst)
        ( !ALSU.bypass_A_reg && !ALSU.bypass_B_reg && !ALSU.invalid && (ALSU.opcode_reg == 3'b100) && !ALSU.direction_reg) |=> 
           (alsuif.out == {$past(ALSU.serial_in_reg) , $past(alsuif.out[5:1])});
endproperty
assert property (check15) else $error("error in check15");
cover property (check15);

property check16;
    @(posedge alsuif.clk) disable iff (alsuif.rst)
        ( !ALSU.bypass_A_reg && !ALSU.bypass_B_reg && !ALSU.invalid && (ALSU.opcode_reg == 3'b101) && ALSU.direction_reg) |=> 
           (alsuif.out == {$past(alsuif.out[4:0]), $past(alsuif.out[5])});
endproperty
assert property (check16) else $error("error in check16");
cover property (check16);

property check17;
    @(posedge alsuif.clk) disable iff (alsuif.rst)
        ( !ALSU.bypass_A_reg && !ALSU.bypass_B_reg && !ALSU.invalid && (ALSU.opcode_reg == 3'b101) && !ALSU.direction_reg) |=> 
           (alsuif.out == {$past(alsuif.out[0]) , $past(alsuif.out[5:1])});
endproperty
assert property (check17) else $error("error in check17");
cover property (check17);
endmodule

