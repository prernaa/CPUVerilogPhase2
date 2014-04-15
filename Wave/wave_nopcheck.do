onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /project_tb/clk
add wave -noupdate -radix hexadecimal /project_tb/CPU/inst_curr
add wave -noupdate -radix hexadecimal {/project_tb/CPU/RF/regdata[0]}
add wave -noupdate -radix hexadecimal {/project_tb/CPU/RF/regdata[1]}
add wave -noupdate -radix hexadecimal {/project_tb/CPU/RF/regdata[2]}
add wave -noupdate -radix hexadecimal {/project_tb/CPU/RF/regdata[3]}
add wave -noupdate -radix hexadecimal {/project_tb/CPU/RF/regdata[4]}
add wave -noupdate -radix hexadecimal {/project_tb/CPU/RF/regdata[5]}
add wave -noupdate -radix hexadecimal {/project_tb/CPU/RF/regdata[6]}
add wave -noupdate -radix hexadecimal {/project_tb/CPU/RF/regdata[7]}
add wave -noupdate -radix hexadecimal {/project_tb/CPU/RF/regdata[8]}
add wave -noupdate -radix hexadecimal {/project_tb/CPU/RF/regdata[9]}
add wave -noupdate /project_tb/CPU/ALU/nop
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {294 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 196
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
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
WaveRestoreZoom {116 ps} {341 ps}
