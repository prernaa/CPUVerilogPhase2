module shift_left_2 (
  in, out);
  input [15:0] in;
  output [15:0] out;
  assign out = in << 2;
endmodule
  
