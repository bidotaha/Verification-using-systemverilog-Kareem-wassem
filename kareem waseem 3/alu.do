vlib work
vlog alu.sv alu_pkg.sv alu_tb.sv +cover -covercells
vsim -voptargs=+acc work.alu_tb -cover 
add wave * 
coverage save alu_tb.ucdb -onexit 
run -all