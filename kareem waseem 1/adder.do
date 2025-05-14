vlib work
vlog adder.v adder_ts.sv +cover -covercells
vsim -voptargs=+acc work.adder_ts -cover 
add wave * 
coverage save adder_ts.ucdb -onexit 
run -all