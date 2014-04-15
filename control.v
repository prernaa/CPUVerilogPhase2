//control unit for write enable and ALU control
//defining the conditions inside the conditional instructions

`include "define.v"

module control(
    opcode,
    //cond,
    //flag,
    dmem_wen,
    rf_wen,
    alu_op,
    alusrc,
    regdest,
    branch,
    mem2reg,
    lhb_llb_con1,
    s5,
    s6,
    s7,
    jal,
    jr,
    exec, 
    lw,
	//jump_control
  );
 
 input[3:0] opcode;
 //cond is needed for branch
 //input [3:0] cond;
 //flag will be of a previous instruction
 //input[2:0] flag;
 output reg dmem_wen;
 output reg rf_wen;
 output reg[2:0] alu_op;
 output reg alusrc;
 output reg regdest;
 output reg branch;
 output reg mem2reg;
 output reg lhb_llb_con1;
 output reg s5;
 output reg s6;
 output reg s7;
 output reg jal;
 output reg jr;
 output reg exec;
 output reg lw; 
 //output reg control_lhb_llb;
 //output reg jump_control;

always @ (*)
begin
  //dmem_wen is active on low
  // rf_wen is active on high
  if ( (opcode==`ADD) || (opcode==`SUB) || (opcode==`AND) || (opcode==`OR) )
  begin
    dmem_wen=1;
    rf_wen=1;
    alu_op=opcode[2:0];
    alusrc=0;
    regdest=1;
    branch=0;
    mem2reg=0;
    lhb_llb_con1 = 0;
    s5 = 0;
    s6 = 1;
    s7 = 0;//THIS SHOULD BE 0
    jal = 0; 
    jr = 0;
    exec = 0;
    lw=0;
  end
  if ( (opcode==`SLL) || (opcode==`SRL) || (opcode==`SRA) || (opcode==`RL) )
  begin
    dmem_wen=1;
    rf_wen=1;
    alu_op=opcode[2:0];
    alusrc=1;
    regdest=1;
    branch=0;
    mem2reg=0;
    lhb_llb_con1 = 0;
    s5 = 0;
    s6 = 1;
    s7 = 0;
    jal=0;
    jr = 0;
    exec = 0;
    lw=0;
  end
  if (opcode==`LW)
  begin
    dmem_wen=1;
    rf_wen=1;
    alu_op=3'b000;
    alusrc=1;
    regdest=1;
    branch=0;
    mem2reg=1;
    lhb_llb_con1 = 0;
    s5 = 0;
    s6 = 1;
    s7 = 0;
    jal=0;
    jr = 0;
    exec =0;
    lw=1;
  end
  if (opcode==`SW)
  begin
    dmem_wen=0;
    rf_wen=0;
    alu_op=3'b000;
    alusrc=1;
    regdest=0;
    branch=0;
    //FIXED
    lhb_llb_con1 = 1;
    s5 = 0;
    s6 = 1;
    jal=0;
    jr = 0;
    exec = 0;
    lw=0;
    mem2reg=0;
  end
  if((opcode == `LHB)) 
  begin
    dmem_wen = 1;
    alu_op = 3'b010;
    rf_wen = 1;
    regdest = 1;
    branch = 0;
    lhb_llb_con1 = 1;
    mem2reg=0;
    alusrc = 0;
    s5 = 1;
    s6 = 0;
    s7 = 0;
    jal=0;
    jr = 0;
    exec = 0;
    lw=0;
  end
  if(opcode == `LLB)
  begin
    dmem_wen = 1;
    rf_wen = 1;
    regdest = 1;
    mem2reg=0;
    s7 = 1;
    branch = 0;
    jal=0;
    jr = 0;
    exec = 0;
    lw=0;
  end 
  if(opcode == `JAL)
  begin
    dmem_wen=1;
    rf_wen=1;
    alu_op=3'b000; // ALU will be NOP (decided by control_EXE)
    //alusrc=1; // not using ALU
    //regdest=1;
    branch=0;
    jal = 1;
    mem2reg=0;
    lhb_llb_con1 = 0;
    s5 = 0;
    s6 = 1;
    s7 = 0;
    jr = 0;
    exec = 0;
    lw=0;
  end
  
  if(opcode == `JR)
  begin
    dmem_wen = 1;
    rf_wen = 0;
    branch = 0;
    lhb_llb_con1 = 1;
    mem2reg=0;
    jal = 0;
    s5 = 0;
    s6 = 1;
    s7 = 0;
    jr = 1;
    exec = 0;
    lw=0;
  end
  if(opcode == `EXEC)
  begin
    dmem_wen = 1;
    rf_wen = 0;
    branch = 0;
    mem2reg=0;
    lhb_llb_con1 = 1;
    jal = 0;
    s5 = 0;
    s6 = 1;
    s7 = 0;
    jr = 0;
    exec = 1;
    lw=0;
  end
  /*if(opcode == `JAL)
  begin
    control_lhb_llb = 0;
    lhb_llb_sec_control = 0;
    rf_wen = 1;
    dmem_wen = 1;
    jr_rf = 0;
    jr_adder = 0;
    jal_control_mux = 1;
    jal_write_reg = 1;
    mem_branch = 0;
  end*/  
  
  if((opcode == `BR))
  begin
    //control_lhb_llb = 0;
    //lhb_llb_sec_control = 0;
    //jal_control_mux = 0;
    //jal_write_reg = 0;
    //jr_rf=0;
    //jr_adder=0;
    
    s7 = 0;
    dmem_wen=1;
    rf_wen=0;
    branch=1;
    jal=0;
    jr = 0;
    mem2reg=0;
    /*if(flag[2] == 1'b1 && cond==4'b000)
    begin
      //Branch EQUAL previous instruction condition
      dmem_wen = 1;
      rf_wen = 0;
      branch = 1;
    end
    else if(flag[2] == 1'b0 && cond==4'b001)
    begin
      //Branch NOT EQUAL prev instruction condition
      dmem_wen = 1;
      rf_wen = 0;
      branch = 1;
    end
    else if((flag[2] == 1'b0) && (flag[0] == 1'b0) && cond == 4'b010)
    begin
      //Branch GREATER THAN prev instruction condition  
      dmem_wen = 1;
      rf_wen = 0;   
      branch = 1;
    end
    else if(flag[0] == 1'b1 && cond == 4'b011)
    begin
      //Branch LESS THAN prev instruction condition
      dmem_wen = 1;
      rf_wen = 0;
      branch = 1;
    end
    else if((flag[2] == 1'b1) || ((flag[2] == 1'b0) && (flag[0] == 1'b0)) && cond == 4'b100)
    begin
      //Branch Greater Than or Equal To prev instruction condition
      dmem_wen = 1;
      rf_wen = 0;
      branch = 1;
    end
    else if((flag[0] == 1'b1) || (flag[2] == 1'b0) && cond == 4'b101)
    begin
      //Branch Less Than or Equal To prev instruction condition
      dmem_wen = 1;
      rf_wen = 0;
      branch = 1;
    end
    else if(flag[1] == 1'b1 && cond == 110)
    begin
      //Branch overflow prev instruction condition
      dmem_wen = 1;
      rf_wen = 0;
      branch = 1;
    end
    else if(cond==4'b111)
    begin
      //Branch if true
      dmem_wen = 1;
      rf_wen = 0;
      branch = 1;
    end
    else
    begin
      dmem_wen = 1;
      rf_wen = 0;
      branch = 0;
    end  */        
  end
end
endmodule