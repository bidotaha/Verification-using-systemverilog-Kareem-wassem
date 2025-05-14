////////////////////////////////////////////////////////////////////////////////
// Author: Kareem Waseem
// Course: Digital Verification using SV & UVM
//
// Description: Counter Design 
// 
////////////////////////////////////////////////////////////////////////////////
import counter_pkg ::*;
module counter (counter_if.DUT count_in);

always @(posedge count_in.clk or negedge count_in.rst_n) begin
    if (!count_in.rst_n)
        count_in.count_out <= 0; 
    else if (!count_in.load_n)
        count_in.count_out <= count_in.data_load;
    else if (count_in.ce)
        if (count_in.up_down)
            count_in.count_out <= count_in.count_out + 1;
        else 
            count_in.count_out <= count_in.count_out - 1;
end

always @(*)begin
    count_in.max_count = (count_in.count_out == {WIDTH{1'b1}}) ? 1 : 0;
    count_in.zero = (count_in.count_out == 0) ? 1 : 0;
end


endmodule