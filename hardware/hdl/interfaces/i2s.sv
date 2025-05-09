/*
I2S Codec interface.

Specifically written for the Analog Devices SSM2603.

@param BIT_DEPTH: The bit depth of the codec.
@param MCLK_FREQ: The MCLK frequency used for the codec and interface.
@param BCLK_DIV: The number of MCLK cycles per BCLK cycle.
@param LRCLK_DIV: The number of BCLK cycles per LRCLK cycle.
*/

`begin_keywords "1800-2017"  // Use SystemVerilog 2017 keywords
`default_nettype none

module i2s
#(
  parameter BIT_DEPTH = 24,
  parameter MCLK_FREQ = 12_288_000,
  parameter BCLK_DIV = 4,
  parameter LRCLK_DIV = 64
)
(
  input wire rst_n,

  // i2s common
  input  wire  mclk,
  output logic bclk,

  // i2s rx
  output logic rx,
  output logic rx_lrclk,
  output logic [BIT_DEPTH-1:0] rx_data,
  input  wire  rx_ready,
  output logic rx_valid,

  // i2s tx
  output logic tx,
  output logic tx_lrclk,
  input  logic [BIT_DEPTH-1:0] tx_data,
  output logic tx_ready,
  input  wire  tx_valid,

  // device specific //TODO: move to higher level module
  output logic mute
);
  timeunit 1ns; timeprecision 100ps;

/* 
 * =============================================================================
 * local parameters
 * =============================================================================
 */
  // general
  localparam BUFFER_COUNTER_BITS = $clog2(BIT_DEPTH);
  localparam WORD_LENGTH = LRCLK_DIV / 2;

  // clk dividers
  localparam BCLK_COUNTER_BITS = $clog2(BCLK_DIV);
  localparam LRCLK_COUNTER_BITS = $clog2(LRCLK_DIV);


/* 
 * =============================================================================
 * states
 * =============================================================================
 */
  // I2S states
  typedef enum logic [7:0] {
    RESET       = 8'b00000000,
    IDLE        = 8'b00000001,
    LEFT_START  = 8'b00000010,
    LEFT        = 8'b00000100,
    LEFT_IDLE   = 8'b00001000,
    RIGHT_START = 8'b00010000,
    RIGHT       = 8'b00100000,
    RIGHT_IDLE  = 8'b01000000,
    ERROR       = 8'b10000000
  } i2s_state_t;


/* 
 * =============================================================================
 * bclk clk divider
 * =============================================================================
 */
  logic [BCLK_COUNTER_BITS-1:0] bclk_counter;

  // bclk counter
  initial bclk_counter = '0;
  always_ff @( posedge mclk ) begin : _bclk_clk_counter
    if (bclk_counter == '0)
      bclk_counter <= (BCLK_COUNTER_BITS)'(LRCLK_DIV - 1);
    else
      bclk_counter <= bclk_counter - 1;
  end

  // bclk_output
  always_comb begin : _bclk_clk_divider
    if (bclk_counter[BCLK_COUNTER_BITS-1:0] >= (BCLK_COUNTER_BITS)'(BCLK_DIV / 2))
      bclk = 0;
    else
      bclk = 1;
  end

  // // TODO: synthesis difference between this and the block above
  // always_ff @( posedge mclk ) begin : _bclk_clk_divider
  //   if (!rst_n)
  //     bclk <= 0;
  //   else if (bclk_counter[BCLK_COUNTER_BITS-1:0] >= (BCLK_COUNTER_BITS)'(BCLK_DIV / 2))
  //     bclk <= 0;
  //   else
  //     bclk <= 1;
  // end

  // inverted bclk output
  logic bclk_inv;
  always_comb begin : _bclk_inv_clk_divider
    if (bclk_counter[BCLK_COUNTER_BITS-1:0] >= (BCLK_COUNTER_BITS)'(BCLK_DIV / 2))
      bclk_inv = 1;
    else
      bclk_inv = 0;
  end

/* 
 * =============================================================================
 * receive
 * =============================================================================
 */

  // internal rx variables
  i2s_state_t rx_state, rx_next_state;
  logic [BUFFER_COUNTER_BITS-1:0] rx_bit_counter; 
  logic rx_shift_en, rx_bit_counter_rst_n;

  // rx current state logic
  initial rx_state = RESET;
  always_ff @( posedge bclk ) begin : _rx_current_state_logic
    if (!rst_n)
      rx_state <= RESET;
    else
      rx_state <= rx_next_state;
  end

  // rx next state logic
  always_comb begin : _rx_next_state_logic
    unique case (rx_state)
      RESET:
        rx_next_state = LEFT_START;
      IDLE:
        rx_next_state = LEFT_START;
      LEFT_START:
        if (rx_lrclk_counter == (LRCLK_COUNTER_BITS)'(LRCLK_DIV - 2))
          rx_next_state = LEFT;
      LEFT:
        if (rx_bit_counter == '0)
          rx_next_state = LEFT_IDLE;
      LEFT_IDLE:
        if (rx_lrclk_counter == (LRCLK_COUNTER_BITS)'((LRCLK_DIV/2) - 1))
          rx_next_state = RIGHT_START;
      RIGHT_START:
        rx_next_state = RIGHT;
      RIGHT:
        if (rx_bit_counter == '0)
          rx_next_state = RIGHT_IDLE;
      RIGHT_IDLE:
        if (rx_lrclk_counter == 0)
          rx_next_state = LEFT_START;
      ERROR:
        rx_next_state = ERROR;
      default:
        rx_next_state = ERROR; // catch glitches
    endcase
  end

  // rx fsm outputs
  always_comb begin : _rx_fsm_outputs
    unique case (rx_state)
      RESET, ERROR: begin
        {rx_shift_en, rx_bit_counter_rst_n} = 2'b00;
        {rx_lrclk_rst_n} = 1'b0;
        {rx_valid} = 1'b0;
      end
      IDLE: begin
        {rx_shift_en, rx_bit_counter_rst_n} = 2'b00;
        {rx_lrclk_rst_n} = 1'b0;
        {rx_valid} = 1'b0;
      end
      LEFT_START: begin
        {rx_shift_en, rx_bit_counter_rst_n} = 2'b00;
        {rx_lrclk_rst_n} = 1'b1;
        {rx_valid} = 1'b1;  // TODO: this will not be valid first sample after reset
      end
      LEFT: begin
        {rx_shift_en, rx_bit_counter_rst_n} = 2'b11;
        {rx_lrclk_rst_n} = 1'b1;
        {rx_valid} = 1'b0;
      end
      LEFT_IDLE: begin
        {rx_shift_en, rx_bit_counter_rst_n} = 2'b00;
        {rx_lrclk_rst_n} = 1'b1;
        {rx_valid} = 1'b1;
      end
      RIGHT_START: begin
        {rx_shift_en, rx_bit_counter_rst_n} = 2'b00;
        {rx_lrclk_rst_n} = 1'b1;
        {rx_valid} = 1'b1;  // TODO: this will not be valid first sample after reset
      end
      RIGHT: begin
        {rx_shift_en, rx_bit_counter_rst_n} = 2'b11;
        {rx_lrclk_rst_n} = 1'b1;
        {rx_valid} = 1'b0;
      end
      RIGHT_IDLE: begin
        {rx_shift_en, rx_bit_counter_rst_n} = 2'b00;
        {rx_lrclk_rst_n} = 1'b1;
        {rx_valid} = 1'b1;
      end
      default: begin
        {rx_shift_en, rx_bit_counter_rst_n} = 2'b00;
        {rx_lrclk_rst_n} = 1'b0;
        {rx_valid} = 1'b0;
      end
    endcase
  end

  // rx shift register
  always_ff @( posedge bclk ) begin : _rx_shift_register
    if (!rst_n)
      rx_data <= '0;
    else if (rx_shift_en)
      rx_data <= {rx_data[BIT_DEPTH-2:0], rx}; // msb first
    else
      rx_data <= rx_data;
  end

  // rx bit counter
  always_ff @( posedge bclk ) begin : _rx_bit_counter
    if (!rx_bit_counter_rst_n)
      rx_bit_counter <= BIT_DEPTH - 1;
    else if (rx_bit_counter == '0)
      rx_bit_counter <= BIT_DEPTH - 1;
    else
      rx_bit_counter <= rx_bit_counter - 1;
  end

  logic rx_lrclk_rst_n;
  logic [LRCLK_COUNTER_BITS-1:0] rx_lrclk_counter;

  // rx lrclk counter
  always_ff @( posedge bclk ) begin : _rx_lrclk_clk_counter
    if (!rx_lrclk_rst_n)
      rx_lrclk_counter <= 0;
    else if (rx_lrclk_counter == '0)
      rx_lrclk_counter <= (LRCLK_COUNTER_BITS)'(LRCLK_DIV - 1);
    else
      rx_lrclk_counter <= rx_lrclk_counter - 1;
  end

  // rx lrclk output
  always_comb begin : _rx_lrclk_clk_div
    if (!rx_lrclk_rst_n)
      rx_lrclk = 1;
    else if (rx_lrclk_counter[LRCLK_COUNTER_BITS-1:0] >= (LRCLK_COUNTER_BITS)'(LRCLK_DIV / 2))
      rx_lrclk = 0;
    else
      rx_lrclk = 1;
  end


/* 
 * =============================================================================
 * transmit
 * =============================================================================
 */

  // internal tx variables
  i2s_state_t tx_state, tx_next_state;
  logic [BUFFER_COUNTER_BITS-1:0] tx_bit_counter; 
  logic tx_shift_en, tx_bit_counter_rst_n;

  // tx current state logic
  initial tx_state = RESET;
  always_ff @( posedge bclk_inv ) begin : _tx_current_state_logic
    if (!rst_n)
      tx_state <= RESET;
    else
      tx_state <= tx_next_state;
  end

  // tx next state logic
  always_comb begin : _tx_next_state_logic
    unique case (tx_state)
      RESET:
        tx_next_state = IDLE;
      IDLE:
        if (tx_valid) // TODO: may prevent state transition
          tx_next_state = LEFT_START;
      LEFT_START:
        if (tx_lrclk_counter == (LRCLK_COUNTER_BITS)'(LRCLK_DIV - 2))
          tx_next_state = LEFT;
      LEFT:
        if (tx_bit_counter == '0)
          tx_next_state = LEFT_IDLE;
      LEFT_IDLE:
        if ((tx_lrclk_counter == (LRCLK_COUNTER_BITS)'((LRCLK_DIV/2) - 1)) && tx_valid) // TODO: may prevent state transition
          tx_next_state = RIGHT_START;
      RIGHT_START:
        tx_next_state = RIGHT;
      RIGHT:
        if (tx_bit_counter == '0)
          tx_next_state = RIGHT_IDLE;
      RIGHT_IDLE:
        if ((tx_lrclk_counter == 0) && tx_ready) // TODO: may prevent state transition
          tx_next_state = LEFT_START;
      ERROR:
        tx_next_state = ERROR;
      default:
        tx_next_state = ERROR; // catch glitches
    endcase
  end

  // tx fsm outputs
  always_comb begin : _tx_fsm_outputs
    unique case (tx_state)
      RESET, ERROR: begin
        {tx_shift_en, tx_bit_counter_rst_n} = 2'b00;
        {tx_lrclk_rst_n} = 1'b0;
        {tx_ready} = 1'b0;
      end
      IDLE: begin
        {tx_shift_en, tx_bit_counter_rst_n} = 2'b00;
        {tx_lrclk_rst_n} = 1'b0;
        {tx_ready} = 1'b1;
      end
      LEFT_START: begin
        {tx_shift_en, tx_bit_counter_rst_n} = 2'b00;
        {tx_lrclk_rst_n} = 1'b1;
        {tx_ready} = 1'b0;  
      end
      LEFT: begin
        {tx_shift_en, tx_bit_counter_rst_n} = 2'b11;
        {tx_lrclk_rst_n} = 1'b1;
        {tx_ready} = 1'b0;
      end
      LEFT_IDLE: begin
        {tx_shift_en, tx_bit_counter_rst_n} = 2'b00;
        {tx_lrclk_rst_n} = 1'b1;
        {tx_ready} = 1'b1;
      end
      RIGHT_START: begin
        {tx_shift_en, tx_bit_counter_rst_n} = 2'b00;
        {tx_lrclk_rst_n} = 1'b1;
        {tx_ready} = 1'b0;
      end
      RIGHT: begin
        {tx_shift_en, tx_bit_counter_rst_n} = 2'b11;
        {tx_lrclk_rst_n} = 1'b1;
        {tx_ready} = 1'b0;
      end
      RIGHT_IDLE: begin
        {tx_shift_en, tx_bit_counter_rst_n} = 2'b00;
        {tx_lrclk_rst_n} = 1'b1;
        {tx_ready} = 1'b1;
      end
      default: begin
        {tx_shift_en, tx_bit_counter_rst_n} = 2'b00;
        {tx_lrclk_rst_n} = 1'b0;
        {tx_ready} = 1'b0;
      end
    endcase
  end

  // tx shift register
  always_ff @( posedge bclk_inv ) begin : _tx_shift_register
    if (!rst_n)
      tx <= '0;
    else if (tx_shift_en)
      tx <= tx_data[tx_bit_counter]; // msb first
    else
      tx <= tx;
  end

  // tx bit counter
  always_ff @( posedge bclk_inv ) begin : _tx_bit_counter
    if (!tx_bit_counter_rst_n)
      tx_bit_counter <= BIT_DEPTH - 1;
    else if (tx_bit_counter == '0)
      tx_bit_counter <= BIT_DEPTH - 1;
    else
      tx_bit_counter <= tx_bit_counter - 1;
  end

  logic tx_lrclk_rst_n;
  logic [LRCLK_COUNTER_BITS-1:0] tx_lrclk_counter;

  // tx lrclk counter
  always_ff @( posedge bclk ) begin : _tx_lrclk_clk_counter
    if (!tx_lrclk_rst_n)
      tx_lrclk_counter <= 0;
    else if (tx_lrclk_counter == '0)
      tx_lrclk_counter <= (LRCLK_COUNTER_BITS)'(LRCLK_DIV - 1);
    else
      tx_lrclk_counter <= tx_lrclk_counter - 1;
  end

  // tx lrclk output
  always_comb begin : _tx_lrclk_clk_div
    if (!tx_lrclk_rst_n)
      tx_lrclk = 1;
    else if (tx_lrclk_counter[LRCLK_COUNTER_BITS-1:0] >= (LRCLK_COUNTER_BITS)'(LRCLK_DIV / 2))
      tx_lrclk = 0;
    else
      tx_lrclk = 1;
  end

endmodule : i2s

`default_nettype wire 
`end_keywords
