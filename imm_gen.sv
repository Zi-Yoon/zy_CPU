/* Creator: ZY (Jiyoon An) */

`include "define.svh"

module imm_gen (
    input [INS_WIDTH-1:0] i_instr,
    input [IMM_SEL-1:0] i_imm_sel,
    output reg [31:0] o_imm
);

    always_comb begin
        case(i_imm_sel)
            IMM_I: o_imm = {{20{i_instr[31]}}, i_instr[31:20]};
            IMM_S: o_imm = {{20{i_instr[31]}}, i_instr[31:25], i_instr[11:7]};
            IMM_B: o_imm = {{19{i_instr[31]}}, i_instr[31], i_instr[7], i_instr[30:25], i_instr[11:8], 1'b0};
            IMM_U: o_imm = {i_instr[31:12], 12'b0}; // imm << 12
            IMM_J: o_imm = {{11{i_instr[31]}}, i_instr[31], i_instr[19:12], i_instr[20], i_instr[30:21], 1'b0};
            default: o_imm = 32'b0;
        endcase
    end

endmodule
