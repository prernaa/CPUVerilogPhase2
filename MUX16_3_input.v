//mux needed for 3 inputs and a 2 bit signal
module MUX16_3_input (in0, in1, in2, select, out);
    input[15:0] in0;
    input[15:0] in1;
    input [15:0] in2;
    input [1:0] select;
    output reg[15:0] out;
    
    always @(in0 or in1 or in2 or select)
        begin
        case(select)
        2'b00 : out = in0;
        2'b01 : out = in1;
        2'b10 : out = in2;
        default: out = in0;
        endcase
        end
        
endmodule

