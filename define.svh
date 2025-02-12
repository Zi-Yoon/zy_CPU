/* Creator: ZY (Jiyoon An) */

`ifndef DEFINE_SVH
`define DEFINE_SVH

// my parameters
parameter ALU_OP = 5;
parameter OPCODE = 7;
parameter FUNCT3 = 3;
parameter FUNCT7 = 7;
parameter IMM_SEL = 3;
parameter TRUE  = 1;
parameter FALSE = 0;

// Parameter definitions
parameter DATA_WIDTH = 32;
parameter ADDR_WIDTH = 16;
parameter CACHE_SIZE = 1024;

// ALU Operations
parameter ALU_ADD = 4'b0000;
parameter ALU_SUB = 4'b0001;
parameter ALU_AND = 4'b0010;
parameter ALU_OR  = 4'b0011;
parameter ALU_XOR = 4'b0100;
parameter ALU_SLL = 4'b0101;
parameter ALU_SRL = 4'b0110;
parameter ALU_SRA = 4'b0111;
parameter ALU_X   = 4'bxxxx;


// Immediate Select
paramemter IMM_I = 3'b000;
paramemter IMM_S = 3'b001;
paramemter IMM_B = 3'b010;
paramemter IMM_U = 3'b011;
paramemter IMM_J = 3'b100;

// Macro definitions
`define ENABLE  1'b1
`define DISABLE 1'b0

`endif