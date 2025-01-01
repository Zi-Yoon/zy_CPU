/* Creator: ZY (Jiyoon An) */

module pc_reg(
    input clk,
    input rstn,
    input      [31:0] i_next_pc,
    output reg [31:0] o_pc
);

    always @(posedge clk or negedge rstn) begin
        if(!rstn) begin
            o_pc <= 32'h0;
        end
        else begin
            o_pc <= i_next_pc;
        end
    end

endmodule
