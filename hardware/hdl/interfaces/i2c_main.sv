/*
I2C main.

@param 
*/

`begin_keywords "1800-2017"  // Use SystemVerilog 2017 keywords
`default_nettype none

module i2c
#(
  parameter CLK_FREQ = 125_000_000,
  parameter SCL_FREQ = 400_000,
  parameter DEVICE_ADDR_WIDTH = 7,
  parameter DEVICE_ADDR = 'b001_1010,
  parameter REGISTER_ADDR_WIDTH = 7,
  parameter DATA_WIDTH = 9
)
(
  input  wire  rst_n,
  input  wire  clk,
  output logic sda,
  output logic scl,
  output logic ready,
  input  wire  valid
);
  timeunit 1ns; timeprecision 100ps;


  /* 
  * =============================================================================
  * local parameters
  * =============================================================================
  */
  localparam SCL_CLK_CYCLES_PER_BIT = CLK_FREQ / SCL_FREQ;
  localparam SCL_CLK_CYCLE_COUNTER_BITS = $clog2(SCL_CLK_CYCLES_PER_BIT);
  // +5 is for 1 start bit, 1 r/w bit, 2 ACKs, and 1 stop bit
  localparam TOTAL_READ_WRITE_BITS = DEVICE_ADDR_WIDTH + REGISTER_ADDR_WIDTH + DATA_WIDTH + 5;

  // i2c read states
  typedef enum logic [9:0] {
    READ_RESET         = 10'b0000000000,
    READ_IDLE          = 10'b0000000010,
    READ_START         = 10'b0000000100,
    READ_BIT           = 10'b0000001000,
    READ_ADDR          = 10'b0000010000,
    READ_DATA_PRE_ACK  = 10'b0000100000,
    READ_DATA_POST_ACK = 10'b0001000000,
    READ_MAIN_ACK      = 10'b0010000000,
    READ_SECONDARY_ACK = 10'b0100000000,
    READ_STOP          = 10'b1000000000
  } i2c_read_state_t;

  // i2c write states
  typedef enum logic [8:0] {
    WRITE_RESET         = 9'b000000000,
    WRITE_IDLE          = 9'b000000010,
    WRITE_START         = 9'b000000100,
    WRITE_BIT           = 9'b000001000,
    WRITE_ADDR          = 9'b000010000,
    WRITE_DATA_PRE_ACK  = 9'b000100000,
    WRITE_DATA_POST_ACK = 9'b001000000,
    WRITE_ACK           = 9'b010000000,
    WRITE_STOP          = 9'b100000000
  } i2c_write_state_t;


  /* 
  * =============================================================================
  * scl clk divider
  * =============================================================================
  */
  logic _scl; // internal scl clock
  logic [SCL_CLK_CYCLE_COUNTER_BITS-1:0] scl_counter;

  // scl counter
  initial scl_counter = '0;
  always_ff @( posedge clk ) begin : _scl_clk_counter
    if (scl_counter == '0)
      scl_counter <= (SCL_CLK_CYCLE_COUNTER_BITS)'(SCL_CLK_CYCLES_PER_BIT - 1);
    else
      scl_counter <= scl_counter - 1;
  end

  // output
  always_comb begin : _bclk_clk_divider
    if (scl_counter[SCL_CLK_CYCLE_COUNTER_BITS-1:0] >= (SCL_CLK_CYCLE_COUNTER_BITS)'(SCL_CLK_CYCLES_PER_BIT / 2))
      _scl = 0;
    else
      _scl = 1;
  end


  /* 
  * =============================================================================
  * read
  * =============================================================================
  */

  // internal read variables
  i2c_read_state_t read_state, read_next_state;
  logic dev_addr_shift_en, reg_addr_shift_en, reg_data_shift_en;
  logic dev_addr_counter_rst_n, reg_addr_counter_rst_n, reg_data_counter_rst_n;

  // read current state logic
  always_ff @( posedge _scl ) begin : _read_current_state_logic
    if (!rst_n)
      read_state <= READ_RESET;
    else
      read_state <= read_next_state;
  end

endmodule : i2c
