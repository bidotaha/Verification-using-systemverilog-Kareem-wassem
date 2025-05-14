vlib work
vlog ALSU.v ALSU.sv ALSU_pkg.sv  +cover -covercells
vsim -voptargs=+acc work.ALU -cover
add wave *
coverage save ALU.ucdb -onexit 
run -all