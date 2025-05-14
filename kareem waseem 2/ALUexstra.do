vlib work
vlog ALU.v ALU_tb.sv  alu_pkg.sv +cover -covercells
vsim -voptargs=+acc work.ALU_tb -cover 
add wave * 
coverage save ALU_tb.ucdb -onexit 
run -all