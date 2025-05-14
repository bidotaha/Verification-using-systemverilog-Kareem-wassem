vlib work
vlog FSM_010.v fsm_pkg.sv  fsm_tb.sv +cover -covercells
vsim -voptargs=+acc work.fsm_tb -cover 
add wave * 
coverage save fsm_tb.ucdb -onexit 
run -all