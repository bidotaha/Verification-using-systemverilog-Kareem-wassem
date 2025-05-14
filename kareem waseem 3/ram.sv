module my_mem(
input clk,
input write,
input read,
input [7:0] data_in,
input [15:0] address,
output reg [7:0] data_out
);
 // Declare a 9-bit associative array using the logic data type & the key of int datatype
 reg [7:0] mem_array [0:65535];
 always @(posedge clk) begin
 if (write)
 mem_array[address] <= {~^data_in, data_in};
 else if (read)
 data_out <= mem_array[address];
 end
endmodule