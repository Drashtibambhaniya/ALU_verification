vlib work

vlib work
vlog -sv pkg.sv
vlog -sv alu_packet.sv
vlog -sv alu_txn.sv
vlog -sv alu_interface.sv
vlog -sv alu_driver.sv
vlog -sv alu_generator.sv
vlog -sv alu_monitor_ip.sv
vlog -sv alu_monitor_op.sv
vlog -sv alu_ref.sv
vlog -sv alu_cov.sv
vlog -sv alu_scoreboard.sv
vlog -sv alu_base_test.sv 
vlog -sv alu_test.sv
vlog -sv +cover alu.sv 
vlog -sv alu_top.sv

vsim -coverage -novopt -cover work.alu_top
add wave -r /*
run -all
coverage save coverage.ucdb

vcover report -detail -code bcefst coverage.ucdb -output cov_report.txt

