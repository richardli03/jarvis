/*
Combinational count ones util.

@param N The width of the input data.
*/

`begin_keywords "1800-2017"  // Use SystemVerilog 2017 keywords
`default_nettype none

module count_ones (
  input  wire [N-1:0]         data,
  output logic [COUNT_WIDTH:0] count
);
  timeunit 1ns; timeprecision 100ps;

  // parameters
  parameter N = 8;

  // local parameters
  localparam COUNT_WIDTH = $clog2(N);

  always_comb begin
    count = '0;
    for (int i = N - 1; i >= 0; i--) 
      if (data[i]) count++;
  end

endmodule : count_ones

`default_nettype wire `end_keywords
