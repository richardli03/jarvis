/*
AXI3 interface.

@param A_PARAMETER
*/

`begin_keywords "1800-2017"  // Use SystemVerilog 2017 keywords
`default_nettype none

interface axi 
#(
  parameter AWID_WIDTH = 1,
            AWADDR_WIDTH = 8,
            AWREGION_WIDTH = 1,
            AWLEN_WIDTH = 4, // AXI3 limited to 16 transfers
            AWSIZE_WIDTH = 3, // TODO: remove
            AWBURST_WIDTH = 2, // TODO: remove
            AWLOCK_WIDTH = 2, // TODO: remove
            AWCACHE_WIDTH = 1,
            AWPROT_WIDTH = 1,
            AWQOS_WIDTH = 1,
            WDATA_WIDTH = 1,
            WSTRB_WIDTH = 1,
            WLAST_WIDTH = 1,
            BID_WIDTH = 1,
            BRESP_WIDTH = 1
)
(
  // global
  input logic aclk, // global clock
  input logic areset_n // global reset
):
  // write signals
  logic awid; // write address ID, unused
  logic awaddr; // write address
  logic awregion; // write region, unused
  logic awlen; // burst length
  logic awsize; // burst size
  logic awburst; // burst type
  logic awlock; // lock type, unused
  logic awcache; // cache type, unused
  logic awprot; // protection type, unused
  logic awqos; // QoS value
  logic awvalid; // write address valid
  logic awready; // write address read
  logic wdata; // write data
  logic wstrb; // write strobes
  logic wlast; // write last
  logic wvalid; // write valid
  logic wready; // write ready
  logic bid; // response ID, unused
  logic bresp; // write response
  logic bvalid; // write response valid
  logic bready; // response ready

  // read signals
  logic arid; // read address ID, unused
  logic araddr; // read address
  logic arregion; // read region, unused
  logic arlen; // burst length
  logic arsize; // burst size
  logic arburst; // burst type
  logic arlock; // locky type
  logic arcache; // cache type, unused
  logic arprot; // protection type, unused
  logic arqos; // QoS value, unused
  logic arvalid; // read address valid
  logic arready; // read address ready
  logic rid; // read address ready, unused
  logic rdata; // read data
  logic rresp; // read response
  logic rlast; // read last
  logic rvalid; // read valid
  logic rready; // read ready

  // parameters
  parameter A_PARAMETER = 8;

  // local parameters
  localparam ANOTHER_PARAMETER = $clog2(A_PARAMETER);

/* 
 * =============================================================================
 * section header
 * =============================================================================
 */

endinterface : axi

`default_nettype wire 
`end_keywords
