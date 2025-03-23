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

  // data new flag
  logic data_new, previous_ready,previous_valid, ready_negative_edge, valid_positive_edge;

  // ready positive and valid negative edge detectors
  always_ff @( posedge clk ) begin
    previous_ready <= ready;
    previous_valid <= valid;
  end
  assign ready_negative_edge = previous_ready & !ready;
  assign valid_positive_edge = !previous_valid & valid;
  
  always_ff @( posedge clk ) begin
    if (!rst_n)
      data_new <= '0;
    else if (ready_negative_edge)
      data_new <= '0;
    else if (valid_positive_edge)
      data_new <= '1;
    else
      data_new <= data_new;
  end

  // // valid positive edge dectector
  // // determines when new data is received on rx
  // logic tx_en, valid_positive_edge,valid_negative_edge, previous_valid, data_new;
  // always_ff @ ( posedge clk ) previous_valid <= valid;
  // assign valid_positive_edge = !previous_valid & valid;
  // assign valid_negative_edge = previous_valid & !valid;
  // always_ff @( posedge clk ) begin
  //   if (!rst_n)
  //     data_new <= 0;
  //   else if (valid_positive_edge)
  //     tx_en <= 1;
  //   else if (valid_negative_edge)
  //     tx_en <= 0;
  //   else
  //     tx_en <= tx_en; 
  // end


  // data buffer
  // allows for full duplex communication
  always_ff @( posedge clk ) begin
    if (!rst_n)
      data <= '0;
    else if (ready & valid)
      data <= next_data;
    // else
    //   data <= data;
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
    // .tx_en(tx_en),
    .write_data(data),
    .write_valid(data_new),
    .write_ready(ready),
    .test_data(test_data),
    .test_data_0(test_data_0),
    .test_data_1(test_data_1),
    .test_data_2(test_data_2)
  );

endmodule : uart_loopback_demo

`default_nettype wire 
`end_keywords
