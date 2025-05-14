module ALSU_golden_model #( parameter INPUT_PRIORITY = "A",
               parameter FULL_ADDER = "ON")
             ( output reg [5:0] out,
               output reg [15:0] leds,
               input [2:0] A,B,opcode,
               input clk,rst,cin,serial_in,red_op_A,red_op_B,bypass_A,bypass_B,direction);

reg red_op_A_reg, red_op_B_reg, bypass_A_reg, bypass_B_reg, direction_reg, serial_in_reg;
reg signed cin_reg;
reg [2:0] opcode_reg;
reg signed [2:0] A_reg, B_reg;

wire invalid_red_op, invalid_opcode, invalid;

assign invalid_red_op = (red_op_A_reg | red_op_B_reg) & (opcode_reg[1] | opcode_reg[2]);
assign invalid_opcode = opcode_reg[1] & opcode_reg[2];
assign invalid = invalid_red_op | invalid_opcode;

always @(posedge clk or posedge rst) begin
  if(rst) begin
     cin_reg <= 0;
     red_op_B_reg <= 0;
     red_op_A_reg <= 0;
     bypass_B_reg <= 0;
     bypass_A_reg <= 0;
     direction_reg <= 0;
     serial_in_reg <= 0;
     opcode_reg <= 0;
     A_reg <= 0;
     B_reg <= 0;
  end else begin
     cin_reg <= cin;
     red_op_B_reg <= red_op_B;
     red_op_A_reg <= red_op_A;
     bypass_B_reg <= bypass_B;
     bypass_A_reg <= bypass_A;
     direction_reg <= direction;
     serial_in_reg <= serial_in;
     opcode_reg <= opcode;
     A_reg <= A;
     B_reg <= B;
  end
end

always @(posedge clk or posedge rst) begin
  if(rst) begin
     leds <= 0;
  end else begin
      if (invalid)
        leds <= ~leds;
      else
        leds <= 0;
  end
end

    always @(posedge clk , posedge rst) begin
        if (rst) begin
           out <= 0;
        end
        else begin
    if (bypass_A_reg && bypass_B_reg)
      out <= (INPUT_PRIORITY == "A")? A_reg: B_reg;
    else if (bypass_A_reg)
      out <= A_reg;
    else if (bypass_B_reg)
      out <= B_reg;
    else if (invalid) 
        out <= 0;              
            else begin
                   
            case (opcode)
                3'b000 : begin
                if (INPUT_PRIORITY == "A") begin                   
                         if (red_op_A_reg)
                            out <= |A_reg;
                         else 
                            out <= A_reg|B_reg;   
                end
                else if (INPUT_PRIORITY == "B") begin
                         if (red_op_B_reg)
                            out <= |B_reg;
                         else 
                            out <= A_reg|B_reg; 
                end          
                end
                3'b001 : begin
            if (red_op_A_reg && red_op_B_reg)
              out <= (INPUT_PRIORITY == "A")? ^A_reg: ^B_reg;
            else if (red_op_A_reg) 
              out <= ^A_reg;
            else if (red_op_B_reg)
              out <= ^B_reg;
            else 
              out <= A_reg ^ B_reg;
          end
                3'b010 : begin
                         if (FULL_ADDER == "ON")
                            out <= A_reg + B_reg + cin_reg;
                         else if (FULL_ADDER == "OFF")
                            out <= A_reg + B_reg;   
                end 
                3'b011 : out <= A_reg * B_reg; 
                3'b100 : begin
                         if (direction_reg)
                            out <= {out[4:0],serial_in_reg};
                         else 
                         out <= {serial_in_reg,out[5:1]};
                end
                3'b101 : begin
                         if (direction_reg)
                            out <= {out[4:0],out[5]};
                         else 
                         out <= {out[0],out[5:1]};
                end  
            endcase
            end
        end    
     end              
    
endmodule
