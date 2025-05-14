
module ALSU_golden_model ( alsu_if.GOLDEN_MODEL alsuif);
   parameter INPUT_PRIORITY = "A";
   parameter FULL_ADDER = "ON";

reg red_op_A_reg, red_op_B_reg, bypass_A_reg, bypass_B_reg, direction_reg, serial_in_reg;
reg [1:0] cin_reg;
reg [2:0] opcode_reg;
reg signed [2:0] A_reg, B_reg;

wire invalid_red_op, invalid_opcode, invalid;

assign invalid_red_op = (red_op_A_reg | red_op_B_reg) & (opcode_reg[1] | opcode_reg[2]);
assign invalid_opcode = opcode_reg[1] & opcode_reg[2];
assign invalid = invalid_red_op | invalid_opcode;

always @(posedge alsuif.clk or posedge alsuif.rst) begin
  if(alsuif.rst) begin
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
     cin_reg <= alsuif.cin;
     red_op_B_reg <= alsuif.red_op_B;
     red_op_A_reg <= alsuif.red_op_A;
     bypass_B_reg <= alsuif.bypass_B;
     bypass_A_reg <= alsuif.bypass_A;
     direction_reg <= alsuif.direction;
     serial_in_reg <= alsuif.serial_in;
     opcode_reg <= alsuif.opcode;
     A_reg <= alsuif.A;
     B_reg <= alsuif.B;
  end
end

always @(posedge alsuif.clk or posedge alsuif.rst) begin
  if(alsuif.rst) begin
     alsuif.leds_ex <= 0;
  end else begin
      if (invalid)
        alsuif.leds_ex <= ~alsuif.leds_ex;
      else
        alsuif.leds_ex <= 0;
  end
end

    always @(posedge alsuif.clk , posedge alsuif.rst) begin
        if (alsuif.rst) begin
           alsuif.out_ex <= 0;
        end
        else begin
    if (bypass_A_reg && bypass_B_reg)
      alsuif.out_ex <= (INPUT_PRIORITY == "A")? A_reg: B_reg;
    else if (bypass_A_reg)
      alsuif.out_ex <= A_reg;
    else if (bypass_B_reg)
      alsuif.out_ex <= B_reg;
    else if (invalid) 
        alsuif.out_ex <= 0;             
            else begin
                   
            case (opcode_reg)
                3'b000 : begin
            if (red_op_A_reg && red_op_B_reg)
              alsuif.out_ex <= (INPUT_PRIORITY == "A")? |A_reg: |B_reg;
            else if (red_op_A_reg) 
              alsuif.out_ex <= |A_reg;
            else if (red_op_B_reg)
              alsuif.out_ex <= |B_reg;
            else 
              alsuif.out_ex <= A_reg | B_reg;
                end
                3'b001 : begin
            if (red_op_A_reg && red_op_B_reg)
              alsuif.out_ex <= (INPUT_PRIORITY == "A")? ^A_reg: ^B_reg;
            else if (red_op_A_reg) 
              alsuif.out_ex <= ^A_reg;
            else if (red_op_B_reg)
              alsuif.out_ex <= ^B_reg;
            else 
              alsuif.out_ex <= A_reg ^ B_reg;
          end
                3'b010 : begin
                         if (FULL_ADDER == "ON")
                            alsuif.out_ex <= A_reg + B_reg + cin_reg;
                         else 
                            alsuif.out_ex <= A_reg + B_reg;   
                end 
                3'b011 : alsuif.out_ex <= A_reg * B_reg; 
                3'b100 : begin
                         if (direction_reg)
                            alsuif.out_ex <= {alsuif.out_ex[4:0],serial_in_reg};
                         else 
                         alsuif.out_ex <= {serial_in_reg,alsuif.out_ex[5:1]};
                end
                3'b101 : begin
                         if (direction_reg)
                            alsuif.out_ex <= {alsuif.out_ex[4:0],alsuif.out_ex[5]};
                         else 
                         alsuif.out_ex <= {alsuif.out_ex[0],alsuif.out_ex[5:1]};
                end  
            endcase
            end
        end    
     end              
    
endmodule
