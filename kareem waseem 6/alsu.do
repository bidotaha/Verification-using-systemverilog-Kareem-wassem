vlib work
vlog -f alsu_files.list 
vsim -voptargs=+acc work.alsu_top -classdebug -uvmcontrol=all
add wave /alsu_top/alsuif/*
run -all