/* Creator: ZY (Jiyoon An) */

`ifndef DEFINE_SVH
`define DEFINE_SVH

// my parameters
parameter ALU_OP = 5;
parameter OPCODE = 7;
parameter FUNCT3 = 3;
parameter FUNCT7 = 7;
parameter IMM_SEL = 3; // I, S, B, U, J

// Parameter definitions
parameter DATA_WIDTH = 32;
parameter ADDR_WIDTH = 16;
parameter CACHE_SIZE = 1024;


// Macro definitions
`define ENABLE  1'b1
`define DISABLE 1'b0

`endif