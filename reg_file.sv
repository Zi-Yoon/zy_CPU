/* Creator: ZY (Jiyoon An) */

module reg_file(
    input  clk,
    input  i_we,
    input  [ 4:0] i_raddr1,
    input  [ 4:0] i_raddr2,
    input  [ 4:0] i_waddr,
    input  [31:0] i_wdata,
    output [31:0] o_rdata1,
    output [31:0] o_rdata2
);

reg [31:0] regs [32];

assign o_rdata1 = (i_raddr1 == 0) ? 32'd0 : regs[raddr1];
assign o_rdata2 = (i_raddr2 == 0) ? 32'd0 : regs[raddr2];

always @(posedge clk) begin
    if (i_we && (i_waddr != 0)) begin
        regs[waddr] <= wdata;
    end
end

endmodule
