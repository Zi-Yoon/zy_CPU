/* Creator: ZY (Jiyoon An) */

`include "define.svh"

module control_unit (
    input [OPCODE-1:0] i_opcode, // instr[ 6: 0]
    input [FUNCT3-1:0] i_funct3, // instr[14:12]
    input [FUNCT7-1:0] i_funct7, // instr[31:25]
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
        o_reg_write = 1'b0;
        o_mem_read  = 1'b0;
        o_mem_write = 1'b0;
        o_branch    = 1'b0;
        o_jump      = 1'b0;
        o_alu_op    = 4'b0;
        o_imm_sel   = 2'b0;

        case(i_opcode)
            // ------------------------- R-type -------------------------
            7'b0110011: begin // R-type
                o_reg_write = 1'b1; // Write to RD
                case({i_funct3, i_funct7})
                    {7'b0000000, 3'b000}: o_alu_op = 4'b0000; // ADD
                    {7'b0100000, 3'b000}: o_alu_op = 4'b0001; // SUB
                    {7'b0000000, 3'b111}: o_alu_op = 4'b0010; // AND
                    {7'b0000000, 3'b110}: o_alu_op = 4'b0011; // OR
                    {7'b0000000, 3'b100}: o_alu_op = 4'b0100; // XOR
                    {7'b0000000, 3'b001}: o_alu_op = 4'b0101; // SLL
                    {7'b0000000, 3'b101}: o_alu_op = 4'b0110; // SRL
                    {7'b0100000, 3'b101}: o_alu_op = 4'b0111; // SRA
                    default: o_alu_op = 4'bxxxx; // ERROR
                endcase
            end

            // ------------------------- I-type -------------------------
            7'b0010011: begin // I-type
                o_reg_write = 1'b1;  // Write to RD
                o_imm_sel   = 2'b00; // I-type Immediate
                case(i_funct3)
                    3'b000: o_alu_op = 4'b0000; // ADDI
                    3'b111: o_alu_op = 4'b0010; // ANDI
                    3'b110: o_alu_op = 4'b0011; // ORI
                    3'b100: o_alu_op = 4'b0100; // XORI
                    // 3'b001: o_alu_op = 4'b0101; // SLLI
                    // 3'b101: o_alu_op = 4'b0110; // SRLI
                    // 3'b101: o_alu_op = 4'b0111; // SRAI
                    default: o_alu_op = 4'bxxxx; // ERROR
                endcase
            end

            // --------------------------- LW ---------------------------
            7'b0000011: begin // LOAD
                o_mem_read  = 1'b1;    // Read Memory
                o_reg_write = 1'b1;    // Write Register
                o_imm_sel   = 2'b00;   // I-type Immediate
                o_alu_op    = 4'b0000; // rs1 + imm
            end

            // ------------------------- S-type -------------------------
            7'b0100011: begin // STORE
                o_reg_read  = 1'b1;    // Read Register
                o_mem_write = 1'b1;    // Write Memory
                o_imm_sel   = 2'b01;   // S-type Immediate
                o_alu_op    = 4'b0000; // rs1 + imm
            end

            // ------------------------- B-type -------------------------
            7'b1100011: begin // Branch
                o_branch  = 1'b1;    // Branch
                o_imm_sel = 2'b10;   // B-type Immediate
                o_alu_op  = 4'b0000; // ADD
            end

            // ------------------------- U-type -------------------------

            // ------------------------- J-type -------------------------

            default: begin
                temp;
            end
        endcase
    end

endmodule
