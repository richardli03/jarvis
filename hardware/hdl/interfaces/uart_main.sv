/*
Full-duplex uart main

@param BUFFER_WIDTH: The number of 
*/

`begin_keywords "1800-2017"  // Use SystemVerilog 2017 keywords
`default_nettype none

module uart_main (
    input logic rst_n,
    input logic clk,
    input logic mode,   // determines read/write

    // uart rx
    input  logic rx,
    output logic [BUFFER_WIDTH-1:0] read_data,
    input  logic read_ready,
    output logic read_valid,

    // uart tx
    output logic tx,
    input  logic [BUFFER_WIDTH-1:0] write_data,
    input  logic write_valid,
    output logic write_ready
);
  timeunit 1ns; timeprecision 100ps;

  // parameters
  parameter BUFFER_WIDTH = 8;  // input and ouput fifo widths
  parameter BAUD_RATE = 115_200;
  parameter CLK_FREQ = 12_000_000;

  // local parameters
  localparam BUFFER_COUNTER_BITS = $clog2(BUFFER_WIDTH);
  localparam CLK_CYCLES_PER_BIT = CLK_FREQ / BAUD_RATE;
  localparam CLK_CYCLE_COUNTER_BITS = $clog2(CLK_CYCLES_PER_BIT);
  localparam [CLK_CYCLE_COUNTER_BITS-1:0] CLK_CYCLES_TIL_SAMPLE = (CLK_CYCLE_COUNTER_BITS)'($clog2(CLK_CYCLES_PER_BIT / 2)); // determines when to sample

  // uart read states TODO: Move to package
  typedef enum logic [3:0] {
    RESET = 4'b0000,
    IDLE  = 4'b0001,
    START = 4'b0010,
    READ  = 4'b0100,
    ERROR = 4'b1000
  } uart_rx_state_t;

  // internal rx state variables
  uart_rx_state_t rx_state, rx_next_state;
  logic [BUFFER_COUNTER_BITS-1:0] rx_bit_counter;
  logic [CLK_CYCLE_COUNTER_BITS-1:0] rx_clk_counter;
  logic uart_clk, sample_clk, rx_shift_en, rx_bit_counter_rst_n, rx_clk_counter_rst_n;

  // rx current state logic
  always_ff @( posedge clk ) begin : _rx_current_state_logic
    if (!rst_n)
      rx_state <= RESET;
    else 
      rx_state <= rx_next_state;
  end

  // rx next state logic
  always_ff @( posedge uart_clk ) begin : _rx_next_state_logic
    unique case (rx_state)
      RESET:
        rx_next_state <= IDLE;
      IDLE:
        if (!rx)
          rx_next_state <= START;
        else
          rx_next_state <= IDLE;
      START:
        rx_next_state <= READ;
      READ:
        if (rx_bit_counter  == '0)
          rx_next_state <= IDLE;
        else
          rx_next_state <= READ;
      ERROR:
        rx_next_state <= ERROR;
      default:
        rx_next_state <= ERROR; // catch glitches
    endcase
  end

  // rx fsm outputs
  always_comb begin : _rx_fsm_outputs
    unique case (rx_state)
      RESET, ERROR: {rx_shift_en, rx_clk_counter_rst_n, read_valid} = 3'b000;
      START: {rx_shift_en, rx_clk_counter_rst_n, read_valid} = 3'b010;
      IDLE: {rx_shift_en, rx_clk_counter_rst_n, read_valid} = 3'b001;
      READ: {rx_shift_en, rx_clk_counter_rst_n, read_valid} = 3'b100;
      default: {rx_shift_en, rx_clk_counter_rst_n, read_valid} = 3'b000;
    endcase
  end

  // rx shift register
  always_ff @( posedge sample_clk ) begin : _rx_shift_register
    if (!rst_n)
      read_data <= '0;
    else if (rx_shift_en)
      read_data <= {rx, read_data[BUFFER_WIDTH-1:1]}; // lsb first
    else
      read_data <= read_data;
  end

  // rx bit counter
  always_ff @( posedge sample_clk ) begin : _rx_bit_counter
    if (!rx_bit_counter_rst_n)
      rx_bit_counter <= '1;
    if (rx_bit_counter == '0)
      rx_bit_counter <= '1;
    else
      rx_bit_counter <= rx_bit_counter - 1;
  end

  // rx clock cycle counter
  always_ff @( posedge clk ) begin : _rx_clock_cycle_counter
    if (!rx_clk_counter_rst_n) begin
      rx_clk_counter <= '1;
      uart_clk <= 0;
      sample_clk <= 0;
    end else if (rx_clk_counter == '0) begin
      rx_clk_counter <= '1;
      uart_clk <= uart_clk ^ 1'b1;
    end else if (rx_clk_counter == CLK_CYCLES_TIL_SAMPLE) begin
      sample_clk <= sample_clk ^ 1'b1;
    end else begin
      rx_clk_counter <= rx_clk_counter - 1;
    end
  end

endmodule : uart_main

`default_nettype wire 
`end_keywords
