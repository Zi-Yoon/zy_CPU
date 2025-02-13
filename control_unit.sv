/* Creator: ZY (Jiyoon An) */

`include "define.svh"

module control_unit (
    input [OPCODE-1:0] i_opcode, // instr[ 6: 0]
    input [FUNCT3-1:0] i_funct3, // instr[14:12]
    input [FUNCT7-1:0] i_funct7, // instr[31:25]
    output reg o_reg_read,
    output reg o_reg_write,
    output reg o_mem_read,
    output reg o_mem_write,
    output reg o_branch,
    output reg o_jump,
    output reg [ALU_OP-1:0]  o_alu_op,
    output reg [IMM_SEL-1:0] o_imm_sel
);

    always_comb begin
        // Default values
        o_reg_read  = FALSE;
        o_reg_write = FALSE;
        o_mem_read  = FALSE;
        o_mem_write = FALSE;
        o_branch    = FALSE;
        o_jump      = FALSE;
        o_alu_op    = 5'b00000;
        o_imm_sel   = 4'b0000;

        case(i_opcode)
            // ------------------------- R-type -------------------------
            7'b0110011: begin // R-type
                o_reg_write = TRUE; // Write Register
                case({i_funct7, i_funct3})
                    {7'b0000000, 3'b000}: o_alu_op = ALU_ADD; // ADD
                    {7'b0100000, 3'b000}: o_alu_op = ALU_SUB; // SUB
                    {7'b0000000, 3'b111}: o_alu_op = ALU_AND; // AND
                    {7'b0000000, 3'b110}: o_alu_op = ALU_OR ; // OR
                    {7'b0000000, 3'b100}: o_alu_op = ALU_XOR; // XOR
                    {7'b0000000, 3'b001}: o_alu_op = ALU_SLL; // SLL
                    {7'b0000000, 3'b101}: o_alu_op = ALU_SRL; // SRL
                    {7'b0100000, 3'b101}: o_alu_op = ALU_SRA; // SRA
                    default: o_alu_op = ALU_X;                // ERROR
                endcase
            end

            // ------------------------- I-type -------------------------
            7'b0010011: begin
                o_reg_write = TRUE;  // Write Register
                o_imm_sel   = IMM_I; // I-type Immediate
                case(i_funct3)
                    3'b000: o_alu_op = ALU_ADD; // ADDI
                    3'b111: o_alu_op = ALU_AND; // ANDI
                    3'b110: o_alu_op = ALU_OR ; // ORI
                    3'b100: o_alu_op = ALU_XOR; // XORI
                    default: o_alu_op = ALU_X ; // ERROR
                endcase
            end

            // ------------------------- I-type (LW) --------------------
            7'b0000011: begin
                o_mem_read  = TRUE;    // Read Memory
                o_reg_write = TRUE;    // Write Register
                o_imm_sel   = IMM_I;   // I-type Immediate
                o_alu_op    = ALU_ADD; // rs1 + imm
            end

            // ------------------------- S-type -------------------------
            7'b0100011: begin
                o_reg_read  = TRUE;    // Read Register
                o_mem_write = TRUE;    // Write Memory
                o_imm_sel   = IMM_S;   // S-type Immediate
                o_alu_op    = ALU_ADD; // rs1 + imm
            end

            // ------------------------- B-type -------------------------
            7'b1100011: begin
                o_branch    = TRUE;    // Branch
                o_imm_sel   = IMM_B;   // B-type Immediate
                o_alu_op    = ALU_SUB; // rs1 - rs2 : compare
            end

            // ------------------------- U-type (LUI) -------------------
            7'b0110111: begin
                o_reg_write = TRUE;    // Write Register
                o_imm_sel   = IMM_U;   // U-type Immediate
            end

            // ------------------------- U-type (AUIPC) -----------------
            7'b0010111: begin
                o_reg_write = TRUE;    // Write Register
                o_imm_sel   = IMM_U;   // U-type Immediate
                o_alu_op    = ALU_ADD; // ADD
            end

            // ------------------------- J-type (JAL) --------------------
            7'b1101111: begin
                o_reg_write = TRUE;    // Write Register
                o_jump      = TRUE;    // Jump
                o_imm_sel   = IMM_J;   //
                o_alu_op    = ALU_ADD; // rd = pc + 4
            end

            // ------------------------- J-type (JALR) -------------------
            7'b1100111: begin
                o_reg_write = TRUE;    // Write Register
                o_jump      = TRUE;    // Jump
                o_imm_sel   = IMM_I;   //
                o_alu_op    = ALU_ADD; // rd = pc + 4
            end

            default: begin
                o_reg_read  = FALSE;
                o_reg_write = FALSE;
                o_mem_read  = FALSE;
                o_mem_write = FALSE;
                o_branch    = FALSE;
                o_jump      = FALSE;
                o_alu_op    = 5'b00000;
                o_imm_sel   = 4'b0000;
            end
        endcase
    end
endmodule
