vlib work
vlog adder.v adder_tb.sv adder_pkg.sv +cover -covercells
vsim -voptargs=+acc work.adder_tb -cover 
add wave * 
coverage save adder_tb.ucdb -onexit 
run -all