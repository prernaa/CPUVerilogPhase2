onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix hexadecimal /project_tb/clk
add wave -noupdate -radix hexadecimal /project_tb/rst
add wave -noupdate -radix hexadecimal /project_tb/CPU/pc_curr
add wave -noupdate -radix hexadecimal /project_tb/CPU/inst_curr
add wave -noupdate -radix hexadecimal /project_tb/CPU/inst_curr_IDIF
add wave -noupdate -radix hexadecimal /project_tb/CPU/inst_curr_IDEX
add wave -noupdate -radix hexadecimal /project_tb/CPU/nop_alu
add wave -noupdate -radix hexadecimal /project_tb/CPU/control_EXE/flag
add wave -noupdate -radix hexadecimal /project_tb/CPU/branch_target_exmem
add wave -noupdate /project_tb/CPU/control_EXE/putPCback
add wave -noupdate -radix hexadecimal {/project_tb/CPU/RF/regdata[15]}
add wave -noupdate -radix hexadecimal /project_tb/CPU/RF/raddr1
add wave -noupdate -radix hexadecimal /project_tb/CPU/RF/raddr2
add wave -noupdate -radix hexadecimal /project_tb/CPU/RF/waddr
add wave -noupdate -radix hexadecimal /project_tb/CPU/RF/wdata
add wave -noupdate -radix hexadecimal /project_tb/CPU/RF/wen
add wave -noupdate -radix hexadecimal /project_tb/CPU/RF/rdata1
add wave -noupdate -radix hexadecimal /project_tb/CPU/RF/rdata2
add wave -noupdate -radix hexadecimal /project_tb/CPU/extended
add wave -noupdate -radix hexadecimal /project_tb/CPU/ALU/op
add wave -noupdate -radix hexadecimal /project_tb/CPU/ALU/a
add wave -noupdate -radix hexadecimal /project_tb/CPU/ALU/b
add wave -noupdate -radix hexadecimal /project_tb/CPU/ALU/imm
add wave -noupdate -radix hexadecimal /project_tb/CPU/ALU/out
add wave -noupdate -radix hexadecimal /project_tb/CPU/DMem/addr
add wave -noupdate -radix hexadecimal /project_tb/CPU/DMem/data_out
add wave -noupdate -radix hexadecimal /project_tb/CPU/DMem/wen
add wave -noupdate -radix hexadecimal /project_tb/CPU/DMem/data_in
add wave -noupdate -radix hexadecimal /project_tb/CPU/MEM_WB/rf_waddr_memwb
add wave -noupdate -radix hexadecimal {/project_tb/CPU/RF/regdata[15]}
add wave -noupdate -radix hexadecimal {/project_tb/CPU/RF/regdata[0]}
add wave -noupdate -radix hexadecimal {/project_tb/CPU/RF/regdata[1]}
add wave -noupdate -radix hexadecimal {/project_tb/CPU/RF/regdata[2]}
add wave -noupdate -radix hexadecimal {/project_tb/CPU/RF/regdata[3]}
add wave -noupdate -radix hexadecimal {/project_tb/CPU/RF/regdata[4]}
add wave -noupdate -radix hexadecimal {/project_tb/CPU/DMem/memory[0]}
add wave -noupdate -radix hexadecimal {/project_tb/CPU/DMem/memory[1]}
add wave -noupdate -radix hexadecimal {/project_tb/CPU/DMem/memory[2]}
add wave -noupdate -radix hexadecimal {/project_tb/CPU/DMem/memory[3]}
add wave -noupdate -radix hexadecimal {/project_tb/CPU/DMem/memory[4]}
add wave -noupdate -radix hexadecimal {/project_tb/CPU/DMem/memory[5]}
add wave -noupdate -radix hexadecimal {/project_tb/CPU/DMem/memory[6]}
add wave -noupdate -radix hexadecimal {/project_tb/CPU/DMem/memory[7]}
add wave -noupdate /project_tb/CPU/control_EXE/execPCadded
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {205 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 273
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
WaveRestoreZoom {115 ps} {215 ps}
