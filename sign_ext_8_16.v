module sign_ext_8_16(
  imm_8, imm_16);
  
  input [7:0] imm_8;
  output[15:0] imm_16;
  
  assign imm_16 = {{8{imm_8[7]}}, imm_8};
endmodule  
