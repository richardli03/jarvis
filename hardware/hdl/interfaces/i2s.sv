/*
I2S Codec interface

@param BIT_DEPTH: The bit depth of the codec.
*/

`begin_keywords "1800-2017"  // Use SystemVerilog 2017 keywords
`default_nettype none

module i2s
#(
  parameter BIT_DEPTH = 24
)
(
  input wire rst_n,
  input wire clk,

  // i2s common
  output logic mclk,
  output logic blck,

  // i2s rx
  output logic rx,
  output logic rx_lr_clk,
  output logic [BIT_DEPTH-1:0] rx_data,
  input  wire  rx_ready,
  output logic rx_valid,

  // i2s tx
  input  wire  tx,
  output logic tx_lr_clk,
  input  logic [BIT_DEPTH-1:0] tx_data,
  input  wire  tx_ready,
  input  wire  tx_valid,

  // device specific //TODO: move to higher level module
  output logic mute
);
  timeunit 1ns; timeprecision 100ps;

  // local parameters
  localparam BUFFER_COUNTER_BITS = $clog2(BIT_DEPTH);

  // i2s states
  typedef enum logic [3:0] {
    RESET = 4'b0000,
    IDLE  = 4'b0001,
    LEFT  = 4'b0010,
    RIGHT = 4'b0100,
    ERROR = 4'b1000
  } i2s_state_t;

/* 
 * =============================================================================
 * receive
 * =============================================================================
 */

  // internal rx variables
  i2s_state_t rx_state, rx_next_state;
  logic [BUFFER_COUNTER_BITS-1:0] rx_bit_counter; 
  logic rx_shift_en, rx_bit_counter_rst_n;
  logic [BIT_DEPTH-1:0] input_buffer;

  // rx current state logic
  always_ff @( posedge clk ) begin : _rx_current_state_logic
    if (!rst_n)
      rx_state <= RESET;
    else
      rx_state <= rx_next_state;
  end

  // rx next state logic
  always_comb begin : _rx_next_state_logic
    unique case (rx_state)
      RESET:
        rx_next_state = LEFT;
      IDLE:
        rx_next_state = LEFT;
      LEFT:
        if (rx_bit_counter == '0)
          rx_next_state = RIGHT;
      RIGHT:
      if (rx_bit_counter == '0)
        rx_next_state = LEFT;
      ERROR:
        rx_next_state = ERROR;
      default:
        rx_next_state = ERROR; // catch glitches
    endcase
  end

  // rx fsm outputs
  always_comb begin : _rx_fsm_outputs
    unique case (rx_state)
      RESET, ERROR: {rx_shift_en, rx_bit_counter_rst_n} = 2'b01;
      IDLE: {rx_shift_en, rx_bit_counter_rst_n} = 2'b10;
      LEFT: {rx_shift_en, rx_bit_counter_rst_n} = 2'b11;
      RIGHT: {rx_shift_en, rx_bit_counter_rst_n} = 2'b11;
      default: {rx_shift_en, rx_bit_counter_rst_n} = 2'b01;
    endcase
  end

  // receive shift register
  always_ff @( posedge clk) begin : _rx_shift_register
    if (!rst_n)
      rx_data <= '0;
    else if (rx_shift_en)
      rx_data <= {rx_data[BIT_DEPTH-2:0], rx}; // msb first
    else
      rx_data <= rx_data;
  end

  // rx bit counter
  always_ff @( posedge clk ) begin : _rx_bit_counter
    if (!rx_bit_counter_rst_n)
      rx_bit_counter <= BIT_DEPTH;
    else if (rx_bit_counter == '0)
      rx_bit_counter <= BIT_DEPTH - 1;
    else
      rx_bit_counter <= rx_bit_counter - 1;
  end

endmodule : i2s

`default_nettype wire 
`end_keywords
