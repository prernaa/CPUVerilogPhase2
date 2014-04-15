
//mux 16
module MUX16 (in0, in1, select, out);
    input[15:0] in0;
    input[15:0] in1;
    input select;
    output reg[15:0] out;
    
    always @(in0 or in1 or select)
        begin
        case(select)
        0 : out = in0;
        1 : out = in1;
        default: out = in0;
        endcase
        end
        
endmodule
