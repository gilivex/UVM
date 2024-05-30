//mine alu module for testing
module uart #(
) (
    clk,
    rst,
    data_in,
    get_bit,
    data_out
);

  input [7:0] data_in ;
  input get_bit;
   input clk, rst_n;
  output reg [WIDTH:0] Y;

  always @(posedge clk or negedge rst_n)
    if (!rst_n) Y = 0;
    else begin
      case (mode)
        0: Y = A + B;
        1: Y = A - B;
        2: Y = A + 1;
        3: Y = B + 1;
      endcase

    end

endmodule
