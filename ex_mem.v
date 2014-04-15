
module ex_mem(clk,s7_idex, dmem_wen_idex, rf_wen_idex, branch2_idex,  
mem2reg_idex,aluout, flag, extended_16_idex, rdata2_idex, rf_waddr, dmem_wen_exmem, 
rf_wen_exmem, branch2_exmem, mem2reg_exmem, aluout_exmem, flag_exmem, 
rdata2_exmem, rf_waddr_exmem, extended_exmem, s7_exmem, branch_target_final_muxout, branch_target_exmem,
nop_lw_idex,nop_sw_idex, nop_lw_exmem, nop_sw_exmem,
pc_added_idex, pc_added_exmem,
jal_idex, jal_exmem
);
  
  input clk;
  input s7_idex;
  input dmem_wen_idex;
  input rf_wen_idex;
  input mem2reg_idex;
  input branch2_idex;
  input [15:0] aluout;
  input [2:0] flag;
  input [15:0] extended_16_idex;
  input [15:0] rdata2_idex;
  input [3:0] rf_waddr;
  input [15:0] pc_added_idex;
  input jal_idex;
  
  input nop_lw_idex, nop_sw_idex;
  output nop_lw_exmem, nop_sw_exmem;
  input [15:0] branch_target_final_muxout;
  output [15:0] branch_target_exmem;
  output dmem_wen_exmem;
  output rf_wen_exmem;
  output branch2_exmem;
  output mem2reg_exmem;
  output s7_exmem;
  output [15:0] extended_exmem;
  output [15:0] pc_added_exmem;
  output jal_exmem;
  
  reg dmem_wen_exmem_temp;
  reg rf_wen_exmem_temp;
  reg branch2_exmem_temp;
  reg mem2reg_exmem_temp;
  reg s7_exmem_temp;
  reg [15:0] extended_exmem_temp;
  reg [15:0] pc_added_temp;
  reg jal_temp; 
  
  output [15:0] aluout_exmem;
  output [2:0] flag_exmem;
  
  output [15:0] rdata2_exmem;
  output [3:0] rf_waddr_exmem;
  
  reg nop_lw_temp, nop_sw_temp;
  
  //output reg control_lhb_llb_exmem;
  
  reg [15:0] aluout_exmem_temp;
  reg [2:0] flag_exmem_temp;
  
  reg [15:0] rdata2_exmem_temp;
  reg [3:0] rf_waddr_exmem_temp;
  reg [15:0] branch_target_temp;

    
    always @ (posedge clk)
        begin
        dmem_wen_exmem_temp <= dmem_wen_idex;
        rf_wen_exmem_temp <= rf_wen_idex;
        branch2_exmem_temp <= branch2_idex;
        mem2reg_exmem_temp <= mem2reg_idex;
        aluout_exmem_temp <=aluout;
        flag_exmem_temp <= flag;
        rdata2_exmem_temp <= rdata2_idex;
        rf_waddr_exmem_temp <= rf_waddr;
        s7_exmem_temp <= s7_idex;
        extended_exmem_temp <= extended_16_idex;
        branch_target_temp<= branch_target_final_muxout;
        nop_lw_temp <= nop_lw_idex;
        nop_sw_temp <= nop_sw_idex;
        pc_added_temp <= pc_added_idex;
        jal_temp <= jal_idex;
        end
    
     assign dmem_wen_exmem = dmem_wen_exmem_temp;
     assign rf_wen_exmem = rf_wen_exmem_temp;
     assign branch2_exmem = branch2_exmem_temp;
     assign mem2reg_exmem = mem2reg_exmem_temp;
     assign aluout_exmem = aluout_exmem_temp;
     assign flag_exmem = flag_exmem_temp;
     assign rdata2_exmem = rdata2_exmem_temp;
     assign rf_waddr_exmem = rf_waddr_exmem_temp;
     assign s7_exmem = s7_exmem_temp;
     assign extended_exmem = extended_exmem_temp;  
     assign branch_target_exmem = branch_target_temp;
     assign nop_lw_exmem = nop_lw_temp;   
     assign nop_sw_exmem = nop_sw_temp;
     assign pc_added_exmem = pc_added_temp;
     assign jal_exmem = jal_temp; 

endmodule

