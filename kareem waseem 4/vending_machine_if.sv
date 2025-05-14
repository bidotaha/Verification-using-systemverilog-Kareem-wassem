////////////////////////////////////////////////////////////////////////////////
// Author: Kareem Waseem
// Course: Digital Verification using SV & UVM
//
// Description: Vending machine example
// 
////////////////////////////////////////////////////////////////////////////////
interface vending_machine_if(clock);
// 1. Add the parameters (WAIT = 0, Q_25 = 1, Q_50 =2)
// 2. Add the clock as an input port
// 3. Add the internal signals of the interface
// 4. Add the modports
parameter WAIT = 2'b00 , Q_25 = 2'b01 , Q_50 = 2'b10 ;
input clock;
logic D_in , Q_in , Dispense ,Change;
logic rstn;

modport TEST (
output D_in,Q_in,rstn, 
input clock,Dispense,Change);

modport DUT (
input clock, D_in,Q_in,rstn, 
output Dispense , Change);

modport MONITOR ( 
input rstn,clock,D_in,Q_in,Dispense,Change);

endinterface 