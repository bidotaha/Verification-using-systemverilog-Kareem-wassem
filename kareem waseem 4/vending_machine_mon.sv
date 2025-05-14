////////////////////////////////////////////////////////////////////////////////
// Author: Kareem Waseem
// Course: Digital Verification using SV & UVM
//
// Description: Vending machine example
// 
////////////////////////////////////////////////////////////////////////////////
module vending_machine_monitor(vending_machine_if.MONITOR v_if);
// 1. Add the modport above
// 2. Add the monitor statement in an initial block
initial begin
    $monitor ("clock=%b rst=%b D_in=%b Q_in=%b Dispense=%b Change=%b",v_if.clock,v_if.rstn,v_if.D_in,v_if.Q_in,v_if.Dispense,v_if.Change);
end

endmodule