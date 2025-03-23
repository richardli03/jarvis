/*
Demo uart module intended for synthesis.
*/

`begin_keywords "1800-2017"  // Use SystemVerilog 2017 keywords
`default_nettype none

module uart_loopback_demo #(
  parameter BUFFER_WIDTH = 8,
  parameter BAUD_RATE = 115_200,
  parameter CLK_FREQ = 125_000_000,
  parameter SYNC_DEPTH = 3,
  parameter OVERSAMPLING_DEPTH = 4
)
(
  input wire rst_n,
  input wire clk,
  input wire rx,
  output logic tx,
  output logic [3:0] test_data,
  output logic test_data_0, test_data_1, test_data_2
);
  timeunit 1ns; timeprecision 100ps;

  wire ready, valid;
  logic [7:0] data, next_data;

  // data buffer
  // allows for full duplex communication
  always_ff @( posedge clk ) begin
    if (!rst_n)
      data <= '0;
    else if (valid)
      data <= next_data;
    else
      data <= data;
      // rx_probe <= rx;
  end

  // uart periperal
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
    .read_data(next_data),
    .read_ready(ready),
    .read_valid(valid),
    .tx(tx),
    .write_data(data),
    .write_valid(valid),
    .write_ready(ready),
    .test_data(test_data),
    .test_data_0(test_data_0),
    .test_data_1(test_data_1),
    .test_data_2(test_data_2)
  );

endmodule : uart_loopback_demo

`default_nettype wire 
`end_keywords
