vlib work
vlog priority_enc.v priority_sva.sv priority_enc_tb.sv +cover -covercells
vsim -voptargs=+acc work.priority_enc_tb -cover 
add wave * 
coverage save priority_enc_tb.ucdb -onexit 
run -all