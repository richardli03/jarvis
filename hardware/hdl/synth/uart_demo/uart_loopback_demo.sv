/*
Demo uart module intended for synthesis.
*/

`begin_keywords "1800-2017"  // Use SystemVerilog 2017 keywords
`default_nettype none

module uart_loopback_demo #(
  parameter BUFFER_WIDTH = 8,
  parameter BAUD_RATE = 115_200,
  parameter CLK_FREQ = 12_000_000,
  parameter SYNC_DEPTH = 3,
  parameter OVERSAMPLING_DEPTH = 4
)
(
  input logic rst_n,
  input logic clk,
  input logic rx,
  output logic tx
);
  timeunit 1ns; timeprecision 100ps;

  wire ready, valid;
  logic [7:0] data;

  uart #(
    .BUFFER_WIDTH(BUFFER_WIDTH),
    .BAUD_RATE(BAUD_RATE),
    .CLK_FREQ(CLK_FREQ),
    .SYNC_DEPTH(SYNC_DEPTH),
    .OVERSAMPLING_DEPTH(OVERSAMPLING_DEPTH)
  ) 
  uart_0 (
    .rst_n(rst_n),
    .clk(clk),
    .rx(rx),
    .read_data(data),
    .read_ready(ready),
    .read_valid(valid),
    .tx(tx),
    .write_data(data),
    .write_valid(valid),
    .write_ready(ready)
  );

endmodule : uart_loopback_demo

`default_nettype wire `end_keywords
