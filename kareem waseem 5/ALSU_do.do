vlib work
vlog -f ALSU_files.list 
vsim -voptargs=+acc work.ALSU_top -classdebug -uvmcontrol=all
add wave /ALSU_top/alsuif/*
run -all