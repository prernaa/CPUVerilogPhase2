module control_exe(
  clk,
  rst,
  branch_target, // PC+1+offset
  pc_added, //PC+1
  flag, // flagprev_idex
  cond, // condition for branch
  branch_idex, // input from control.v for branch
  jal_idex, // input from control.v for jump and link
  jr_idex, //input from control.v for jump return
  exec_idex, //input from control.v for exec
  branch2_idex, // output that finally goes to pc mux 
  nop_alu, // output to alu
  nop_lw, //nop for sw(mem)
  nop_sw, //nop for lw(mem)
  execPCadded, //the previous pcadded value which is needed for exec after executing its branch instruction 
  putPCback, //select signal to choose pcadded for exec or branch target normal(jr/jal/br)
);
input clk;
input rst;
input [15:0] branch_target;
input [15:0] pc_added;
input branch_idex;
input jal_idex;
input jr_idex;
input exec_idex;
input [2:0] flag;
input [3:0] cond;
output branch2_idex;
reg branch2_temp;
reg branch2_temp2;
output nop_alu;
output nop_lw;
output nop_sw;
output [15:0] execPCadded;
output putPCback;
reg nop_alu_temp;
reg nop_lw_temp;
reg nop_sw_temp;
reg canBranch; // cond check
reg [2:0] NOP;
reg isBr;
reg [3:0] myCond;
reg setExec; // exec statement sets this to 1, next statement makes it 0
//reg isExec;
reg [15:0] execPCadded_temp, execPCadded_temp2;
reg [15:0] execPCadded_stored;// reg inside control_exe where the pcadded value(exec+1) is stored
reg putPCback_temp2;//reg inside control_exe which stores the mux select signal
reg putBack_temp;
always @ (pc_added)
//always @ (posedge clk)
//always @ (pc_added)
//always @ (branch_target, pc_added, branch_idex, flag, cond)
        begin
          putPCback_temp2=1'b0;
          if(setExec===1'b1 && (!(NOP>3'b000) || NOP === 3'bxxx)) begin 
            /// send putPCback=1 and output execPCadded
            putPCback_temp2 = 1'b1;
            execPCadded_temp2 = execPCadded_stored;
            setExec = 1'b0;
          end
          if(exec_idex===1'b1 && putPCback_temp2 === 1'b0 && (!(NOP>3'b000) || NOP === 3'bxxx)) begin
            setExec = 1'b1;
            execPCadded_stored = pc_added;
          end
          
          else begin
            /// putPCback =0
          end 
          myCond=cond;
          isBr=branch_idex;
          /*if(jal_idex === 1'b1) begin
            myCond = 4'b0111;
            isBr = 1'b1;
          end*/
          if(isBr!==1'b0) begin
          if(flag[2] == 1'b1 && myCond==4'b000)
          begin
          //Branch EQUAL previous instruction condition
            //$display("4'b000");
            canBranch = 1'b1;
          end
          else if(flag[2] == 1'b0 && myCond==4'b001)
          begin
          //Branch NOT EQUAL prev instruction condition
            //$display("4'b001");
            canBranch = 1'b1;
          end
          else if(((flag[2] == 1'b0) && (flag[0] == 1'b0)) && myCond == 4'b010)
          begin
          //Branch GREATER THAN prev instruction condition
            //$display("4'b010");
            canBranch = 1'b1;
          end
          else if(flag[0] == 1'b1 && myCond == 4'b011)
          begin
          //Branch LESS THAN prev instruction condition
            //$display("4'b011");
            canBranch = 1'b1;
          end
          else if(((flag[2] == 1'b1) || ((flag[2] == 1'b0) && (flag[0] == 1'b0))) && myCond == 4'b100)
          begin
          //Branch Greater Than or Equal To prev instruction condition
            //$display("4'b100");
            //canBranch = 1'b1;
            canBranch = 1'b1;
          end
          else if(((flag[0] == 1'b1) || (flag[2] == 1'b1)) && myCond == 4'b101)
          begin
          //Branch Less Than or Equal To prev instruction condition
            //$display("4'b101");
            canBranch = 1'b1;
          end
          else if(flag[1] == 1'b1 && myCond == 4'b110)
          begin
          //Branch overflow prev instruction condition
            //$display("4'b110");
            canBranch = 1'b1;
          end
          else if(cond==4'b111)
          begin
          //Branch if true    
            //$display("4'b111");
            canBranch = 1'b1;
          end
          else
          begin
            canBranch = 1'b0;
          end
        end
        else begin
          canBranch = 1'b0;
        end
        /*$display("SEQ");
        if((isBr===1'b1 || (jal_idex===1'b1 || jr_idex === 1'b1))) begin
          $display("1true");
        end
        if(canBranch===1'b1 || jal_idex===1'b1 || jr_idex === 1'b1) begin
          $display("2true");
        end
        $write(branch_target);
        $write("added:");
        $write(pc_added);
        if(branch_target!==pc_added) begin
          $display("3true");
        end
        if((branch_target!==pc_added) && (canBranch===1'b1 || jal_idex===1'b1 || jr_idex === 1'b1)) begin
          $display("4true");
        end
        if((isBr===1'b1 || (jal_idex===1'b1 || jr_idex === 1'b1)) && ((branch_target!==pc_added) && 
        (canBranch===1'b1 || (jal_idex===1'b1 || jr_idex === 1'b1)))) begin
          $display("MAIN true");
        end*/
        
        if((isBr===1'b1 || (jal_idex===1'b1 || jr_idex === 1'b1 || exec_idex === 1'b1 || putPCback_temp2 === 1'b1)) && ((branch_target!==pc_added) && 
        (canBranch===1'b1 || jal_idex===1'b1 || jr_idex === 1'b1 || exec_idex === 1'b1 || putPCback_temp2 === 1'b1))) // successful branch
          begin
            //if(branch_idex===1'b1) begin $display("branch=1"); end
            //$display("success");
            
            branch2_temp=1'b1; // change PC to branch_target
            if(!(NOP>3'b000)|| NOP===3'bxxx) // increment NOP by 3
              begin
                NOP = 3'b100;
              end 
            else
              begin
                //NOP = NOP + 3'b100;
                // The above case will never occur, coz NOP always become 0 
                // before going to the EXE part of the "branched" instruction
                // For a branch after a branch, the outer IF can be true
                // but it still needs to fail or be bypassed as its an NOP
                branch2_temp=1'b0;
                //NOP = NOP + 3'b001; // DONT DO THIS
              end 
          end
        else if((isBr===1'b1 || jal_idex===1'b1 || jr_idex === 1'b1 || exec_idex === 1'b1 || putPCback_temp2 === 1'b1) && ((branch_target===pc_added)|| 
        (canBranch===1'b0 || jal_idex===1'b1 || jr_idex === 1'b1 || exec_idex === 1'b1 || putPCback_temp2 === 1'b1))) // branch failed
          begin
            //$display("failed");
            branch2_temp=1'b0; // don't change PC
            if(!(NOP>3'b000) || NOP===3'bxxx) // increment NOP by 1 to not operate on the branch condition
              begin
                NOP = 3'b001;
              end 
            else
              begin

                //NOP = NOP + 3'b001;
                // The above doesn't happen in any situation
                // if it does we need to bypass that branch
                //NOP = NOP + 3'b001; // DONT DO THIS
              end 
          end
        else 
          begin // branch = 0 --- not a branch statement
            branch2_temp=1'b0;
          end
        // Different if-else construct
        //NOP = NOP+3'b001;
        if(!(NOP>3'b000) || NOP === 3'bxxx) // do the operation when NOP = 0 && when NOP is invalid !( NOP>0)
          begin
            nop_alu_temp = 1'b0;
            nop_lw_temp = 1'b0;
            nop_sw_temp = 1'b0;
          end
        else
          begin
            nop_alu_temp = 1'b1;
            if(branch2_temp===1'b1) begin 
              nop_lw_temp = 1'b0; 
            end 
            else begin
              nop_lw_temp = 1'b1; 
            end
            nop_sw_temp = 1'b1;
            NOP = NOP - 3'b001;
          end
        branch2_temp2 = branch2_temp;
        execPCadded_temp = execPCadded_temp2;
        putBack_temp = putPCback_temp2;  
        end // always end
    assign branch2_idex = branch2_temp2;
    assign nop_alu = (putPCback===1'b0)? nop_alu_temp : 1'b0;
    assign nop_lw = (putPCback===1'b0)? nop_lw_temp : 1'b0;
    assign nop_sw = (putPCback===1'b0)? nop_sw_temp : 1'b0;
    assign execPCadded = execPCadded_temp;
    assign putPCback = putBack_temp;
endmodule
  