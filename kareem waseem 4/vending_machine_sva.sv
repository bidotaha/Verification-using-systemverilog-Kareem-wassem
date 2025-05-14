////////////////////////////////////////////////////////////////////////////////
// Author: Kareem Waseem
// Course: Digital Verification using SV & UVM
//
// Description: Vending machine example
// 
////////////////////////////////////////////////////////////////////////////////
module vending_machine_sva(vending_machine_if.DUT v_if);
// 1. Add the modport above
// 2. Add the following 3 properties, then use assert property and cover property on each property
//// First Assertion: At each positive edge of the clock, if the D_in is high then at the same clock cycle, the dispense and the change outputs are high
//// Second Assertion: At each positive edge of the clock, If there is a rising edge for the input Q_in then after 2 clock cycles the dispense output is high
//// Third Assertion: At each positive edge of the clock, if the Q_in is high then at the same clock cycle, the change must be low

property p1 ;
     @(posedge v_if.clock) v_if.D_in |-> (v_if.Dispense && v_if.Change) ; 
endproperty

 dollar_assertion : assert property (p1);
 dollar_cover : cover property (p1);  

property p2 ;
     @(posedge v_if.clock) $rose(v_if.Q_in) |-> ##2 v_if.Dispense;
    endproperty

 quarter_assertion1 : assert property (p2);
 quarter_cover1 : cover property (p2);      

property p3 ;
    @(posedge v_if.clock) (v_if.Q_in |-> !(v_if.Change)) ;  
    endproperty

 quarter_assertion2 : assert property (p3);
 quarter_cover2 : cover property (p3);  

/*
property p4;
   @(posedge clock) $rose(signal_a) |=> $fell (signal_b) [->1];
endproperty

property p5;
   @(posedge clock) valid |=> (we_ack throughtout done [->1]); 
endproperty

property p4;
   @(posedge clock) $rose(reg) |=> ack[->1] ##1 ~ack; 
endproperty
*/
endmodule