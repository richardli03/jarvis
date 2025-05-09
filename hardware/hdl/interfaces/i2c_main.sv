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
  // common
  input  wire  rst_n,
  input  wire  clk,
  output logic sda,
  output logic scl,
  input  wire  mode, // r/w: 0/1

  // read
  input  wire  read_ready,
  output logic read_valid,

  // write
  output logic write_ready,
  input  wire  write_valid
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
  localparam DEVICE_ADDR_COUNTER_BITS = $clog2(DEVICE_ADDR_WIDTH);
  localparam REGISTER_ADDR_COUNTER_BITS = $clog2(REGISTER_ADDR_WIDTH);
  localparam DATA_COUNTER_BITS = $clog2(DATA_WIDTH);

  // i2c read states
  typedef enum logic [11:0] {
    READ_RESET         = 12'b000000000000,
    READ_IDLE          = 12'b000000000001,
    READ_START         = 12'b000000000010,
    READ_ADDR          = 12'b000000000100,
    READ_BIT           = 12'b000000001000,
    READ_ADDR_ACK      = 12'b000000010000,
    READ_REG_ADDR      = 12'b000000100000,
    READ_DATA_PRE_ACK  = 12'b000001000000,
    READ_DATA_ACK_0    = 12'b000010000000,
    READ_DATA_POST_ACK = 12'b000100000000,
    READ_DATA_ACK_1    = 12'b001000000000,
    READ_STOP          = 12'b010000000000,
    READ_ERROR         = 12'b100000000000
  } i2c_read_state_t;

  // i2c write states
  typedef enum logic [11:0] {
    WRITE_RESET         = 12'b000000000000,
    WRITE_IDLE          = 12'b000000000001,
    WRITE_START         = 12'b000000000010,
    WRITE_ADDR          = 12'b000000000100,
    WRITE_BIT           = 12'b000000001000,
    WRITE_ADDR_ACK      = 12'b000000010000,
    WRITE_REG_ADDR      = 12'b000000100000,
    WRITE_DATA_PRE_ACK  = 12'b000001000000,
    WRITE_DATA_ACK_0    = 12'b000010000000,
    WRITE_DATA_POST_ACK = 12'b000100000000,
    WRITE_DATA_ACK_1    = 12'b001000000000,
    WRITE_STOP          = 12'b010000000000,
    WRITE_ERROR         = 12'b100000000000
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
 * common counters
 * =============================================================================
 */
  // device address bit counter
  logic [DEVICE_ADDR_COUNTER_BITS-1:0] device_addr_bit_counter;
  logic read_device_addr_bit_counter_rst_n, write_device_addr_bit_counter_rst_n;

  initial write_device_addr_bit_counter_rst_n = 1'b1;
  always_ff @( posedge _scl ) begin : _device_addr_bit_counter
    if (!read_device_addr_bit_counter_rst_n & !write_device_addr_bit_counter_rst_n)
      device_addr_bit_counter <= DEVICE_ADDR_WIDTH - 1;
    else if (device_addr_bit_counter == '0)
      device_addr_bit_counter <= DEVICE_ADDR_WIDTH - 1;
    else
      device_addr_bit_counter <= device_addr_bit_counter - 1;
  end

  // register address bit counter
  logic [REGISTER_ADDR_WIDTH - 1:0] register_bit_counter;
  logic read_register_bit_counter_rst_n, write_register_bit_counter_rst_n;

  initial write_register_bit_counter_rst_n = 1'b1;
  always_ff @( posedge _scl ) begin : _register_bit_counter
    if (!read_register_bit_counter_rst_n & !write_register_bit_counter_rst_n)
      register_bit_counter <= REGISTER_ADDR_WIDTH - 1;
    else if (register_bit_counter == '0)
      register_bit_counter <= REGISTER_ADDR_WIDTH - 1;
    else
      register_bit_counter <= register_bit_counter - 1;
  end

  // data bit counter
  logic [DATA_WIDTH - 1:0] data_bit_counter;
  logic read_data_bit_counter_rst_n, write_data_bit_counter_rst_n;

  initial write_data_bit_counter_rst_n = 1'b1;
  always_ff @( posedge _scl ) begin : _data_bit_counter
    if (!read_data_bit_counter_rst_n & !write_data_bit_counter_rst_n)
      data_bit_counter <= DATA_WIDTH - 1;
    else if (data_bit_counter == '0)
      data_bit_counter <= DATA_WIDTH - 1;
    else
      data_bit_counter <= data_bit_counter - 1;
  end


/* 
 * =============================================================================
 * read
 * =============================================================================
 */

  // internal read variables
  i2c_read_state_t read_state, read_next_state;
  logic device_addr_shift_en, reg_addr_shift_en, reg_data_shift_en;
  logic device_addr_counter_rst_n, reg_addr_counter_rst_n, reg_data_counter_rst_n;

  // read current state logic
  always_ff @( posedge _scl ) begin : _read_current_state_logic
    if (!rst_n)
      read_state <= READ_RESET;
    else
      read_state <= read_next_state;
  end 

  // read next state logic
  always_comb begin : _read_next_state_logic
    unique case (read_state)
      READ_RESET:
        read_next_state = READ_IDLE;
      READ_IDLE:
        if (read_ready & !mode)
          read_next_state = READ_START;
      READ_START:
        read_next_state = READ_ADDR;
      READ_ADDR:
        if (device_addr_bit_counter == '0)
          read_next_state = READ_BIT;
      READ_BIT:
        read_next_state = READ_ADDR_ACK;
      READ_ADDR_ACK:
        read_next_state = READ_REG_ADDR;
      READ_REG_ADDR:
        if (register_bit_counter == '0)
          read_next_state = READ_DATA_PRE_ACK;
      READ_DATA_PRE_ACK:
        read_next_state = READ_DATA_ACK_0;
      READ_DATA_ACK_0:
        read_next_state = READ_DATA_POST_ACK;
      READ_DATA_POST_ACK:
        if (data_bit_counter == '0)
          read_next_state = READ_DATA_ACK_1;
      READ_DATA_ACK_1:
        read_next_state = READ_STOP;
      READ_STOP:
        read_next_state = READ_IDLE;
      default:
        read_next_state = READ_ERROR;
    endcase
  end

  // read fsm outputs
  always_comb begin : _read_fsm_outputs
    unique case (read_state)
      READ_RESET: begin
        {read_device_addr_bit_counter_rst_n, read_register_bit_counter_rst_n, read_data_bit_counter_rst_n} = 3'b111;
        read_valid = 1'b0;
      end
      READ_IDLE: begin
        {read_device_addr_bit_counter_rst_n, read_register_bit_counter_rst_n, read_data_bit_counter_rst_n} = 3'b111;
        read_valid = 1'b1;
      end
      READ_START: begin
        {read_device_addr_bit_counter_rst_n, read_register_bit_counter_rst_n, read_data_bit_counter_rst_n} = 3'b111;
        read_valid = 1'b1;
      end
      READ_ADDR: begin
        {read_device_addr_bit_counter_rst_n, read_register_bit_counter_rst_n, read_data_bit_counter_rst_n} = 3'b011;
        read_valid = 1'b1;
      end
      READ_BIT: begin
        {read_device_addr_bit_counter_rst_n, read_register_bit_counter_rst_n, read_data_bit_counter_rst_n} = 3'b111;
        read_valid = 1'b1;
      end
      READ_ADDR_ACK: begin
        {read_device_addr_bit_counter_rst_n, read_register_bit_counter_rst_n, read_data_bit_counter_rst_n} = 3'b111;
        read_valid = 1'b1;
      end
      READ_REG_ADDR: begin
        {read_device_addr_bit_counter_rst_n, read_register_bit_counter_rst_n, read_data_bit_counter_rst_n} = 3'b101;
        read_valid = 1'b1;
      end
      READ_DATA_PRE_ACK: begin
        {read_device_addr_bit_counter_rst_n, read_register_bit_counter_rst_n, read_data_bit_counter_rst_n} = 3'b110;
        read_valid = 1'b0;
      end
      READ_DATA_ACK_0: begin
        {read_device_addr_bit_counter_rst_n, read_register_bit_counter_rst_n, read_data_bit_counter_rst_n} = 3'b111;
        read_valid = 1'b0;
      end
      READ_DATA_POST_ACK: begin
        {read_device_addr_bit_counter_rst_n, read_register_bit_counter_rst_n, read_data_bit_counter_rst_n} = 3'b110;
        read_valid = 1'b0;
      end
      READ_DATA_ACK_1: begin
        {read_device_addr_bit_counter_rst_n, read_register_bit_counter_rst_n, read_data_bit_counter_rst_n} = 3'b111;
        read_valid = 1'b1;
      end
      READ_STOP: begin
        {read_device_addr_bit_counter_rst_n, read_register_bit_counter_rst_n, read_data_bit_counter_rst_n} = 3'b111;
        read_valid = 1'b1;
      end
      READ_ERROR: begin
        {read_device_addr_bit_counter_rst_n, read_register_bit_counter_rst_n, read_data_bit_counter_rst_n} = 3'b111;
        read_valid = 1'b0;
      end
      default: begin
        {read_device_addr_bit_counter_rst_n, read_register_bit_counter_rst_n, read_data_bit_counter_rst_n} = 3'b111;
        read_valid = 1'b0;
      end
    endcase
  end

  // sda output


  // scl output

endmodule : i2c
