`include "define.v"

module phase1_top(
    input clk,
    input rst
);

//here, you should instantiate and connect your PC, ALU, control, imemory, dmemory
//depending on your group organization, you may use more or fewer sub-modules, but 
//you may not make *any* modifications to the given modules. During the demo, you
//may be asked to download fresh copies of the given files to verify that you did
//not make changes to those files in order to get your design working.

//IF
wire [15:0] pc_in_imem;

wire [15:0] pc_curr;
wire [15:0] pc_added;
wire [15:0] inst_curr;

//ID
wire [15:0] pc_added_IDIF;
wire [15:0] inst_curr_IDIF;
wire [3:0] inst_raddr1;
wire lhb_llb_regcon;
wire [15:0] mem_data_in;
wire [15:0] mem_data_out;
wire [15:0] alu_out_mem;
//ID control signals
wire[3:0] opcode;
wire dmem_wen;
wire rf_wen;
wire [2:0] alu_op;
wire alusrc;
wire regdest;
wire branch;
wire mem2reg;
//wire lhb_llb_1;
//wire lhb_llb_2;


wire dmem_wen_idex;
wire rf_wen_idex;
wire [2:0] alu_op_idex;
wire alusrc_idex;
wire regdest_idex;
//wire branch_idex;
wire mem2reg_idex;
//wire jr_adder_idex;
wire [15:0] rdata1_idex;
wire [15:0] rdata2_idex;
wire [15:0] extended_idex;
wire [15:0] pc_added_IDEX;
wire [15:0] pc_adder_out;
wire [15:0] inst_curr_IDEX;
wire control_lhb_llb_idex;

wire [15:0] rf_wdata;
wire [3:0] rf_waddr;
wire [15:0] rdata1, rdata2;
wire [15:0] extended;
wire [15:0] extended_1;
//wire [15:0] extended_JR;
wire [15:0] alu_second_input;
wire [15:0] signextended;

wire dmem_wen_exmem;
wire rf_wen_exmem;
//wire mem_branch_exmem;
wire mem2reg_exmem;
wire jr_adder_exmem;
wire [15:0] pc_adder_out_exmem;
wire [15:0] aluout_exmem;
wire [2:0] flag_exmem;
wire [15:0] rdata1_exmem;
wire [15:0] rdata2_exmem;
wire [3:0] rf_waddr_exmem;
wire [15:0] wdata_LHB_LLB;
//wire jr_rf;
//wire jr_adder;
wire [15:0] lhb_llb_out_exmem;
wire control_lhb_llb_exmem;

wire rf_wen_memwb;
wire mem2reg_memwb;
wire [3:0] rf_waddr_memwb;
wire [15:0] aluout_memwb;
wire [15:0] lhb_llb_out_data;
wire lhb_llb_control_memwb;

wire [15:0] rf_data_final;
wire [15:0] imm_final;

///EXE
wire [2:0] flag; //Z,V,N
//reg [2:0] flag_previous;
wire [15:0] aluout;

wire[15:0] extended_JAL;
wire[15:0] JAL_target_add_IDIF;
wire[15:0] JAL_target_add_IDEX;
wire[15:0] JAL_target_add_exmem;
wire JAL_control_jump_idex;
wire JAL_control_jump_exmem;
wire JAL_control_mux_final;
wire JAL_write_reg;

wire [15:0] pc_normal_added_out;
wire [15:0] lhb_llb_regval;
/// assigning opcode
assign opcode = inst_curr_IDIF[15:12];

wire [3:0] inst_raddr2;
wire [15:0] pc_in_mux_out, pc_in_mux_in, pc_in_mux_in_latest;
wire pcsrc;

wire s5;
//s7 is used for the final mux between mem/alu vs LLB
wire s6,s7;
wire [15:0] rf_wdata_bef_mux;

wire [15:0] aluout_or_lhbllb_memwb;

MUX16 mem2regMUX(.in0(aluout_memwb), .in1(mem_data_out), 
.select(mem2reg_memwb), .out(rf_wdata_bef_mux));

//this is the last mux which compares the value of((ALU/Mem)vs LLB imm) and sends it to the regiter
wire s7_memwb;
wire [15:0] imm_16_0_memwb;
wire s7_exmem;
wire [15:0] pc_mux_out;
//wire [15:0] pc_added_idif;
//wire [15:0] pc_added_idex;
wire [15:0] pc_added_exmem;
wire [15:0] pc_added_memwb;

wire [15:0] branch_target_idex, branch_target_exmem;
/// Passing flag from ALU to Control
wire [2:0] flag_aluout;
wire [2:0] flag_controlexein;
wire [3:0] cond_IDIF;
assign flag_controlexein = flag_aluout;
assign cond_IDIF = inst_curr_IDIF[11:8];

wire nop_lw_idex, nop_sw_idex;
wire nop_lw_exmem, nop_sw_exmem;
wire nop_lw_memwb;

wire jal, jal_idex, jal_exmem, jal_memwb;
wire jr, jr_idex;
wire exec, exec_idex;

wire [15:0] branch_target_final;

//to decide what we are going to write to reg, ALU/MEM or LLB
MUX16 S7( .in0(rf_wdata_bef_mux), .in1(imm_16_0_memwb), 
.select(s7_memwb), .out(rf_wdata));

//To decide what our destination address is going to be - mostly it will be [11:18]
MUX4 regdestMUX(.in0(inst_curr_IDEX[3:0]), .in1(inst_curr_IDEX[11:8]), 
.select(regdest_idex), .out(rf_waddr));

/// Memory instantiation
//mem_data_in is empty
/*memory IMem (.clk(clk), .rst(rst), .wen(1'b1), .addr(pc_curr), 
.data_in(mem_data_in), .fileid(4'd2), .data_out(inst_curr));*/
wire branch2_exmem;
assign pc_in_imem = (branch2_exmem === 1'b1) ? branch_target_exmem : pc_added;

memory IMem (.clk(clk), .rst(rst), .wen(1'b1), .addr(pc_in_imem), 
.data_in(mem_data_in), .fileid(4'd1), .data_out(inst_curr));

// NOP store statement
wire dmem_wen_exmem_muxout;
// DONT USE MUX COZ 1 BIT - MUX4 dmemNOPMux(.in0(dmem_wen_exmem), .in1(), .select(nop_sw_exmem), .out(dmem_wen_exmem_muxout));
assign dmem_wen_exmem_muxout = (nop_sw_exmem===1'b1)?1'b1:dmem_wen_exmem;
memory DMem (.clk(clk), .rst(rst), .wen(dmem_wen_exmem_muxout), .addr(aluout_exmem), 
.data_in(rdata2_exmem), .fileid(4'd9), .data_out(mem_data_out));

/// IF Stage instantiation
wire pc_stall_wire, ifid_stall_wire, pc_stall_out, ifid_stall_out, idex_stall_wire, idex_stall_out, inst_stall_wire, inst_stall_out;
assign pc_stall_wire = pc_stall_out;
assign ifid_stall_wire = ifid_stall_out;
assign idex_stall_wire = idex_stall_out;
assign inst_stall_wire = inst_stall_out;
pc PC(.in(pc_mux_out), .out(pc_curr), .clk(clk), .rst(rst), .stall(pc_stall_wire));
addPC incPC(.in(pc_curr), .out(pc_added), .stall(inst_stall_wire));

//S9 is used to decide whether (PC = PC+1) or (PC = branch target+pC+1)
//THIS IS THE FIRST PCMUX
//branch target is PC+1+branch_offset and 
//branch_2_exmem is control generated from control_exe


MUX16 S9 (.in0(pc_added), .in1(branch_target_exmem), 
.select(branch2_exmem), .out(pc_mux_out)); 

wire [15:0] imm_16_0_idex;
wire [7:0] imm_7_0_idex;
wire [15:0] imm_12_to_16_idif;
wire [15:0] imm_12_to_16_idex;

//needed for the usual 4 bit extension to 16 bits for immediate
sign_ext_4_16 signext4_16( .imm_4(inst_curr_IDIF[3:0]), .imm_16(extended));

//needed for the LLB immeduate and the Branch immediate extension
sign_ext_8_16 signext8_16_1( .imm_8(imm_7_0_idex),.imm_16(imm_16_0_idex));

//needed to extend the JAL instruction immediate
sign_ext_12_16 signext12_16_1(.imm_12(inst_curr_IDIF[11:0]),.imm_16(imm_12_to_16_idif));


///IF_ID instantiation

if_id IF_ID (.clk(clk), .inst_curr(inst_curr), .pc_added(pc_added),  
.inst_curr_IFID(inst_curr_IDIF),.pc_added_IDIF(pc_added_IDIF), .ifid_stall(ifid_stall_wire));

//mux for deciding which input to go to raddr2
MUX4 S4 (.in0(inst_curr_IDIF[3:0]), .in1(inst_curr_IDIF[11:8])
, .select(lhb_llb_regcon), .out(inst_raddr2));

wire [3:0] rf_waddr_memwb_muxout;
wire [3:0] rf_15_or_waddr;
wire [15:0] pcORwdata;

//This mux is used to decide what register we are writing to  - normal address or R15
MUX4 r15ORwaddr(.in0(rf_waddr_memwb), .in1(4'b1111), .select(jal_memwb), .out(rf_15_or_waddr));
//This mux is used to introduce a nop in the Load instruction writeback, as we want to prevent any wb

MUX4 nopLWMUX(.in0(rf_15_or_waddr), .in1(4'b0000), .select(nop_lw_memwb), .out(rf_waddr_memwb_muxout));
//MUX4 nopLWMUX(.in0(rf_waddr_memwb), .in1(4'b0000), .select(nop_lw_memwb), .out(rf_waddr_memwb_muxout));

MUX16 pcORwdataMUX(.in0(rf_wdata), .in1(pc_added_memwb), .select(jal_memwb), .out(pcORwdata));
// we send pc_added_exmem because wdata bypasses the MemWb pipeline
// we send jal_exmem to bypass the MemWb Reg
wire write_done_out, write_done_wire;
reg write_done_temp;
reg [1:0] stallCount_reg;
wire [1:0] stallCount;
assign write_done_wire = write_done_out;
assign stallCount = (pc_stall_out===1'b1)? 2'b10: 2'b00;
always @ (posedge clk) begin
  if(!(stallCount_reg>2'b00) || stallCount_reg===2'bxx) begin 
    stallCount_reg = stallCount; 
    write_done_temp=0;
  end
  else begin
    stallCount_reg = stallCount_reg-1;
    if(stallCount_reg===1'b0) begin write_done_temp=1; end
  end
end
assign write_done_out  = write_done_temp;

regfile RF(
  .clk(clk),
	.rst(rst),
	.wen(rf_wen_memwb),
	.raddr1(inst_curr_IDIF[7:4]), 
	.raddr2(inst_raddr2), 
	.waddr(rf_waddr_memwb_muxout), 
	//.wdata(rf_wdata), 
	.wdata(pcORwdata),
 	.rdata1(rdata1),
	.rdata2(rdata2)
);


wire [15:0] lhb_llb_imm_16; 
///ID Instantiation
wire lw_out, lw_wire, lw_idex;
assign lw_wire = lw_out;

///Control instantiation
control Ctrl(
    .opcode(opcode),
    //.cond(inst_curr_IDIF[11:8]),
    //.flag(flag_controlin),
    .dmem_wen(dmem_wen),
    .rf_wen(rf_wen),
    .alu_op(alu_op),
    .alusrc(alusrc),
    .regdest(regdest),
    .branch(branch),
    .mem2reg(mem2reg),
    .lhb_llb_con1(lhb_llb_regcon),
    .s5(s5),
    .s6(s6),
    .s7(s7),
    .jal(jal),
    .jr(jr),
    .exec(exec),
    .lw(lw_out)
);

wire s5_idex, s6_idex, s7_idex;

wire lhb_llb_con_idex;

hdUnit hdu(
.d_raddr1(inst_curr_IDIF[7:4]),
.d_raddr2(inst_raddr2),
.d_addrselector(lhb_llb_regcon),
.d_jr_or_exec((jr||exec)?1'b1:1'b0),
.d_immonly(opcode===4'b1010 || opcode===4'b1100 || opcode===4'b1101),
.d_opcode(opcode),
.e_isLoad(lw_idex),
.e_wreg(rf_waddr),
.pc_stall(pc_stall_out),
.ifid_stall(ifid_stall_out),
.idex_stall(idex_stall_out),
.inst_stall(inst_stall_out),
.write_done(write_done_wire)
);

//ID_EX instantiation
wire branch_idex;
wire [3:0] cond_IDEX;

id_ex ID_EX(.clk(clk), .pc_added_IDIF(pc_added_IDIF), .cond_IDIF(cond_IDIF), 
.inst_curr_IDIF(inst_curr_IDIF),.dmem_wen(dmem_wen), .rf_wen(rf_wen), 
.alu_op(alu_op), .alusrc(alusrc), .rdest1(regdest), .branch(branch), 
.mem2reg(mem2reg),.rdata1(rdata1), .rdata2(rdata2), 
.extended(extended), .imm_7_0(inst_curr_IDIF[7:0]), 
.s5_idif(s5), .s6_idif(s6), .s7_idif(s7),
.inst_curr_IDEX(inst_curr_IDEX), 
.dmem_wen_idex(dmem_wen_idex), .rf_wen_idex(rf_wen_idex), 
.alu_op_idex(alu_op_idex), 
.alusrc_idex(alusrc_idex), .rdest_idex(regdest_idex), 
.branch_idex(branch_idex), 
.mem2reg_idex(mem2reg_idex), .rdata1_idex(rdata1_idex), 
.rdata2_idex(rdata2_idex), .extended_idex(extended_idex), 
.imm_7_0_idex(imm_7_0_idex), 
.s5_idex(s5_idex),.s6_idex(s6_idex), .s7_idex(s7_idex),
.pc_added_IDEX(pc_added_IDEX), .cond_IDEX(cond_IDEX),
.jal(jal), .jal_idex(jal_idex),
.imm_12_to_16_idif(imm_12_to_16_idif), .imm_12_to_16_idex(imm_12_to_16_idex),
.jr(jr), .jr_idex(jr_idex),
.exec(exec), .exec_idex(exec_idex),
.lw(lw_wire), .lw_idex(lw_idex),
.stall(idex_stall_wire)
);

///EXE instantiation

wire [15:0] alu_second_input_final;

wire [15:0] rdata1_idex_final;
wire [15:0] rdata2_idex_final,rdata2_idex_sw_val;

wire [1:0] forwardA,forwardB, rdata2_sw_fcontrol;


//MUX for selecting rdata1 / memwb_data / exmem_data (assuming this is the value inside EX)
MUX16_3_input forward_a_alu( .in0(rdata1_idex), .in1(pcORwdata), .in2(aluout_exmem), 
.select(forwardA), .out(rdata1_idex_final));

//MUX for selecting rdata2 / memwb_data / exmem_data (assuming this is the value inside EX)
MUX16_3_input forward_b_alu(.in0(rdata2_idex), .in1(pcORwdata), .in2(aluout_exmem),
.select(forwardB), .out(rdata2_idex_final));

//MUX for selecting rdata2/forwarded value for store instruction (special case)
MUX16_3_input forward_sw_rdata2(.in0(rdata2_idex),.in1(pcORwdata),.in2(aluout_exmem),
.select(rdata2_sw_fcontrol), .out(rdata2_idex_sw_val));

//FORWARDING UNIT
forwarding_unit f_unit1 (
  .rf_waddr_exmem(rf_waddr_exmem),
  .rf_waddr_memwb(rf_waddr_memwb),
  .inst_curr_IDEX_7_4_rs(inst_curr_IDEX[7:4]),
  .inst_curr_IDEX_3_0_rt(inst_curr_IDEX[3:0]),
  .inst_curr_IDEX_11_8_rd(inst_curr_IDEX[11:8]),
  .rf_wen_exmem(rf_wen_exmem),
  .rf_wen_memwb(rf_wen_memwb),
  .mem2reg_memwb(mem2reg_memwb),
  .mem2reg_exmem(mem2reg_exmem),
  .dmem_wen_idex(dmem_wen_idex),
  .forwardA(forwardA),
  .forwardB(forwardB),
  .rdata2_sw_fcontrol(rdata2_sw_fcontrol)
  );


//mux for deciding between rdata2 and immediate value as ALU's second input
MUX16 S1( .in0(alu_second_input), .in1(extended_idex), .select(alusrc_idex), .out(alu_second_input_final));

///ALU instantiation
wire [15:0] alu_first_input;
//wire [2:0] flag_prev_to_send;

wire branch2_idex;
wire nop_alu;
wire [15:0] execPCadded;
wire putPCback;
wire [15:0] branch_target_final_muxout;

//choosing which immediate to add to the PC_added value
wire [15:0]adderToAdd = (jal_idex===1'b1)? imm_12_to_16_idex : imm_16_0_idex;

//adder for adding the PC added value and the adderToAdd
adder branch_adder(.pc_add(pc_added_IDEX),.imm(adderToAdd),.shiftout(branch_target_idex));

//this mux is used to select JR/JAL relative branch target or JR jump target absolute
//MUX16 adderout_or_jr(.in0(branch_target_idex), .in1(rdata2_idex), .select(jr_idex),.out(branch_target_final));

//what should be the value of the PC during branch
assign branch_target_final = (jr_idex===1'b1 || exec_idex === 1'b1)? rdata2_idex : branch_target_idex;
//we need branch_target to determine if branch is to be done/not?

//this mux is needed for EXEC vs JR/BR/JAL and the output becomes the FINAL branch target
MUX16 branch_target_final_or_exec (.in0(branch_target_final), .in1(execPCadded),.select(putPCback),.out(branch_target_final_muxout));


control_exe control_EXE(
  .clk(clk),
  .rst(rst),
  .branch_target(branch_target_final), 
  .pc_added(pc_added_IDEX), 
  .flag(flag_controlexein), 
  .cond(cond_IDEX), 
  .branch_idex(branch_idex), 
  .jal_idex(jal_idex),
  .jr_idex(jr_idex),
  .exec_idex(exec_idex), 
  .branch2_idex(branch2_idex),  
  .nop_alu(nop_alu),
  .nop_lw(nop_lw_idex),
  .nop_sw(nop_sw_idex),
  .execPCadded(execPCadded),
  .putPCback(putPCback)
  ); 

alu ALU(
  .a(alu_first_input),   //1st operand
  .b(alu_second_input_final),   //2nd operand
  .op(alu_op_idex),   //3-bit operation
  .imm(inst_curr_IDEX[3:0]), //4-bit immediate operand for shift/rotate
  .nop(nop_alu),
  .flag_prev_to_send(flag_aluout), // output flag register for indicating Z,V,N
  .out(aluout)   //output
);

wire [15:0] mux_ex_out;
wire [15:0] aluout_or_lhbllb_exmem;
wire [15:0] shifted81;
//wire branch2_exmem;

wire [15:0] changed8_1;

//functions needed for LHB 
ShiftLeftThenAdd1s shiftleftthenadd1s(.In(imm_7_0_idex), .Out_L8_1(shifted81));
changefirst8bits_1 changefirst8bits_1(.In(rdata2_idex),.Out_F8_1(changed8_1));

//for ALU first input
MUX16 S6(.in0(shifted81), .in1(rdata1_idex_final), .select(s6_idex), .out(alu_first_input));
//for ALU second input
MUX16 S5(.in0(rdata2_idex_final),.in1(changed8_1),.select(s5_idex),.out(alu_second_input));

//mux to select whether to jump to target address or continue with next program counter
//MUX16 select_jump(.in0(pc_curr), .in1(imm_16_0_idex), .select(jump_control), .out(pc_added));


/// EX_MEM instantiation
wire [15:0] imm_16_0_exmem;


//rdata2_idex_sw_val is the muxed val needed for forwarding store(sw) instruction
ex_mem EX_MEM (.clk(clk),.s7_idex(s7_idex), .dmem_wen_idex(dmem_wen_idex), 
.rf_wen_idex(rf_wen_idex), 
.branch2_idex(branch2_idex), .mem2reg_idex(mem2reg_idex), .aluout(aluout), 
.flag(flag), .extended_16_idex(imm_16_0_idex), 
.rdata2_idex(rdata2_idex_sw_val), .rf_waddr(rf_waddr), .dmem_wen_exmem(dmem_wen_exmem), 
.rf_wen_exmem(rf_wen_exmem), .branch2_exmem(branch2_exmem), .mem2reg_exmem(mem2reg_exmem), 
.aluout_exmem(aluout_exmem), .flag_exmem(flag_exmem), 
.rdata2_exmem(rdata2_exmem), .rf_waddr_exmem(rf_waddr_exmem),
.extended_exmem(imm_16_0_exmem) 
,.s7_exmem(s7_exmem),
.branch_target_final_muxout(branch_target_final_muxout), .branch_target_exmem(branch_target_exmem),
.nop_lw_idex(nop_lw_idex),.nop_lw_exmem(nop_lw_exmem),
.nop_sw_idex(nop_sw_idex),.nop_sw_exmem(nop_sw_exmem),
.pc_added_idex(pc_added_IDEX), .pc_added_exmem(pc_added_exmem),
.jal_idex(jal_idex), .jal_exmem(jal_exmem)
);


///MEM_WB instantiation



mem_wb MEM_WB (.clk(clk),.s7_exmem(s7_exmem)
,.rf_wen_exmem(rf_wen_exmem), 
.mem2reg_exmem(mem2reg_exmem), .rf_waddr_exmem(rf_waddr_exmem), 
.aluout_exmem(aluout_exmem),
.extended_exmem(imm_16_0_exmem), 
.rf_wen_memwb(rf_wen_memwb), 
.mem2reg_memwb(mem2reg_memwb),.rf_waddr_memwb(rf_waddr_memwb), 
.aluout_memwb(aluout_memwb), .extended_memwb(imm_16_0_memwb) 
,.s7_memwb(s7_memwb),
.nop_lw_exmem(nop_lw_exmem),.nop_lw_memwb(nop_lw_memwb),
.jal_exmem(jal_exmem), .jal_memwb(jal_memwb),
.pc_added_exmem(pc_added_exmem), .pc_added_memwb(pc_added_memwb)
);


endmodule
