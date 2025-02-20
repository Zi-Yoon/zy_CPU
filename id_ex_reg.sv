/* Creator: ZY (Jiyoon An) */

module id_ex_reg (
    input              clk,
    input              rstn,
    input              flush,    // 플러시 신호

    // ID
    input      [31:0]  id_pc,
    input      [31:0]  id_rdata1,
    input      [31:0]  id_rdata2,
    input      [31:0]  id_imm,
    input      [3:0]   id_alu_op,
    input              id_regw,
    input              id_memr,
    input              id_memw,
    input              id_branch,
    input              id_jump,
    input      [4:0]   id_rd,
    // EX
    output reg [31:0]  ex_pc,
    output reg [31:0]  ex_rdata1,
    output reg [31:0]  ex_rdata2,
    output reg [31:0]  ex_imm,
    output reg [3:0]   ex_alu_op,
    output reg         ex_regw,
    output reg         ex_memr,
    output reg         ex_memw,
    output reg         ex_branch,
    output reg         ex_jump,
    output reg [4:0]   ex_rd
);

    always @(posedge clk or negedge rstn) begin
        if (!rstn) begin
            ex_pc       <= 32'b0;
            ex_rdata1   <= 32'b0;
            ex_rdata2   <= 32'b0;
            ex_imm      <= 32'b0;
            ex_alu_op   <= 4'b0;
            ex_regw     <= 1'b0;
            ex_memr     <= 1'b0;
            ex_memw     <= 1'b0;
            ex_branch   <= 1'b0;
            ex_jump     <= 1'b0;
            ex_rd       <= 5'b0;
        end
        else if (flush) begin
            ex_pc       <= 32'b0;
            ex_rdata1   <= 32'b0;
            ex_rdata2   <= 32'b0;
            ex_imm      <= 32'b0;
            ex_alu_op   <= 4'b0;
            ex_regw     <= 1'b0;
            ex_memr     <= 1'b0;
            ex_memw     <= 1'b0;
            ex_branch   <= 1'b0;
            ex_jump     <= 1'b0;
            ex_rd       <= 5'b0;
        end
        else begin
            ex_pc       <= id_pc;
            ex_rdata1   <= id_rdata1;
            ex_rdata2   <= id_rdata2;
            ex_imm      <= id_imm;
            ex_alu_op   <= id_alu_op;
            ex_regw     <= id_regw;
            ex_memr     <= id_memr;
            ex_memw     <= id_memw;
            ex_branch   <= id_branch;
            ex_jump     <= id_jump;
            ex_rd       <= id_rd;
        end
    end

endmodule
