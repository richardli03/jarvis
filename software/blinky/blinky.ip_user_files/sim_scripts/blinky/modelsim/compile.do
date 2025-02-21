vlib modelsim_lib/work
vlib modelsim_lib/msim

vlib modelsim_lib/msim/xilinx_vip
vlib modelsim_lib/msim/xpm
vlib modelsim_lib/msim/axi_infrastructure_v1_1_0
vlib modelsim_lib/msim/axi_vip_v1_1_19
vlib modelsim_lib/msim/processing_system7_vip_v1_0_21
vlib modelsim_lib/msim/xil_defaultlib
vlib modelsim_lib/msim/axi_lite_ipif_v3_0_4
vlib modelsim_lib/msim/lib_cdc_v1_0_3
vlib modelsim_lib/msim/interrupt_control_v3_1_5
vlib modelsim_lib/msim/axi_gpio_v2_0_35
vlib modelsim_lib/msim/xlconstant_v1_1_9
vlib modelsim_lib/msim/proc_sys_reset_v5_0_16
vlib modelsim_lib/msim/smartconnect_v1_0
vlib modelsim_lib/msim/axi_register_slice_v2_1_33

vmap xilinx_vip modelsim_lib/msim/xilinx_vip
vmap xpm modelsim_lib/msim/xpm
vmap axi_infrastructure_v1_1_0 modelsim_lib/msim/axi_infrastructure_v1_1_0
vmap axi_vip_v1_1_19 modelsim_lib/msim/axi_vip_v1_1_19
vmap processing_system7_vip_v1_0_21 modelsim_lib/msim/processing_system7_vip_v1_0_21
vmap xil_defaultlib modelsim_lib/msim/xil_defaultlib
vmap axi_lite_ipif_v3_0_4 modelsim_lib/msim/axi_lite_ipif_v3_0_4
vmap lib_cdc_v1_0_3 modelsim_lib/msim/lib_cdc_v1_0_3
vmap interrupt_control_v3_1_5 modelsim_lib/msim/interrupt_control_v3_1_5
vmap axi_gpio_v2_0_35 modelsim_lib/msim/axi_gpio_v2_0_35
vmap xlconstant_v1_1_9 modelsim_lib/msim/xlconstant_v1_1_9
vmap proc_sys_reset_v5_0_16 modelsim_lib/msim/proc_sys_reset_v5_0_16
vmap smartconnect_v1_0 modelsim_lib/msim/smartconnect_v1_0
vmap axi_register_slice_v2_1_33 modelsim_lib/msim/axi_register_slice_v2_1_33

vlog -work xilinx_vip -64 -incr -mfcu  -sv -L axi_vip_v1_1_19 -L smartconnect_v1_0 -L processing_system7_vip_v1_0_21 -L xilinx_vip "+incdir+/home/drew/embedded/xilinx/Vivado/2024.2/data/xilinx_vip/include" \
"/home/drew/embedded/xilinx/Vivado/2024.2/data/xilinx_vip/hdl/axi4stream_vip_axi4streampc.sv" \
"/home/drew/embedded/xilinx/Vivado/2024.2/data/xilinx_vip/hdl/axi_vip_axi4pc.sv" \
"/home/drew/embedded/xilinx/Vivado/2024.2/data/xilinx_vip/hdl/xil_common_vip_pkg.sv" \
"/home/drew/embedded/xilinx/Vivado/2024.2/data/xilinx_vip/hdl/axi4stream_vip_pkg.sv" \
"/home/drew/embedded/xilinx/Vivado/2024.2/data/xilinx_vip/hdl/axi_vip_pkg.sv" \
"/home/drew/embedded/xilinx/Vivado/2024.2/data/xilinx_vip/hdl/axi4stream_vip_if.sv" \
"/home/drew/embedded/xilinx/Vivado/2024.2/data/xilinx_vip/hdl/axi_vip_if.sv" \
"/home/drew/embedded/xilinx/Vivado/2024.2/data/xilinx_vip/hdl/clk_vip_if.sv" \
"/home/drew/embedded/xilinx/Vivado/2024.2/data/xilinx_vip/hdl/rst_vip_if.sv" \

vlog -work xpm -64 -incr -mfcu  -sv -L axi_vip_v1_1_19 -L smartconnect_v1_0 -L processing_system7_vip_v1_0_21 -L xilinx_vip "+incdir+../../../../blinky.gen/sources_1/bd/blinky/ipshared/ec67/hdl" "+incdir+../../../../blinky.gen/sources_1/bd/blinky/ipshared/86fe/hdl" "+incdir+../../../../blinky.gen/sources_1/bd/blinky/ipshared/f0b6/hdl/verilog" "+incdir+../../../../blinky.gen/sources_1/bd/blinky/ipshared/0127/hdl/verilog" "+incdir+/home/drew/embedded/xilinx/Vivado/2024.2/data/xilinx_vip/include" \
"/home/drew/embedded/xilinx/Vivado/2024.2/data/ip/xpm/xpm_fifo/hdl/xpm_fifo.sv" \
"/home/drew/embedded/xilinx/Vivado/2024.2/data/ip/xpm/xpm_memory/hdl/xpm_memory.sv" \
"/home/drew/embedded/xilinx/Vivado/2024.2/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \

vcom -work xpm -64 -93  \
"/home/drew/embedded/xilinx/Vivado/2024.2/data/ip/xpm/xpm_VCOMP.vhd" \

vlog -work axi_infrastructure_v1_1_0 -64 -incr -mfcu  "+incdir+../../../../blinky.gen/sources_1/bd/blinky/ipshared/ec67/hdl" "+incdir+../../../../blinky.gen/sources_1/bd/blinky/ipshared/86fe/hdl" "+incdir+../../../../blinky.gen/sources_1/bd/blinky/ipshared/f0b6/hdl/verilog" "+incdir+../../../../blinky.gen/sources_1/bd/blinky/ipshared/0127/hdl/verilog" "+incdir+/home/drew/embedded/xilinx/Vivado/2024.2/data/xilinx_vip/include" \
"../../../../blinky.gen/sources_1/bd/blinky/ipshared/ec67/hdl/axi_infrastructure_v1_1_vl_rfs.v" \

vlog -work axi_vip_v1_1_19 -64 -incr -mfcu  -sv -L axi_vip_v1_1_19 -L smartconnect_v1_0 -L processing_system7_vip_v1_0_21 -L xilinx_vip "+incdir+../../../../blinky.gen/sources_1/bd/blinky/ipshared/ec67/hdl" "+incdir+../../../../blinky.gen/sources_1/bd/blinky/ipshared/86fe/hdl" "+incdir+../../../../blinky.gen/sources_1/bd/blinky/ipshared/f0b6/hdl/verilog" "+incdir+../../../../blinky.gen/sources_1/bd/blinky/ipshared/0127/hdl/verilog" "+incdir+/home/drew/embedded/xilinx/Vivado/2024.2/data/xilinx_vip/include" \
"../../../../blinky.gen/sources_1/bd/blinky/ipshared/8c45/hdl/axi_vip_v1_1_vl_rfs.sv" \

vlog -work processing_system7_vip_v1_0_21 -64 -incr -mfcu  -sv -L axi_vip_v1_1_19 -L smartconnect_v1_0 -L processing_system7_vip_v1_0_21 -L xilinx_vip "+incdir+../../../../blinky.gen/sources_1/bd/blinky/ipshared/ec67/hdl" "+incdir+../../../../blinky.gen/sources_1/bd/blinky/ipshared/86fe/hdl" "+incdir+../../../../blinky.gen/sources_1/bd/blinky/ipshared/f0b6/hdl/verilog" "+incdir+../../../../blinky.gen/sources_1/bd/blinky/ipshared/0127/hdl/verilog" "+incdir+/home/drew/embedded/xilinx/Vivado/2024.2/data/xilinx_vip/include" \
"../../../../blinky.gen/sources_1/bd/blinky/ipshared/86fe/hdl/processing_system7_vip_v1_0_vl_rfs.sv" \

vlog -work xil_defaultlib -64 -incr -mfcu  "+incdir+../../../../blinky.gen/sources_1/bd/blinky/ipshared/ec67/hdl" "+incdir+../../../../blinky.gen/sources_1/bd/blinky/ipshared/86fe/hdl" "+incdir+../../../../blinky.gen/sources_1/bd/blinky/ipshared/f0b6/hdl/verilog" "+incdir+../../../../blinky.gen/sources_1/bd/blinky/ipshared/0127/hdl/verilog" "+incdir+/home/drew/embedded/xilinx/Vivado/2024.2/data/xilinx_vip/include" \
"../../../../blinky.gen/sources_1/bd/blinky/ip/blinky_processing_system7_0_0/sim/blinky_processing_system7_0_0.v" \

vcom -work axi_lite_ipif_v3_0_4 -64 -93  \
"../../../../blinky.gen/sources_1/bd/blinky/ipshared/66ea/hdl/axi_lite_ipif_v3_0_vh_rfs.vhd" \

vcom -work lib_cdc_v1_0_3 -64 -93  \
"../../../../blinky.gen/sources_1/bd/blinky/ipshared/2a4f/hdl/lib_cdc_v1_0_rfs.vhd" \

vcom -work interrupt_control_v3_1_5 -64 -93  \
"../../../../blinky.gen/sources_1/bd/blinky/ipshared/d8cc/hdl/interrupt_control_v3_1_vh_rfs.vhd" \

vcom -work axi_gpio_v2_0_35 -64 -93  \
"../../../../blinky.gen/sources_1/bd/blinky/ipshared/6718/hdl/axi_gpio_v2_0_vh_rfs.vhd" \

vcom -work xil_defaultlib -64 -93  \
"../../../../blinky.gen/sources_1/bd/blinky/ip/blinky_axi_gpio_0_0/sim/blinky_axi_gpio_0_0.vhd" \

vlog -work xlconstant_v1_1_9 -64 -incr -mfcu  "+incdir+../../../../blinky.gen/sources_1/bd/blinky/ipshared/ec67/hdl" "+incdir+../../../../blinky.gen/sources_1/bd/blinky/ipshared/86fe/hdl" "+incdir+../../../../blinky.gen/sources_1/bd/blinky/ipshared/f0b6/hdl/verilog" "+incdir+../../../../blinky.gen/sources_1/bd/blinky/ipshared/0127/hdl/verilog" "+incdir+/home/drew/embedded/xilinx/Vivado/2024.2/data/xilinx_vip/include" \
"../../../../blinky.gen/sources_1/bd/blinky/ipshared/e2d2/hdl/xlconstant_v1_1_vl_rfs.v" \

vlog -work xil_defaultlib -64 -incr -mfcu  "+incdir+../../../../blinky.gen/sources_1/bd/blinky/ipshared/ec67/hdl" "+incdir+../../../../blinky.gen/sources_1/bd/blinky/ipshared/86fe/hdl" "+incdir+../../../../blinky.gen/sources_1/bd/blinky/ipshared/f0b6/hdl/verilog" "+incdir+../../../../blinky.gen/sources_1/bd/blinky/ipshared/0127/hdl/verilog" "+incdir+/home/drew/embedded/xilinx/Vivado/2024.2/data/xilinx_vip/include" \
"../../../../blinky.gen/sources_1/bd/blinky/ip/blinky_axi_smc_0/bd_0/ip/ip_0/sim/bd_706f_one_0.v" \

vcom -work proc_sys_reset_v5_0_16 -64 -93  \
"../../../../blinky.gen/sources_1/bd/blinky/ipshared/0831/hdl/proc_sys_reset_v5_0_vh_rfs.vhd" \

vcom -work xil_defaultlib -64 -93  \
"../../../../blinky.gen/sources_1/bd/blinky/ip/blinky_axi_smc_0/bd_0/ip/ip_1/sim/bd_706f_psr_aclk_0.vhd" \

vlog -work smartconnect_v1_0 -64 -incr -mfcu  -sv -L axi_vip_v1_1_19 -L smartconnect_v1_0 -L processing_system7_vip_v1_0_21 -L xilinx_vip "+incdir+../../../../blinky.gen/sources_1/bd/blinky/ipshared/ec67/hdl" "+incdir+../../../../blinky.gen/sources_1/bd/blinky/ipshared/86fe/hdl" "+incdir+../../../../blinky.gen/sources_1/bd/blinky/ipshared/f0b6/hdl/verilog" "+incdir+../../../../blinky.gen/sources_1/bd/blinky/ipshared/0127/hdl/verilog" "+incdir+/home/drew/embedded/xilinx/Vivado/2024.2/data/xilinx_vip/include" \
"../../../../blinky.gen/sources_1/bd/blinky/ipshared/f0b6/hdl/sc_util_v1_0_vl_rfs.sv" \
"../../../../blinky.gen/sources_1/bd/blinky/ipshared/f49a/hdl/sc_mmu_v1_0_vl_rfs.sv" \

vlog -work xil_defaultlib -64 -incr -mfcu  -sv -L axi_vip_v1_1_19 -L smartconnect_v1_0 -L processing_system7_vip_v1_0_21 -L xilinx_vip "+incdir+../../../../blinky.gen/sources_1/bd/blinky/ipshared/ec67/hdl" "+incdir+../../../../blinky.gen/sources_1/bd/blinky/ipshared/86fe/hdl" "+incdir+../../../../blinky.gen/sources_1/bd/blinky/ipshared/f0b6/hdl/verilog" "+incdir+../../../../blinky.gen/sources_1/bd/blinky/ipshared/0127/hdl/verilog" "+incdir+/home/drew/embedded/xilinx/Vivado/2024.2/data/xilinx_vip/include" \
"../../../../blinky.gen/sources_1/bd/blinky/ip/blinky_axi_smc_0/bd_0/ip/ip_2/sim/bd_706f_s00mmu_0.sv" \

vlog -work smartconnect_v1_0 -64 -incr -mfcu  -sv -L axi_vip_v1_1_19 -L smartconnect_v1_0 -L processing_system7_vip_v1_0_21 -L xilinx_vip "+incdir+../../../../blinky.gen/sources_1/bd/blinky/ipshared/ec67/hdl" "+incdir+../../../../blinky.gen/sources_1/bd/blinky/ipshared/86fe/hdl" "+incdir+../../../../blinky.gen/sources_1/bd/blinky/ipshared/f0b6/hdl/verilog" "+incdir+../../../../blinky.gen/sources_1/bd/blinky/ipshared/0127/hdl/verilog" "+incdir+/home/drew/embedded/xilinx/Vivado/2024.2/data/xilinx_vip/include" \
"../../../../blinky.gen/sources_1/bd/blinky/ipshared/2da8/hdl/sc_transaction_regulator_v1_0_vl_rfs.sv" \

vlog -work xil_defaultlib -64 -incr -mfcu  -sv -L axi_vip_v1_1_19 -L smartconnect_v1_0 -L processing_system7_vip_v1_0_21 -L xilinx_vip "+incdir+../../../../blinky.gen/sources_1/bd/blinky/ipshared/ec67/hdl" "+incdir+../../../../blinky.gen/sources_1/bd/blinky/ipshared/86fe/hdl" "+incdir+../../../../blinky.gen/sources_1/bd/blinky/ipshared/f0b6/hdl/verilog" "+incdir+../../../../blinky.gen/sources_1/bd/blinky/ipshared/0127/hdl/verilog" "+incdir+/home/drew/embedded/xilinx/Vivado/2024.2/data/xilinx_vip/include" \
"../../../../blinky.gen/sources_1/bd/blinky/ip/blinky_axi_smc_0/bd_0/ip/ip_3/sim/bd_706f_s00tr_0.sv" \

vlog -work smartconnect_v1_0 -64 -incr -mfcu  -sv -L axi_vip_v1_1_19 -L smartconnect_v1_0 -L processing_system7_vip_v1_0_21 -L xilinx_vip "+incdir+../../../../blinky.gen/sources_1/bd/blinky/ipshared/ec67/hdl" "+incdir+../../../../blinky.gen/sources_1/bd/blinky/ipshared/86fe/hdl" "+incdir+../../../../blinky.gen/sources_1/bd/blinky/ipshared/f0b6/hdl/verilog" "+incdir+../../../../blinky.gen/sources_1/bd/blinky/ipshared/0127/hdl/verilog" "+incdir+/home/drew/embedded/xilinx/Vivado/2024.2/data/xilinx_vip/include" \
"../../../../blinky.gen/sources_1/bd/blinky/ipshared/63ed/hdl/sc_si_converter_v1_0_vl_rfs.sv" \

vlog -work xil_defaultlib -64 -incr -mfcu  -sv -L axi_vip_v1_1_19 -L smartconnect_v1_0 -L processing_system7_vip_v1_0_21 -L xilinx_vip "+incdir+../../../../blinky.gen/sources_1/bd/blinky/ipshared/ec67/hdl" "+incdir+../../../../blinky.gen/sources_1/bd/blinky/ipshared/86fe/hdl" "+incdir+../../../../blinky.gen/sources_1/bd/blinky/ipshared/f0b6/hdl/verilog" "+incdir+../../../../blinky.gen/sources_1/bd/blinky/ipshared/0127/hdl/verilog" "+incdir+/home/drew/embedded/xilinx/Vivado/2024.2/data/xilinx_vip/include" \
"../../../../blinky.gen/sources_1/bd/blinky/ip/blinky_axi_smc_0/bd_0/ip/ip_4/sim/bd_706f_s00sic_0.sv" \

vlog -work smartconnect_v1_0 -64 -incr -mfcu  -sv -L axi_vip_v1_1_19 -L smartconnect_v1_0 -L processing_system7_vip_v1_0_21 -L xilinx_vip "+incdir+../../../../blinky.gen/sources_1/bd/blinky/ipshared/ec67/hdl" "+incdir+../../../../blinky.gen/sources_1/bd/blinky/ipshared/86fe/hdl" "+incdir+../../../../blinky.gen/sources_1/bd/blinky/ipshared/f0b6/hdl/verilog" "+incdir+../../../../blinky.gen/sources_1/bd/blinky/ipshared/0127/hdl/verilog" "+incdir+/home/drew/embedded/xilinx/Vivado/2024.2/data/xilinx_vip/include" \
"../../../../blinky.gen/sources_1/bd/blinky/ipshared/cef3/hdl/sc_axi2sc_v1_0_vl_rfs.sv" \

vlog -work xil_defaultlib -64 -incr -mfcu  -sv -L axi_vip_v1_1_19 -L smartconnect_v1_0 -L processing_system7_vip_v1_0_21 -L xilinx_vip "+incdir+../../../../blinky.gen/sources_1/bd/blinky/ipshared/ec67/hdl" "+incdir+../../../../blinky.gen/sources_1/bd/blinky/ipshared/86fe/hdl" "+incdir+../../../../blinky.gen/sources_1/bd/blinky/ipshared/f0b6/hdl/verilog" "+incdir+../../../../blinky.gen/sources_1/bd/blinky/ipshared/0127/hdl/verilog" "+incdir+/home/drew/embedded/xilinx/Vivado/2024.2/data/xilinx_vip/include" \
"../../../../blinky.gen/sources_1/bd/blinky/ip/blinky_axi_smc_0/bd_0/ip/ip_5/sim/bd_706f_s00a2s_0.sv" \

vlog -work smartconnect_v1_0 -64 -incr -mfcu  -sv -L axi_vip_v1_1_19 -L smartconnect_v1_0 -L processing_system7_vip_v1_0_21 -L xilinx_vip "+incdir+../../../../blinky.gen/sources_1/bd/blinky/ipshared/ec67/hdl" "+incdir+../../../../blinky.gen/sources_1/bd/blinky/ipshared/86fe/hdl" "+incdir+../../../../blinky.gen/sources_1/bd/blinky/ipshared/f0b6/hdl/verilog" "+incdir+../../../../blinky.gen/sources_1/bd/blinky/ipshared/0127/hdl/verilog" "+incdir+/home/drew/embedded/xilinx/Vivado/2024.2/data/xilinx_vip/include" \
"../../../../blinky.gen/sources_1/bd/blinky/ipshared/0127/hdl/sc_node_v1_0_vl_rfs.sv" \

vlog -work xil_defaultlib -64 -incr -mfcu  -sv -L axi_vip_v1_1_19 -L smartconnect_v1_0 -L processing_system7_vip_v1_0_21 -L xilinx_vip "+incdir+../../../../blinky.gen/sources_1/bd/blinky/ipshared/ec67/hdl" "+incdir+../../../../blinky.gen/sources_1/bd/blinky/ipshared/86fe/hdl" "+incdir+../../../../blinky.gen/sources_1/bd/blinky/ipshared/f0b6/hdl/verilog" "+incdir+../../../../blinky.gen/sources_1/bd/blinky/ipshared/0127/hdl/verilog" "+incdir+/home/drew/embedded/xilinx/Vivado/2024.2/data/xilinx_vip/include" \
"../../../../blinky.gen/sources_1/bd/blinky/ip/blinky_axi_smc_0/bd_0/ip/ip_6/sim/bd_706f_sarn_0.sv" \
"../../../../blinky.gen/sources_1/bd/blinky/ip/blinky_axi_smc_0/bd_0/ip/ip_7/sim/bd_706f_srn_0.sv" \
"../../../../blinky.gen/sources_1/bd/blinky/ip/blinky_axi_smc_0/bd_0/ip/ip_8/sim/bd_706f_sawn_0.sv" \
"../../../../blinky.gen/sources_1/bd/blinky/ip/blinky_axi_smc_0/bd_0/ip/ip_9/sim/bd_706f_swn_0.sv" \
"../../../../blinky.gen/sources_1/bd/blinky/ip/blinky_axi_smc_0/bd_0/ip/ip_10/sim/bd_706f_sbn_0.sv" \

vlog -work smartconnect_v1_0 -64 -incr -mfcu  -sv -L axi_vip_v1_1_19 -L smartconnect_v1_0 -L processing_system7_vip_v1_0_21 -L xilinx_vip "+incdir+../../../../blinky.gen/sources_1/bd/blinky/ipshared/ec67/hdl" "+incdir+../../../../blinky.gen/sources_1/bd/blinky/ipshared/86fe/hdl" "+incdir+../../../../blinky.gen/sources_1/bd/blinky/ipshared/f0b6/hdl/verilog" "+incdir+../../../../blinky.gen/sources_1/bd/blinky/ipshared/0127/hdl/verilog" "+incdir+/home/drew/embedded/xilinx/Vivado/2024.2/data/xilinx_vip/include" \
"../../../../blinky.gen/sources_1/bd/blinky/ipshared/7f4f/hdl/sc_sc2axi_v1_0_vl_rfs.sv" \

vlog -work xil_defaultlib -64 -incr -mfcu  -sv -L axi_vip_v1_1_19 -L smartconnect_v1_0 -L processing_system7_vip_v1_0_21 -L xilinx_vip "+incdir+../../../../blinky.gen/sources_1/bd/blinky/ipshared/ec67/hdl" "+incdir+../../../../blinky.gen/sources_1/bd/blinky/ipshared/86fe/hdl" "+incdir+../../../../blinky.gen/sources_1/bd/blinky/ipshared/f0b6/hdl/verilog" "+incdir+../../../../blinky.gen/sources_1/bd/blinky/ipshared/0127/hdl/verilog" "+incdir+/home/drew/embedded/xilinx/Vivado/2024.2/data/xilinx_vip/include" \
"../../../../blinky.gen/sources_1/bd/blinky/ip/blinky_axi_smc_0/bd_0/ip/ip_11/sim/bd_706f_m00s2a_0.sv" \

vlog -work smartconnect_v1_0 -64 -incr -mfcu  -sv -L axi_vip_v1_1_19 -L smartconnect_v1_0 -L processing_system7_vip_v1_0_21 -L xilinx_vip "+incdir+../../../../blinky.gen/sources_1/bd/blinky/ipshared/ec67/hdl" "+incdir+../../../../blinky.gen/sources_1/bd/blinky/ipshared/86fe/hdl" "+incdir+../../../../blinky.gen/sources_1/bd/blinky/ipshared/f0b6/hdl/verilog" "+incdir+../../../../blinky.gen/sources_1/bd/blinky/ipshared/0127/hdl/verilog" "+incdir+/home/drew/embedded/xilinx/Vivado/2024.2/data/xilinx_vip/include" \
"../../../../blinky.gen/sources_1/bd/blinky/ipshared/37bc/hdl/sc_exit_v1_0_vl_rfs.sv" \

vlog -work xil_defaultlib -64 -incr -mfcu  -sv -L axi_vip_v1_1_19 -L smartconnect_v1_0 -L processing_system7_vip_v1_0_21 -L xilinx_vip "+incdir+../../../../blinky.gen/sources_1/bd/blinky/ipshared/ec67/hdl" "+incdir+../../../../blinky.gen/sources_1/bd/blinky/ipshared/86fe/hdl" "+incdir+../../../../blinky.gen/sources_1/bd/blinky/ipshared/f0b6/hdl/verilog" "+incdir+../../../../blinky.gen/sources_1/bd/blinky/ipshared/0127/hdl/verilog" "+incdir+/home/drew/embedded/xilinx/Vivado/2024.2/data/xilinx_vip/include" \
"../../../../blinky.gen/sources_1/bd/blinky/ip/blinky_axi_smc_0/bd_0/ip/ip_12/sim/bd_706f_m00e_0.sv" \

vlog -work xil_defaultlib -64 -incr -mfcu  "+incdir+../../../../blinky.gen/sources_1/bd/blinky/ipshared/ec67/hdl" "+incdir+../../../../blinky.gen/sources_1/bd/blinky/ipshared/86fe/hdl" "+incdir+../../../../blinky.gen/sources_1/bd/blinky/ipshared/f0b6/hdl/verilog" "+incdir+../../../../blinky.gen/sources_1/bd/blinky/ipshared/0127/hdl/verilog" "+incdir+/home/drew/embedded/xilinx/Vivado/2024.2/data/xilinx_vip/include" \
"../../../../blinky.gen/sources_1/bd/blinky/ip/blinky_axi_smc_0/bd_0/sim/bd_706f.v" \

vlog -work smartconnect_v1_0 -64 -incr -mfcu  -sv -L axi_vip_v1_1_19 -L smartconnect_v1_0 -L processing_system7_vip_v1_0_21 -L xilinx_vip "+incdir+../../../../blinky.gen/sources_1/bd/blinky/ipshared/ec67/hdl" "+incdir+../../../../blinky.gen/sources_1/bd/blinky/ipshared/86fe/hdl" "+incdir+../../../../blinky.gen/sources_1/bd/blinky/ipshared/f0b6/hdl/verilog" "+incdir+../../../../blinky.gen/sources_1/bd/blinky/ipshared/0127/hdl/verilog" "+incdir+/home/drew/embedded/xilinx/Vivado/2024.2/data/xilinx_vip/include" \
"../../../../blinky.gen/sources_1/bd/blinky/ipshared/3718/hdl/sc_switchboard_v1_0_vl_rfs.sv" \

vlog -work axi_register_slice_v2_1_33 -64 -incr -mfcu  "+incdir+../../../../blinky.gen/sources_1/bd/blinky/ipshared/ec67/hdl" "+incdir+../../../../blinky.gen/sources_1/bd/blinky/ipshared/86fe/hdl" "+incdir+../../../../blinky.gen/sources_1/bd/blinky/ipshared/f0b6/hdl/verilog" "+incdir+../../../../blinky.gen/sources_1/bd/blinky/ipshared/0127/hdl/verilog" "+incdir+/home/drew/embedded/xilinx/Vivado/2024.2/data/xilinx_vip/include" \
"../../../../blinky.gen/sources_1/bd/blinky/ipshared/3ee4/hdl/axi_register_slice_v2_1_vl_rfs.v" \

vlog -work xil_defaultlib -64 -incr -mfcu  "+incdir+../../../../blinky.gen/sources_1/bd/blinky/ipshared/ec67/hdl" "+incdir+../../../../blinky.gen/sources_1/bd/blinky/ipshared/86fe/hdl" "+incdir+../../../../blinky.gen/sources_1/bd/blinky/ipshared/f0b6/hdl/verilog" "+incdir+../../../../blinky.gen/sources_1/bd/blinky/ipshared/0127/hdl/verilog" "+incdir+/home/drew/embedded/xilinx/Vivado/2024.2/data/xilinx_vip/include" \
"../../../../blinky.gen/sources_1/bd/blinky/ip/blinky_axi_smc_0/sim/blinky_axi_smc_0.v" \

vcom -work xil_defaultlib -64 -93  \
"../../../../blinky.gen/sources_1/bd/blinky/ip/blinky_rst_ps7_0_50M_0/sim/blinky_rst_ps7_0_50M_0.vhd" \

vlog -work xil_defaultlib -64 -incr -mfcu  "+incdir+../../../../blinky.gen/sources_1/bd/blinky/ipshared/ec67/hdl" "+incdir+../../../../blinky.gen/sources_1/bd/blinky/ipshared/86fe/hdl" "+incdir+../../../../blinky.gen/sources_1/bd/blinky/ipshared/f0b6/hdl/verilog" "+incdir+../../../../blinky.gen/sources_1/bd/blinky/ipshared/0127/hdl/verilog" "+incdir+/home/drew/embedded/xilinx/Vivado/2024.2/data/xilinx_vip/include" \
"../../../../blinky.gen/sources_1/bd/blinky/sim/blinky.v" \

vlog -work xil_defaultlib \
"glbl.v"

