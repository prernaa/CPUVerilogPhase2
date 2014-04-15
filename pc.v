module pc(in, out, clk, rst, stall);
    input[15:0] in;
    input clk;
    input rst;
    input stall;
    output [15:0] out;
    
    reg[15:0] value;
    
    always@(posedge clk or posedge rst) begin
        if(rst)
            begin
            value <= 16'b0000000000000000;
            end
        else
            begin
                if(stall!==1'b1) begin value <= in; end
            end
    end
    assign out = value;
endmodule        

