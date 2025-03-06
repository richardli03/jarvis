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
  localparam [CLK_CYCLE_COUNTER_BITS-1:0] CLK_CYCLES_TIL_SAMPLE = (CLK_CYCLE_COUNTER_BITS)'(CLK_CYCLES_PER_BIT / 2); // determines when to sample

  // uart read states TODO: Move to package
  typedef enum logic [3:0] {
    RX_RESET = 4'b0000,
    RX_IDLE  = 4'b0001,
    RX_START = 4'b0010,
    RX_READ  = 4'b0100,
    RX_ERROR = 4'b1000
  } uart_rx_state_t;

  // uart write states TODO: Move to package
  typedef enum logic [3:0] {
    TX_RESET = 4'b0000,
    TX_IDLE  = 4'b0001,
    TX_START = 4'b0010,
    TX_WRITE = 4'b0100,
    TX_ERROR = 4'b1000
  } uart_tx_state_t;

/* 
 * =======================================
 * Receive
 * =======================================
 */

  // internal rx state variables
  uart_rx_state_t rx_state, rx_next_state;
  logic [BUFFER_COUNTER_BITS:0] rx_bit_counter;
  logic [CLK_CYCLE_COUNTER_BITS-1:0] rx_clk_counter;
  logic rx_shift_en, rx_bit_counter_rst_n, rx_clk_counter_rst_n;

  // rx current state logic
  always_ff @( posedge clk ) begin : _rx_current_state_logic
    if (!rst_n)
      rx_state <= RX_RESET;
    else 
      rx_state <= rx_next_state;
  end

  // rx next state logic
  always_comb begin : _rx_next_state_logic
    unique case (rx_state)
      RX_RESET:
        rx_next_state = RX_IDLE;
      RX_IDLE:
        if (!rx)
          rx_next_state = RX_START;
        else
          rx_next_state = RX_IDLE;
      RX_START:
        if (rx_clk_counter == '0)
          rx_next_state = RX_READ;
        else
          rx_next_state = RX_START;
      RX_READ:
        if (rx_bit_counter  == '0)
          rx_next_state = RX_IDLE;
        else
          rx_next_state = RX_READ;
      RX_ERROR:
        rx_next_state = RX_ERROR;
      default:
        rx_next_state = RX_ERROR; // catch glitches
    endcase
  end

  // rx fsm outputs
  always_comb begin : _rx_fsm_outputs
    unique case (rx_state)
      RX_RESET, RX_ERROR: begin
        {rx_clk_counter_rst_n, rx_bit_counter_rst_n} = 2'b00;
        {rx_shift_en, read_valid} = 2'b00;
      end
      RX_IDLE: begin
        {rx_shift_en, read_valid} = 2'b01;
        {rx_clk_counter_rst_n, rx_bit_counter_rst_n} = 2'b00;
      end
      RX_START: begin
        {rx_shift_en, read_valid} = 2'b00;
        {rx_clk_counter_rst_n, rx_bit_counter_rst_n} = 2'b10;
      end
      RX_READ: begin
        {rx_shift_en, read_valid} = 2'b10;
        {rx_clk_counter_rst_n, rx_bit_counter_rst_n} = 2'b11;
      end
      default: begin 
        {rx_shift_en, read_valid} = 2'b00;
        {rx_clk_counter_rst_n, rx_bit_counter_rst_n} = 2'b00;
      end
    endcase
  end

  // rx shift register
  always_ff @( posedge clk ) begin : _rx_shift_register
    if (!rst_n)
      read_data <= '0;
    else if (rx_shift_en & rx_clk_counter == CLK_CYCLES_TIL_SAMPLE)
      read_data <= {rx, read_data[BUFFER_WIDTH-1:1]}; // lsb first
    else
      read_data <= read_data;
  end

  // rx bit counter
  always_ff @( posedge clk ) begin : _rx_bit_counter
    if (!rx_bit_counter_rst_n)
      rx_bit_counter <= (BUFFER_COUNTER_BITS + 1)'(BUFFER_WIDTH);
    else if (rx_bit_counter == '0)
      rx_bit_counter <= (BUFFER_COUNTER_BITS + 1)'(BUFFER_WIDTH);
    else if (rx_clk_counter == CLK_CYCLES_TIL_SAMPLE)
      rx_bit_counter <= rx_bit_counter - 1;
  end

  // rx clock cycle counter
  always_ff @( posedge clk ) begin : _rx_clock_cycle_counter
    if (!rx_clk_counter_rst_n) begin
      rx_clk_counter <= CLK_CYCLE_COUNTER_BITS'(CLK_CYCLES_PER_BIT - 1);
    end else if (rx_clk_counter == '0) begin
      rx_clk_counter <= CLK_CYCLE_COUNTER_BITS'(CLK_CYCLES_PER_BIT - 1);
    end else begin
      rx_clk_counter <= rx_clk_counter - 1;
    end
  end

// /* 
//  * =======================================
//  * Transceive
//  * =======================================
//  */

//   // internal tx state variables
//   uart_tx_state_t tx_state, tx_next_state;
//   logic [BUFFER_COUNTER_BITS:0] tx_bit_counter;
//   logic [CLK_CYCLE_COUNTER_BITS-1:0] tx_clk_counter;
//   logic tx_shift_en, tx_bit_counter_rst_n, tx_clk_counter_rst_n;

//   // tx current state logic
//   always_ff @( posedge clk ) begin : _tx_current_state_logic
//     if (!rst_n)
//       tx_state <= RX_RESET;
//     else 
//       tx_state <= tx_next_state;
//   end

//   // tx next state logic
//   always_comb begin : _tx_next_state_logic
//     unique case (tx_state)
//       RX_RESET:
//         tx_next_state = RX_IDLE;
//       RX_IDLE:
//         if (!tx)
//           tx_next_state = RX_START;
//         else
//           tx_next_state = RX_IDLE;
//       RX_START:
//         if (tx_clk_counter == '0)
//           tx_next_state = RX_READ;
//         else
//           tx_next_state = RX_START;
//       RX_READ:
//         if (tx_bit_counter  == '0)
//           tx_next_state = RX_IDLE;
//         else
//           tx_next_state = RX_READ;
//       RX_ERROR:
//         tx_next_state = RX_ERROR;
//       default:
//         tx_next_state = RX_ERROR; // catch glitches
//     endcase
//   end

//   // tx fsm outputs
//   always_comb begin : _tx_fsm_outputs
//     unique case (tx_state)
//       RX_RESET, RX_ERROR: begin
//         {tx_clk_counter_rst_n, tx_bit_counter_rst_n} = 2'b00;
//         {tx_shift_en, read_valid} = 2'b00;
//       end
//       RX_IDLE: begin
//         {tx_shift_en, read_valid} = 2'b01;
//         {tx_clk_counter_rst_n, tx_bit_counter_rst_n} = 2'b00;
//       end
//       RX_START: begin
//         {tx_shift_en, read_valid} = 2'b00;
//         {tx_clk_counter_rst_n, tx_bit_counter_rst_n} = 2'b10;
//       end
//       RX_READ: begin
//         {tx_shift_en, read_valid} = 2'b10;
//         {tx_clk_counter_rst_n, tx_bit_counter_rst_n} = 2'b11;
//       end
//       default: begin 
//         {tx_shift_en, read_valid} = 2'b00;
//         {tx_clk_counter_rst_n, tx_bit_counter_rst_n} = 2'b00;
//       end
//     endcase
//   end

//   // tx shift register
//   always_ff @( posedge clk ) begin : _tx_shift_register
//     if (!rst_n)
//       read_data <= '0;
//     else if (tx_shift_en & tx_clk_counter == CLK_CYCLES_TIL_SAMPLE)
//       read_data <= {tx, read_data[BUFFER_WIDTH-1:1]}; // lsb first
//     else
//       read_data <= read_data;
//   end

//   // tx bit counter
//   always_ff @( posedge clk ) begin : _tx_bit_counter
//     if (!tx_bit_counter_rst_n)
//       tx_bit_counter <= (BUFFER_COUNTER_BITS + 1)'(BUFFER_WIDTH);
//     else if (tx_bit_counter == '0)
//       tx_bit_counter <= (BUFFER_COUNTER_BITS + 1)'(BUFFER_WIDTH);
//     else if (tx_clk_counter == CLK_CYCLES_TIL_SAMPLE)
//       tx_bit_counter <= tx_bit_counter - 1;
//   end

//   // tx clock cycle counter
//   always_ff @( posedge clk ) begin : _tx_clock_cycle_counter
//     if (!tx_clk_counter_rst_n) begin
//       tx_clk_counter <= CLK_CYCLE_COUNTER_BITS'(CLK_CYCLES_PER_BIT - 1);
//     end else if (tx_clk_counter == '0) begin
//       tx_clk_counter <= CLK_CYCLE_COUNTER_BITS'(CLK_CYCLES_PER_BIT - 1);
//     end else begin
//       tx_clk_counter <= tx_clk_counter - 1;
//     end
//   end

endmodule : uart_main

`default_nettype wire 
`end_keywords
