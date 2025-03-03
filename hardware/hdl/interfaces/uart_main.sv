/*
Generic uart main
*/

`begin_keywords "1800-2017" // Use SystemVerilog 2023 keywords
`default_nettype none

module uart_main (
    input rstN,
    input clk,

    // uart
    input rx,
    output tx,
    input mode, // determines read/write
    output read_data,
    input write_data,

    // ready-valid
    input read_ready,
    input write_valid,
    output read_valid,
    output write_ready
);
    timeunit 1ns; timeprecision 100ps;

    // parameters
    parameter buffer_width = 8; // the input and ouput fifo widths

    // local parameters

endmodule: uart_main

`default_nettype wire
`end_keywords
