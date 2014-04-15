onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix hexadecimal /project_tb/clk
add wave -noupdate -radix hexadecimal /project_tb/CPU/pc_curr
add wave -noupdate -radix hexadecimal /project_tb/CPU/inst_curr
add wave -noupdate -radix hexadecimal /project_tb/CPU/inst_curr_IDIF
add wave -noupdate -radix hexadecimal /project_tb/CPU/inst_curr_IDEX
add wave -noupdate -radix hexadecimal /project_tb/CPU/RF/raddr1
add wave -noupdate -radix hexadecimal /project_tb/CPU/RF/raddr2
add wave -noupdate -radix hexadecimal /project_tb/CPU/RF/waddr
add wave -noupdate -radix hexadecimal /project_tb/CPU/RF/wdata
add wave -noupdate -radix hexadecimal -childformat {{{/project_tb/CPU/RF/regdata[0]} -radix hexadecimal} {{/project_tb/CPU/RF/regdata[1]} -radix hexadecimal} {{/project_tb/CPU/RF/regdata[2]} -radix hexadecimal} {{/project_tb/CPU/RF/regdata[3]} -radix hexadecimal} {{/project_tb/CPU/RF/regdata[4]} -radix hexadecimal} {{/project_tb/CPU/RF/regdata[5]} -radix hexadecimal} {{/project_tb/CPU/RF/regdata[6]} -radix hexadecimal} {{/project_tb/CPU/RF/regdata[7]} -radix hexadecimal} {{/project_tb/CPU/RF/regdata[8]} -radix hexadecimal} {{/project_tb/CPU/RF/regdata[9]} -radix hexadecimal} {{/project_tb/CPU/RF/regdata[10]} -radix hexadecimal} {{/project_tb/CPU/RF/regdata[11]} -radix hexadecimal} {{/project_tb/CPU/RF/regdata[12]} -radix hexadecimal} {{/project_tb/CPU/RF/regdata[13]} -radix hexadecimal} {{/project_tb/CPU/RF/regdata[14]} -radix hexadecimal} {{/project_tb/CPU/RF/regdata[15]} -radix hexadecimal}} -expand -subitemconfig {{/project_tb/CPU/RF/regdata[0]} {-height 15 -radix hexadecimal} {/project_tb/CPU/RF/regdata[1]} {-height 15 -radix hexadecimal} {/project_tb/CPU/RF/regdata[2]} {-height 15 -radix hexadecimal} {/project_tb/CPU/RF/regdata[3]} {-height 15 -radix hexadecimal} {/project_tb/CPU/RF/regdata[4]} {-height 15 -radix hexadecimal} {/project_tb/CPU/RF/regdata[5]} {-height 15 -radix hexadecimal} {/project_tb/CPU/RF/regdata[6]} {-height 15 -radix hexadecimal} {/project_tb/CPU/RF/regdata[7]} {-height 15 -radix hexadecimal} {/project_tb/CPU/RF/regdata[8]} {-height 15 -radix hexadecimal} {/project_tb/CPU/RF/regdata[9]} {-height 15 -radix hexadecimal} {/project_tb/CPU/RF/regdata[10]} {-height 15 -radix hexadecimal} {/project_tb/CPU/RF/regdata[11]} {-height 15 -radix hexadecimal} {/project_tb/CPU/RF/regdata[12]} {-height 15 -radix hexadecimal} {/project_tb/CPU/RF/regdata[13]} {-height 15 -radix hexadecimal} {/project_tb/CPU/RF/regdata[14]} {-height 15 -radix hexadecimal} {/project_tb/CPU/RF/regdata[15]} {-height 15 -radix hexadecimal}} /project_tb/CPU/RF/regdata
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
add wave -noupdate -radix hexadecimal {/project_tb/CPU/DMem/memory[0]}
add wave -noupdate -radix hexadecimal {/project_tb/CPU/DMem/memory[1]}
add wave -noupdate -radix hexadecimal {/project_tb/CPU/DMem/memory[2]}
add wave -noupdate -radix hexadecimal {/project_tb/CPU/DMem/memory[3]}
add wave -noupdate -radix hexadecimal {/project_tb/CPU/DMem/memory[4]}
add wave -noupdate -radix hexadecimal {/project_tb/CPU/DMem/memory[5]}
add wave -noupdate -radix hexadecimal {/project_tb/CPU/DMem/memory[6]}
add wave -noupdate -radix hexadecimal {/project_tb/CPU/DMem/memory[7]}
add wave -noupdate -radix hexadecimal /project_tb/CPU/forward_a_alu/in0
add wave -noupdate -radix hexadecimal /project_tb/CPU/forward_a_alu/in1
add wave -noupdate -radix hexadecimal /project_tb/CPU/forward_a_alu/in2
add wave -noupdate -radix hexadecimal /project_tb/CPU/forward_a_alu/select
add wave -noupdate -radix hexadecimal /project_tb/CPU/forward_a_alu/out
add wave -noupdate -radix hexadecimal /project_tb/CPU/forward_b_alu/in0
add wave -noupdate -radix hexadecimal /project_tb/CPU/forward_b_alu/in1
add wave -noupdate -radix hexadecimal /project_tb/CPU/forward_b_alu/in2
add wave -noupdate -radix hexadecimal /project_tb/CPU/forward_b_alu/select
add wave -noupdate -radix hexadecimal /project_tb/CPU/forward_b_alu/out
add wave -noupdate -radix hexadecimal /project_tb/CPU/S6/in0
add wave -noupdate -radix hexadecimal /project_tb/CPU/S6/in1
add wave -noupdate -radix hexadecimal /project_tb/CPU/S6/select
add wave -noupdate -radix hexadecimal /project_tb/CPU/S6/out
add wave -noupdate -radix hexadecimal /project_tb/CPU/S5/in0
add wave -noupdate -radix hexadecimal /project_tb/CPU/S5/in1
add wave -noupdate -radix hexadecimal /project_tb/CPU/S5/select
add wave -noupdate -radix hexadecimal /project_tb/CPU/S5/out
add wave -noupdate -radix hexadecimal /project_tb/CPU/S1/in0
add wave -noupdate -radix hexadecimal /project_tb/CPU/S1/in1
add wave -noupdate -radix hexadecimal /project_tb/CPU/S1/select
add wave -noupdate -radix hexadecimal /project_tb/CPU/S1/out
add wave -noupdate -radix hexadecimal /project_tb/CPU/EX_MEM/aluout_exmem
add wave -noupdate -radix hexadecimal /project_tb/CPU/pcORwdataMUX/out
add wave -noupdate -radix hexadecimal /project_tb/CPU/f_unit1/rf_waddr_exmem
add wave -noupdate -radix hexadecimal /project_tb/CPU/f_unit1/rf_waddr_memwb
add wave -noupdate -radix hexadecimal /project_tb/CPU/f_unit1/inst_curr_IDEX_7_4_rs
add wave -noupdate -radix hexadecimal /project_tb/CPU/f_unit1/inst_curr_IDEX_3_0_rt
add wave -noupdate -radix hexadecimal /project_tb/CPU/f_unit1/inst_curr_IDEX_11_8_rd
add wave -noupdate -radix hexadecimal /project_tb/CPU/f_unit1/rf_wen_exmem
add wave -noupdate -radix hexadecimal /project_tb/CPU/f_unit1/rf_wen_memwb
add wave -noupdate -radix hexadecimal /project_tb/CPU/f_unit1/mem2reg_memwb
add wave -noupdate -radix hexadecimal /project_tb/CPU/f_unit1/mem2reg_exmem
add wave -noupdate -radix hexadecimal /project_tb/CPU/f_unit1/dmem_wen_idex
add wave -noupdate -radix hexadecimal /project_tb/CPU/f_unit1/forwardA
add wave -noupdate -radix hexadecimal /project_tb/CPU/f_unit1/forwardB
add wave -noupdate -radix hexadecimal /project_tb/CPU/f_unit1/rdata2_sw_fcontrol
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {155 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 273
configure wave -valuecolwidth 50
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
WaveRestoreZoom {81 ps} {194 ps}
