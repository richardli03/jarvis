/*
description

@param A_PARAMETER
*/

`begin_keywords "1800-2017"  // Use SystemVerilog 2017 keywords
`default_nettype none

module template (
  input logic rst_n,
  input logic clk
);
  timeunit 1ns; timeprecision 100ps;

  // parameters
  parameter A_PARAMETER = 8;

  // local parameters
  localparam ANOTHER_PARAMETER = $clog2(A_PARAMETER);

/* 
 * =============================================================================
 * section header
 * =============================================================================
 */

endmodule : template

`default_nettype wire 
`end_keywords
