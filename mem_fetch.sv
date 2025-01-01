/* Creator: ZY (Jiyoon An) */

module mem_fetch (
    input clk,
    input rstn,
    input  [31:0] i_pc, // from PC reg
    output [31:0] o_instr
);

    wire [ 9:0] w_mem_addr = i_pc[11:2]; // 10-bit => 1024 Words(4-Byte)
    wire [31:0] w_mem_dout;

    // 1-Cycle delay
    instruction_mem u_imem (
        .clk (clk),
        .addr(w_mem_addr),
        .dout(w_mem_dout)
    );

    assign o_instr = w_mem_dout;

endmodule
