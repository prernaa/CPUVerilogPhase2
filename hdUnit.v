module hdUnit(
  d_raddr1, d_raddr2, d_addrselector, d_jr_or_exec, d_immonly, d_opcode, e_isLoad, e_wreg, 
  //nop_alu_stall, nop_lw_stall, nop_sw_stall,  // this doesn't seem to be required for this
  pc_stall, ifid_stall, idex_stall, inst_stall,
  write_done
);
// d_addrselector is lhb_llb_regcon, it gives addr fof [11:8] in raddr2 when 1 OR [7:4] in raddr2 when 0
// jal or exec is jal || exec
// ! (jal || exec) will indicate sw instruction
// d_immonly is 1 for instructions which only use immediates or offsets and don't need to be stalled
input [3:0] d_raddr1;
input [3:0] d_raddr2;
input d_addrselector;
input d_jr_or_exec;
input d_immonly;
input [3:0] d_opcode;
input e_isLoad;
input [3:0] e_wreg;
input write_done;
output pc_stall;
output ifid_stall; 
output idex_stall;
output inst_stall;

//reg [1:0] stallCount;

/*always @ (*)
begin
  stallCount = (e_isLoad===1'b1 && d_immonly!==1'b1 && (
(d_addrselector===1'b1 && d_jr_or_exec!==1'b1 && (d_raddr1===e_wreg || d_raddr2===e_wreg)) ||//Check if instr in d is sw and whether it needs a stall
(d_addrselector===1'b1 && d_jr_or_exec===1'b1 && (d_raddr2===e_wreg)) || // JR or exec
(d_addrselector!==1'b1 && (d_raddr1===e_wreg || d_raddr2===e_wreg))
)) ? 2'b111 :  stallCount;
  if(stallCount>3'b00) begin
    pc_stall_temp = 1'b1;
    ifid_stall_temp = 1'b1;
  stallCount = stallCount-1'b1;
  end
  else begin
    pc_stall_temp = 1'b0;
    ifid_stall_temp = 1'b0;
  end  
end*/
/*wire temp_r1_w;
assign temp_r1_w = (d_raddr1===e_wreg);
assign pc_stall = (write_done === 1'b1)? 1'b0 :(e_isLoad===1'b1 && d_immonly!==1'b1 && e_wreg!==4'b000 && (
(temp_r1_w===1'b1) // load
)) ? 1'b1 : 1'b0;
assign ifid_stall = (write_done === 1'b1)? 1'b0 :(e_isLoad===1'b1 && d_immonly!==1'b1 && e_wreg!==4'b000 && (
(temp_r1_w===1'b1) // load
)) ? 1'b1 : 1'b0;
assign idex_stall = (write_done === 1'b1)? 1'b0 :(e_isLoad===1'b1 && d_immonly!==1'b1 && e_wreg!==4'b000 && (
(temp_r1_w===1'b1) // load
)) ? 1'b1 : 1'b0;*/

assign pc_stall = (write_done === 1'b1)? 1'b0 :(e_isLoad===1'b1 && d_immonly!==1'b1 && e_wreg!==4'b000 && (
(d_opcode!==4'b1000 && d_addrselector===1'b1 && d_jr_or_exec!==1'b1 && (d_raddr1===e_wreg || d_raddr2===e_wreg)) ||//Check if instr in d is sw and whether it needs a stall
(d_opcode!==4'b1000 && d_addrselector===1'b1 && d_jr_or_exec===1'b1 && (d_raddr2===e_wreg)) || // JR or exec
(d_opcode!==4'b1000 && d_addrselector!==1'b1 && (d_raddr1===e_wreg || d_raddr2===e_wreg)) || // arith
(d_opcode===4'b1000 && d_addrselector!==1'b1 && d_raddr1===e_wreg) // load
)) ? 1'b1 : 1'b0;
assign ifid_stall = (write_done === 1'b1)? 1'b0 :(e_isLoad===1'b1 && d_immonly!==1'b1 && e_wreg!==4'b000 && (
(d_opcode!==4'b1000 && d_addrselector===1'b1 && d_jr_or_exec!==1'b1 && (d_raddr1===e_wreg || d_raddr2===e_wreg)) ||//Check if instr in d is sw and whether it needs a stall
(d_opcode!==4'b1000 && d_addrselector===1'b1 && d_jr_or_exec===1'b1 && (d_raddr2===e_wreg)) || // JR or exec
(d_opcode!==4'b1000 && d_opcode!==4'b1000 && d_addrselector!==1'b1 && (d_raddr1===e_wreg || d_raddr2===e_wreg)) || // arith
(d_opcode===4'b1000 && d_addrselector!==1'b1 && d_raddr1===e_wreg) // load
)) ? 1'b1 : 1'b0;
assign idex_stall = (write_done === 1'b1)? 1'b0 :(e_isLoad===1'b1 && d_immonly!==1'b1 && e_wreg!==4'b000 && (
(d_opcode!==4'b1000 && d_addrselector===1'b1 && d_jr_or_exec!==1'b1 && (d_raddr1===e_wreg || d_raddr2===e_wreg)) ||//Check if instr in d is sw and whether it needs a stall
(d_opcode!==4'b1000 && d_addrselector===1'b1 && d_jr_or_exec===1'b1 && (d_raddr2===e_wreg)) || // JR or exec
(d_opcode!==4'b1000 && d_addrselector!==1'b1 && (d_raddr1===e_wreg || d_raddr2===e_wreg)) || // arith
(d_opcode===4'b1000 && d_addrselector!==1'b1 && d_raddr1===e_wreg) // load
)) ? 1'b1 : 1'b0;
assign inst_stall = (write_done === 1'b1)? 1'b0 :(e_isLoad===1'b1 && d_immonly!==1'b1 && e_wreg!==4'b000 && (
(d_opcode!==4'b1000 && d_addrselector===1'b1 && d_jr_or_exec!==1'b1 && (d_raddr1===e_wreg || d_raddr2===e_wreg)) ||//Check if instr in d is sw and whether it needs a stall
(d_opcode!==4'b1000 && d_addrselector===1'b1 && d_jr_or_exec===1'b1 && (d_raddr2===e_wreg)) || // JR or exec
(d_opcode!==4'b1000 && d_addrselector!==1'b1 && (d_raddr1===e_wreg || d_raddr2===e_wreg)) || // arith
(d_opcode===4'b1000 && d_addrselector!==1'b1 && d_raddr1===e_wreg) // load
)) ? 1'b1 : 1'b0;

/// NOP also has to sent through the whole pipeline 3 times

endmodule
