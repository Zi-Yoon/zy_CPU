/* Creator: ZY (Jiyoon An) */

module instruction_mem (
    input  wire        clk,
    input  wire [9:0]  i_addr,
    output reg  [31:0] o_dout
);
    // Vivado bram

    blk_mem_gen_0 u_bram (
    .clka(clk),
    .addra(i_addr),
    .douta(o_dout),
    .ena(1'b1),
    .wea(1'b0),
    .dina(32'b0)
    );

endmodule
