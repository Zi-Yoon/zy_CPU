/* Creator: ZY (Jiyoon An) */

module alu (
    input [ALU_OP-1:0] i_alu_op,
    input       [31:0] i_a,
    input       [31:0] i_b,
    output reg  [31:0] o_out,
    output             o_zero,
    output             o_signed
    // output             o_unsigned
);

wire [31:0] add_result = i_a + i_b;
wire [31:0] sub_result = i_a - i_b;
wire [31:0] and_result = i_a & i_b;
wire [31:0] or_result  = i_a | i_b;
wire [31:0] xor_result = i_a ^ i_b;
wire [31:0] sll_result = i_a << i_b[4:0];
wire [31:0] srl_result = i_a >> i_b[4:0];
wire [31:0] sra_result = i_a >>> i_b[4:0];

always_comb begin
    case (i_alu_op)
        5'b00000: o_out = add_result;
        5'b00001: o_out = sub_result;
        5'b00010: o_out = and_result;
        5'b00011: o_out =  or_result;
        5'b00100: o_out = xor_result;
        5'b00101: o_out = sll_result;
        5'b00110: o_out = srl_result;
        5'b00111: o_out = sra_result;
        default: o_out = 32'b0;
    endcase
end

assign o_zero = (o_out == 32'b0);
assign o_signed   = ($signed(i_a) < $signed(i_b));
// assign o_unsigned = (i_a < i_b);

endmodule
