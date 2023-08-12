`define I_TYPE 0
`define B_TYPE 1
`define S_TYPE 2
`define U_TYPE 3
`define J_TYPE 4

module Immediate_Generator 
(
    input [31 : 0] instruction,
    input [2 : 0] instruction_type,

    output reg [31 : 0] immediate
);

always @(*) begin
      case (instruction_type)
            `I_TYPE:  immediate = { {21{instruction[31]}}, instruction[30 : 20] };
            `B_TYPE:  immediate = { {20{instruction[31]}}, instruction[7], instruction[30 : 25], instruction[11 : 8], 1'b0 };
            `S_TYPE:  immediate = { {21{instruction[31]}}, instruction[30 : 25], instruction[11 : 8], instruction[7] };
            `U_TYPE:  immediate = { instruction[31], instruction[30 : 20], instruction [19 : 12], {13{1'b0}} };
            `J_TYPE:  immediate = { {12{instruction[31]}}, instruction[19 : 12], instruction[20], instruction[30 : 25], instruction[24 : 21], 1'b0};
            default:  immediate = { 32{1'bz} };
      endcase
end

endmodule