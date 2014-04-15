module adder( pc_add, imm, shiftout);
  input [15:0] pc_add;
  input [15:0] imm;
  output [15:0] shiftout;
  assign shiftout = pc_add + imm;
endmodule
   
