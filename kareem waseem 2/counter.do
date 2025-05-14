vlib work
vlog counter.v counter_tb.sv counter_pkg.sv  +cover -covercells
vsim -voptargs=+acc work.counter_tb -cover
add wave *
coverage save counter_tb.ucdb -onexit 
run -all