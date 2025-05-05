onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /half_adder_testbench/out
add wave -noupdate /half_adder_testbench/carry_out
add wave -noupdate /half_adder_testbench/a
add wave -noupdate /half_adder_testbench/b
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {202 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ps} {1 ns}
