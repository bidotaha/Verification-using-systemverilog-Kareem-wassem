////////////////////////////////////////////////////////////////////////////////
// Author: Kareem Waseem
// Course: Digital Verification using SV & UVM
//
// Description: Vending machine example
// 
////////////////////////////////////////////////////////////////////////////////
module vending_machine_top();
// 1. Generate the clock
// 2. instantiate the interface, and pass the clock
// 3. instantiate the tb, DUT, monitor, and pass the interface
// 4. bind the SVA module to the design, and pass the interface
bit clock;

initial begin
    forever begin
        #10 clock = ~clock;
    end
end
vending_machine_if v_if (clock);
vending_machine_tb tb (v_if);
vending_machine dut (v_if);
vending_machine_monitor mon (v_if);
bind vending_machine vending_machine_sva vending_machine_sva_inst (v_if);


endmodule
