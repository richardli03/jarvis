/*
Generic uart main
*/

`begin_keywords "1800-2017"  // Use SystemVerilog 2017 keywords
`default_nettype none

module uart_main (
    input logic rst_n,
    input logic clk,

    // uart // TODO: split based on rx tx
    input  logic rx,
    output logic tx,
    input  logic mode,       // determines read/write
    output logic read_data,
    input  logic write_data,

    // ready-valid
    input  logic read_ready,
    input  logic write_valid,
    output logic read_valid,
    output logic write_ready
);
  timeunit 1ns; timeprecision 100ps;

  // parameters
  parameter BUFFER_WIDTH = 8;  // input and ouput fifo widths
  parameter BAUD_RATE = 115200;

  // local parameters
  localparam BUFFER_COUNTER_BITS = $clog2(BUFFER_WIDTH);

  // uart read states
  typedef enum logic [3:0] {
    RESET = 4'b0000,
    IDLE  = 4'b0001,
    START = 4'b0010,
    READ  = 4'b0100,
    ERROR = 4'b1000
  } uart_rx_state_t;

  // internal state variables
  uart_rx_state_t rx_state, rx_next_state;
  logic [BUFFER_COUNTER_BITS-1:0] rx_counter;

  // rx current state logic
  always_ff @(posedge clk or negedge rst_n)
    if (!rst_n) rx_state <= RESET;
    else rx_state <= rx_next_state;

  // next state logic
  always_ff @(posedge clk)
    unique case (rx_state)
      RESET: rx_next_state <= RESET;
      IDLE:
        if (!rx)
          rx_next_state <= START;
        else
          rx_next_state <= IDLE;
      START:
        rx_next_state <= READ;
      READ:
        if (rx_counter  == '0)
          rx_next_state <= IDLE;
        else
          rx_next_state <= READ;
      ERROR:
        rx_next_state <= ERROR;
      default:
        rx_next_state <= ERROR; // catch glitches

    endcase

  // fsm outputs


endmodule : uart_main

`default_nettype wire `end_keywords
