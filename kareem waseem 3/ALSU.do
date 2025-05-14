vlib work
vlog ALSU.v ALSU_golden_model.v ALSU_tb.sv ALSU_pkg.sv +cover -covercells
vsim -voptargs=+acc ALSU_tb -cover
add wave *
coverage save ALSU_tb.ucdb -onexit 
run -all