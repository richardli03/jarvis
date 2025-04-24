/*
I2S Codec interface

@param A_PARAMETER
*/

`begin_keywords "1800-2017"  // Use SystemVerilog 2017 keywords
`default_nettype none

module i2s
#(
  parameter BIT_WIDTH = 24
  // parameter 
)
(
  input logic rst_n,
  input logic clk,

  // i2s common
  output mclk,
  output blck,

  // i2s rx
  output rx_lr_clk,
  input rx_data,

  // i2s tx
  output tx_lr_clk,
  output tx_data,

  // device specific //TODO: move to higher level module
  output mute


);
  timeunit 1ns; timeprecision 100ps;

  // local parameters
  localparam BUFFER_COUNTER_BITS = $clog2(BIT_WIDTH);

  // i2s states
  typedef enum logic [2:0] {
    RESET = 3'b000,
    LEFT  = 3'b001,
    RIGHT = 3'b010,
    ERROR = 3'b100
  } i2s_state_t;

/* 
 * =============================================================================
 * receive
 * =============================================================================
 */

  // internal rx variables
  i2s_state_t rx_state, rx_next_state;
  logic rx_shift_en, rx_bit_counter_rst_n;

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
      LEFT:
        rx_next_state = RIGHT;
      RIGHT:
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
  end

  // receive shift register
  always_ff @( posedge bclk) begin : _rx_shift_register
    if (!rst_n)
      rx_data <= '0;
    else if (rx_shift_en)
      rx_data <= {rx_data[], rx_data} // msb first
    else
      rx_data <= rx_data;
  end

  

endmodule : i2s

`default_nettype wire 
`end_keywords
