/*
AXI3 interface.

// common
@param ADDR_ID_WIDTH: read/write address ID width, unused
@param ADDR_WIDTH: read/write address width
@param DATA_WIDTH: read/write data width
@param BURST_LEN_WIDTH: burst length width, 4 by default for 2^4 max burst for AXI3

// write
@param BID_WIDTH: response ID width

// read
@param RID_WIDTH: read data ID width
*/

`begin_keywords "1800-2017"  // Use SystemVerilog 2017 keywords
`default_nettype none

interface axi 
#(
  // common parameters
  parameter ADDR_ID_WIDTH = 1,
            ADDR_WIDTH = 8,
            DATA_WIDTH = 32,
            BURST_LEN_WIDTH = 4,
  
  // write paramters
  parameter BID_WIDTH = 1,

  // read parameters
  parameter RID_WIDTH = 1
)
(
  // global
  input logic aclk, // global clock
  input logic areset_n // global reset
);
  // derived parameters
  localparam WSTRB_WDITH = WDATA_WIDTH / 8;

  // write signals
  logic [ADDR_ID_WIDTH-1:0] awid; // write address ID, unused
  logic [ADDR_WIDTH-1:0] awaddr; // write address
  logic [BURST_LEN_WIDTH-1:0] awlen; // burst length  
  logic [2:0] awsize; // burst size
  logic [1:0] awburst; // burst type
  logic [1:0] awlock; // lock type, unused
  logic [3:0] awcache; // cache type, unused
  logic [2:0] awprot; // protection type, unused
  logic awvalid; // write address valid
  logic awready; // write address read
  logic [DATA_WIDTH-1:0] wdata; // write data
  logic [WSTRB_WDITH-1:0] wstrb; // write strobes
  logic wlast; // write last
  logic wvalid; // write valid
  logic wready; // write ready
  logic [BID_WIDTH-1:0] bid; // response ID, unused
  logic [1:0] bresp; // write response
  logic bvalid; // write response valid
  logic bready; // response ready

  // AXI4 exclusive
  // logic [3:0] awqos; // QoS value
  // logic [3:0] awregion; // write region
  // logic awuser;
  // logic wuser;
  // logic buser;

  // read signals
  logic [ADDR_ID_WIDTH-1:0] arid; // read address ID, unused
  logic [ADDR_WIDTH-1:0] araddr; // read address
  logic [BURST_LEN_WIDTH-1:0] arlen; // burst length
  logic [2:0] arsize; // burst size
  logic [1:0] arburst; // burst type
  logic [1:0] arlock; // locky type
  logic [3:0] arcache; // cache type, unused
  logic [2:0] arprot; // protection type, unused
  logic arvalid; // read address valid
  logic arready; // read address ready
  logic [RID_WIDTH-1:0] rid; // read address ID, unused
  logic [DATA_WIDTH-1:0] rdata; // read data
  logic [1:0] rresp; // read response
  logic rlast; // read last
  logic rvalid; // read valid
  logic rready; // read ready

  // AXI4 exclusive
  // logic [3:0] arqos; // QoS value
  // logic [3:0] arregion; // read region
  // logic aruser;
  // logic ruser;

/* 
 * =============================================================================
 * main modport
 * =============================================================================
 */
  modport main_ports (
    // global
    input aclk, areset_n,
    
    // write
    input awready, wready, bid, bresp, bvalid,
    output awid, awaddr, awlen, awsize, awburst, awlock, awcache, awprot, awvalid, wdata, wstrb, wlast, wvalid, bready,
    
    // read
    input arready, rid, rdata, rresp, rlast, rvalid,
    output arid, araddr, arlen, arsize, arburst, arlock, arcache, arprot, arvalid, rready
  );

/* 
 * =============================================================================
 * peripheral modport
 * =============================================================================
 */
  modport peripheral_modport (
    // global
    input aclk, areset_n,

    // write
    input awid, awaddr, awlen, awsize, awburst, awlock, awcache, awprot, awvalid, wdata, wstrb, wlast, wvalid,
    output awready, wread, bid, bresp, bvalid,

    // read
    input arid, araddr, arlen, arburst, arlock, arcache, arprot, arvalid, rready, 
    output arready, rid, rdata, rresp, rlast, rvalid
  );

endinterface : axi

`default_nettype wire 
`end_keywords
