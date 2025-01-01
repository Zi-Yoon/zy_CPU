/* Creator: ZY (Jiyoon An) */

module if_id_reg (
    input clk,
    input rstn,
    input      [31:0] i_pc,
    input      [31:0] i_instr,
    output reg [31:0] o_pc,
    output reg [31:0] o_instr
);

    always @(posedge clk or negedge rstn) begin
        if (!rstn) begin
            o_pc    <= 32'b0;
            o_instr <= 32'b0;
        end else begin
            o_pc    <= i_pc;
            o_instr <= i_instr;
        end
    end

endmodule
