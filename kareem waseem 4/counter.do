vlib work
vlog counter.sv counter_pkg.sv counter_sva.sv counter_tb.sv counter_interface.sv counter_top.sv +cover -covercells
vsim -voptargs=+acc work.counter_top -cover
add wave *
coverage save counter_tb.ucdb -onexit 
run -all