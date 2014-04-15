module sign_ext_4_16(
  imm_4, imm_16);
  
  input [3:0] imm_4;
  output[15:0] imm_16;
  
  assign imm_16 = {{12{imm_4[3]}}, imm_4};
endmodule  