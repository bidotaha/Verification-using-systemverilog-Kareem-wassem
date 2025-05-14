vlib work
vlog ALSU_if.sv ALSU_pkg.sv ALSU_sva.sv ALSU.sv ALSU_golden_model.sv ALSU_tb.sv ALSU_top.sv +cover -covercells
vsim -voptargs=+acc ALSU_top -cover
add wave *
coverage save ALSU_tb.ucdb -onexit 
run -all