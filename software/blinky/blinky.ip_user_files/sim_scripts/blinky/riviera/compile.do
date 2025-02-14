transcript off
onbreak {quit -force}
onerror {quit -force}
transcript on

vlib work
vlib riviera/xilinx_vip
vlib riviera/xpm
vlib riviera/axi_infrastructure_v1_1_0
vlib riviera/axi_vip_v1_1_19
vlib riviera/processing_system7_vip_v1_0_21
vlib riviera/xil_defaultlib
vlib riviera/axi_lite_ipif_v3_0_4
vlib riviera/lib_cdc_v1_0_3
vlib riviera/interrupt_control_v3_1_5
vlib riviera/axi_gpio_v2_0_35
vlib riviera/xlconstant_v1_1_9
vlib riviera/proc_sys_reset_v5_0_16
vlib riviera/smartconnect_v1_0
vlib riviera/axi_register_slice_v2_1_33

vmap xilinx_vip riviera/xilinx_vip
vmap xpm riviera/xpm
vmap axi_infrastructure_v1_1_0 riviera/axi_infrastructure_v1_1_0
vmap axi_vip_v1_1_19 riviera/axi_vip_v1_1_19
vmap processing_system7_vip_v1_0_21 riviera/processing_system7_vip_v1_0_21
vmap xil_defaultlib riviera/xil_defaultlib
vmap axi_lite_ipif_v3_0_4 riviera/axi_lite_ipif_v3_0_4
vmap lib_cdc_v1_0_3 riviera/lib_cdc_v1_0_3
vmap interrupt_control_v3_1_5 riviera/interrupt_control_v3_1_5
vmap axi_gpio_v2_0_35 riviera/axi_gpio_v2_0_35
vmap xlconstant_v1_1_9 riviera/xlconstant_v1_1_9
vmap proc_sys_reset_v5_0_16 riviera/proc_sys_reset_v5_0_16
vmap smartconnect_v1_0 riviera/smartconnect_v1_0
vmap axi_register_slice_v2_1_33 riviera/axi_register_slice_v2_1_33

vlog -work xilinx_vip  -incr "+incdir+/home/richard/embedded/Vivado/2024.2/data/xilinx_vip/include" -l xilinx_vip -l xpm -l axi_infrastructure_v1_1_0 -l axi_vip_v1_1_19 -l processing_system7_vip_v1_0_21 -l xil_defaultlib -l axi_lite_ipif_v3_0_4 -l lib_cdc_v1_0_3 -l interrupt_control_v3_1_5 -l axi_gpio_v2_0_35 -l xlconstant_v1_1_9 -l proc_sys_reset_v5_0_16 -l smartconnect_v1_0 -l axi_register_slice_v2_1_33 \
"/home/richard/embedded/Vivado/2024.2/data/xilinx_vip/hdl/axi4stream_vip_axi4streampc.sv" \
"/home/richard/embedded/Vivado/2024.2/data/xilinx_vip/hdl/axi_vip_axi4pc.sv" \
"/home/richard/embedded/Vivado/2024.2/data/xilinx_vip/hdl/xil_common_vip_pkg.sv" \
"/home/richard/embedded/Vivado/2024.2/data/xilinx_vip/hdl/axi4stream_vip_pkg.sv" \
"/home/richard/embedded/Vivado/2024.2/data/xilinx_vip/hdl/axi_vip_pkg.sv" \
"/home/richard/embedded/Vivado/2024.2/data/xilinx_vip/hdl/axi4stream_vip_if.sv" \
"/home/richard/embedded/Vivado/2024.2/data/xilinx_vip/hdl/axi_vip_if.sv" \
"/home/richard/embedded/Vivado/2024.2/data/xilinx_vip/hdl/clk_vip_if.sv" \
"/home/richard/embedded/Vivado/2024.2/data/xilinx_vip/hdl/rst_vip_if.sv" \

vlog -work xpm  -incr "+incdir+../../../../blinky.gen/sources_1/bd/blinky/ipshared/ec67/hdl" "+incdir+../../../../blinky.gen/sources_1/bd/blinky/ipshared/86fe/hdl" "+incdir+../../../../blinky.gen/sources_1/bd/blinky/ipshared/f0b6/hdl/verilog" "+incdir+../../../../blinky.gen/sources_1/bd/blinky/ipshared/0127/hdl/verilog" "+incdir+/home/richard/embedded/Vivado/2024.2/data/xilinx_vip/include" -l xilinx_vip -l xpm -l axi_infrastructure_v1_1_0 -l axi_vip_v1_1_19 -l processing_system7_vip_v1_0_21 -l xil_defaultlib -l axi_lite_ipif_v3_0_4 -l lib_cdc_v1_0_3 -l interrupt_control_v3_1_5 -l axi_gpio_v2_0_35 -l xlconstant_v1_1_9 -l proc_sys_reset_v5_0_16 -l smartconnect_v1_0 -l axi_register_slice_v2_1_33 \
"/home/richard/embedded/Vivado/2024.2/data/ip/xpm/xpm_fifo/hdl/xpm_fifo.sv" \
"/home/richard/embedded/Vivado/2024.2/data/ip/xpm/xpm_memory/hdl/xpm_memory.sv" \
"/home/richard/embedded/Vivado/2024.2/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \

vcom -work xpm -93  -incr \
"/home/richard/embedded/Vivado/2024.2/data/ip/xpm/xpm_VCOMP.vhd" \

vlog -work axi_infrastructure_v1_1_0  -incr -v2k5 "+incdir+../../../../blinky.gen/sources_1/bd/blinky/ipshared/ec67/hdl" "+incdir+../../../../blinky.gen/sources_1/bd/blinky/ipshared/86fe/hdl" "+incdir+../../../../blinky.gen/sources_1/bd/blinky/ipshared/f0b6/hdl/verilog" "+incdir+../../../../blinky.gen/sources_1/bd/blinky/ipshared/0127/hdl/verilog" "+incdir+/home/richard/embedded/Vivado/2024.2/data/xilinx_vip/include" -l xilinx_vip -l xpm -l axi_infrastructure_v1_1_0 -l axi_vip_v1_1_19 -l processing_system7_vip_v1_0_21 -l xil_defaultlib -l axi_lite_ipif_v3_0_4 -l lib_cdc_v1_0_3 -l interrupt_control_v3_1_5 -l axi_gpio_v2_0_35 -l xlconstant_v1_1_9 -l proc_sys_reset_v5_0_16 -l smartconnect_v1_0 -l axi_register_slice_v2_1_33 \
"../../../../blinky.gen/sources_1/bd/blinky/ipshared/ec67/hdl/axi_infrastructure_v1_1_vl_rfs.v" \

vlog -work axi_vip_v1_1_19  -incr "+incdir+../../../../blinky.gen/sources_1/bd/blinky/ipshared/ec67/hdl" "+incdir+../../../../blinky.gen/sources_1/bd/blinky/ipshared/86fe/hdl" "+incdir+../../../../blinky.gen/sources_1/bd/blinky/ipshared/f0b6/hdl/verilog" "+incdir+../../../../blinky.gen/sources_1/bd/blinky/ipshared/0127/hdl/verilog" "+incdir+/home/richard/embedded/Vivado/2024.2/data/xilinx_vip/include" -l xilinx_vip -l xpm -l axi_infrastructure_v1_1_0 -l axi_vip_v1_1_19 -l processing_system7_vip_v1_0_21 -l xil_defaultlib -l axi_lite_ipif_v3_0_4 -l lib_cdc_v1_0_3 -l interrupt_control_v3_1_5 -l axi_gpio_v2_0_35 -l xlconstant_v1_1_9 -l proc_sys_reset_v5_0_16 -l smartconnect_v1_0 -l axi_register_slice_v2_1_33 \
"../../../../blinky.gen/sources_1/bd/blinky/ipshared/8c45/hdl/axi_vip_v1_1_vl_rfs.sv" \

vlog -work processing_system7_vip_v1_0_21  -incr "+incdir+../../../../blinky.gen/sources_1/bd/blinky/ipshared/ec67/hdl" "+incdir+../../../../blinky.gen/sources_1/bd/blinky/ipshared/86fe/hdl" "+incdir+../../../../blinky.gen/sources_1/bd/blinky/ipshared/f0b6/hdl/verilog" "+incdir+../../../../blinky.gen/sources_1/bd/blinky/ipshared/0127/hdl/verilog" "+incdir+/home/richard/embedded/Vivado/2024.2/data/xilinx_vip/include" -l xilinx_vip -l xpm -l axi_infrastructure_v1_1_0 -l axi_vip_v1_1_19 -l processing_system7_vip_v1_0_21 -l xil_defaultlib -l axi_lite_ipif_v3_0_4 -l lib_cdc_v1_0_3 -l interrupt_control_v3_1_5 -l axi_gpio_v2_0_35 -l xlconstant_v1_1_9 -l proc_sys_reset_v5_0_16 -l smartconnect_v1_0 -l axi_register_slice_v2_1_33 \
"../../../../blinky.gen/sources_1/bd/blinky/ipshared/86fe/hdl/processing_system7_vip_v1_0_vl_rfs.sv" \

vlog -work xil_defaultlib  -incr -v2k5 "+incdir+../../../../blinky.gen/sources_1/bd/blinky/ipshared/ec67/hdl" "+incdir+../../../../blinky.gen/sources_1/bd/blinky/ipshared/86fe/hdl" "+incdir+../../../../blinky.gen/sources_1/bd/blinky/ipshared/f0b6/hdl/verilog" "+incdir+../../../../blinky.gen/sources_1/bd/blinky/ipshared/0127/hdl/verilog" "+incdir+/home/richard/embedded/Vivado/2024.2/data/xilinx_vip/include" -l xilinx_vip -l xpm -l axi_infrastructure_v1_1_0 -l axi_vip_v1_1_19 -l processing_system7_vip_v1_0_21 -l xil_defaultlib -l axi_lite_ipif_v3_0_4 -l lib_cdc_v1_0_3 -l interrupt_control_v3_1_5 -l axi_gpio_v2_0_35 -l xlconstant_v1_1_9 -l proc_sys_reset_v5_0_16 -l smartconnect_v1_0 -l axi_register_slice_v2_1_33 \
"../../../../blinky.gen/sources_1/bd/blinky/ip/blinky_processing_system7_0_0/sim/blinky_processing_system7_0_0.v" \

vcom -work axi_lite_ipif_v3_0_4 -93  -incr \
"../../../../blinky.gen/sources_1/bd/blinky/ipshared/66ea/hdl/axi_lite_ipif_v3_0_vh_rfs.vhd" \

vcom -work lib_cdc_v1_0_3 -93  -incr \
"../../../../blinky.gen/sources_1/bd/blinky/ipshared/2a4f/hdl/lib_cdc_v1_0_rfs.vhd" \

vcom -work interrupt_control_v3_1_5 -93  -incr \
"../../../../blinky.gen/sources_1/bd/blinky/ipshared/d8cc/hdl/interrupt_control_v3_1_vh_rfs.vhd" \

vcom -work axi_gpio_v2_0_35 -93  -incr \
"../../../../blinky.gen/sources_1/bd/blinky/ipshared/6718/hdl/axi_gpio_v2_0_vh_rfs.vhd" \

vcom -work xil_defaultlib -93  -incr \
"../../../../blinky.gen/sources_1/bd/blinky/ip/blinky_axi_gpio_0_0/sim/blinky_axi_gpio_0_0.vhd" \

vlog -work xil_defaultlib  -incr -v2k5 "+incdir+../../../../blinky.gen/sources_1/bd/blinky/ipshared/ec67/hdl" "+incdir+../../../../blinky.gen/sources_1/bd/blinky/ipshared/86fe/hdl" "+incdir+../../../../blinky.gen/sources_1/bd/blinky/ipshared/f0b6/hdl/verilog" "+incdir+../../../../blinky.gen/sources_1/bd/blinky/ipshared/0127/hdl/verilog" "+incdir+/home/richard/embedded/Vivado/2024.2/data/xilinx_vip/include" -l xilinx_vip -l xpm -l axi_infrastructure_v1_1_0 -l axi_vip_v1_1_19 -l processing_system7_vip_v1_0_21 -l xil_defaultlib -l axi_lite_ipif_v3_0_4 -l lib_cdc_v1_0_3 -l interrupt_control_v3_1_5 -l axi_gpio_v2_0_35 -l xlconstant_v1_1_9 -l proc_sys_reset_v5_0_16 -l smartconnect_v1_0 -l axi_register_slice_v2_1_33 \
"../../../../blinky.gen/sources_1/bd/blinky/ip/blinky_axi_smc_0/bd_0/sim/bd_706f.v" \

vlog -work xlconstant_v1_1_9  -incr -v2k5 "+incdir+../../../../blinky.gen/sources_1/bd/blinky/ipshared/ec67/hdl" "+incdir+../../../../blinky.gen/sources_1/bd/blinky/ipshared/86fe/hdl" "+incdir+../../../../blinky.gen/sources_1/bd/blinky/ipshared/f0b6/hdl/verilog" "+incdir+../../../../blinky.gen/sources_1/bd/blinky/ipshared/0127/hdl/verilog" "+incdir+/home/richard/embedded/Vivado/2024.2/data/xilinx_vip/include" -l xilinx_vip -l xpm -l axi_infrastructure_v1_1_0 -l axi_vip_v1_1_19 -l processing_system7_vip_v1_0_21 -l xil_defaultlib -l axi_lite_ipif_v3_0_4 -l lib_cdc_v1_0_3 -l interrupt_control_v3_1_5 -l axi_gpio_v2_0_35 -l xlconstant_v1_1_9 -l proc_sys_reset_v5_0_16 -l smartconnect_v1_0 -l axi_register_slice_v2_1_33 \
"../../../../blinky.gen/sources_1/bd/blinky/ipshared/e2d2/hdl/xlconstant_v1_1_vl_rfs.v" \

vlog -work xil_defaultlib  -incr -v2k5 "+incdir+../../../../blinky.gen/sources_1/bd/blinky/ipshared/ec67/hdl" "+incdir+../../../../blinky.gen/sources_1/bd/blinky/ipshared/86fe/hdl" "+incdir+../../../../blinky.gen/sources_1/bd/blinky/ipshared/f0b6/hdl/verilog" "+incdir+../../../../blinky.gen/sources_1/bd/blinky/ipshared/0127/hdl/verilog" "+incdir+/home/richard/embedded/Vivado/2024.2/data/xilinx_vip/include" -l xilinx_vip -l xpm -l axi_infrastructure_v1_1_0 -l axi_vip_v1_1_19 -l processing_system7_vip_v1_0_21 -l xil_defaultlib -l axi_lite_ipif_v3_0_4 -l lib_cdc_v1_0_3 -l interrupt_control_v3_1_5 -l axi_gpio_v2_0_35 -l xlconstant_v1_1_9 -l proc_sys_reset_v5_0_16 -l smartconnect_v1_0 -l axi_register_slice_v2_1_33 \
"../../../../blinky.gen/sources_1/bd/blinky/ip/blinky_axi_smc_0/bd_0/ip/ip_0/sim/bd_706f_one_0.v" \

vcom -work proc_sys_reset_v5_0_16 -93  -incr \
"../../../../blinky.gen/sources_1/bd/blinky/ipshared/0831/hdl/proc_sys_reset_v5_0_vh_rfs.vhd" \

vcom -work xil_defaultlib -93  -incr \
"../../../../blinky.gen/sources_1/bd/blinky/ip/blinky_axi_smc_0/bd_0/ip/ip_1/sim/bd_706f_psr_aclk_0.vhd" \

vlog -work smartconnect_v1_0  -incr "+incdir+../../../../blinky.gen/sources_1/bd/blinky/ipshared/ec67/hdl" "+incdir+../../../../blinky.gen/sources_1/bd/blinky/ipshared/86fe/hdl" "+incdir+../../../../blinky.gen/sources_1/bd/blinky/ipshared/f0b6/hdl/verilog" "+incdir+../../../../blinky.gen/sources_1/bd/blinky/ipshared/0127/hdl/verilog" "+incdir+/home/richard/embedded/Vivado/2024.2/data/xilinx_vip/include" -l xilinx_vip -l xpm -l axi_infrastructure_v1_1_0 -l axi_vip_v1_1_19 -l processing_system7_vip_v1_0_21 -l xil_defaultlib -l axi_lite_ipif_v3_0_4 -l lib_cdc_v1_0_3 -l interrupt_control_v3_1_5 -l axi_gpio_v2_0_35 -l xlconstant_v1_1_9 -l proc_sys_reset_v5_0_16 -l smartconnect_v1_0 -l axi_register_slice_v2_1_33 \
"../../../../blinky.gen/sources_1/bd/blinky/ipshared/f0b6/hdl/sc_util_v1_0_vl_rfs.sv" \
"../../../../blinky.gen/sources_1/bd/blinky/ipshared/f49a/hdl/sc_mmu_v1_0_vl_rfs.sv" \

vlog -work xil_defaultlib  -incr "+incdir+../../../../blinky.gen/sources_1/bd/blinky/ipshared/ec67/hdl" "+incdir+../../../../blinky.gen/sources_1/bd/blinky/ipshared/86fe/hdl" "+incdir+../../../../blinky.gen/sources_1/bd/blinky/ipshared/f0b6/hdl/verilog" "+incdir+../../../../blinky.gen/sources_1/bd/blinky/ipshared/0127/hdl/verilog" "+incdir+/home/richard/embedded/Vivado/2024.2/data/xilinx_vip/include" -l xilinx_vip -l xpm -l axi_infrastructure_v1_1_0 -l axi_vip_v1_1_19 -l processing_system7_vip_v1_0_21 -l xil_defaultlib -l axi_lite_ipif_v3_0_4 -l lib_cdc_v1_0_3 -l interrupt_control_v3_1_5 -l axi_gpio_v2_0_35 -l xlconstant_v1_1_9 -l proc_sys_reset_v5_0_16 -l smartconnect_v1_0 -l axi_register_slice_v2_1_33 \
"../../../../blinky.gen/sources_1/bd/blinky/ip/blinky_axi_smc_0/bd_0/ip/ip_2/sim/bd_706f_s00mmu_0.sv" \

vlog -work smartconnect_v1_0  -incr "+incdir+../../../../blinky.gen/sources_1/bd/blinky/ipshared/ec67/hdl" "+incdir+../../../../blinky.gen/sources_1/bd/blinky/ipshared/86fe/hdl" "+incdir+../../../../blinky.gen/sources_1/bd/blinky/ipshared/f0b6/hdl/verilog" "+incdir+../../../../blinky.gen/sources_1/bd/blinky/ipshared/0127/hdl/verilog" "+incdir+/home/richard/embedded/Vivado/2024.2/data/xilinx_vip/include" -l xilinx_vip -l xpm -l axi_infrastructure_v1_1_0 -l axi_vip_v1_1_19 -l processing_system7_vip_v1_0_21 -l xil_defaultlib -l axi_lite_ipif_v3_0_4 -l lib_cdc_v1_0_3 -l interrupt_control_v3_1_5 -l axi_gpio_v2_0_35 -l xlconstant_v1_1_9 -l proc_sys_reset_v5_0_16 -l smartconnect_v1_0 -l axi_register_slice_v2_1_33 \
"../../../../blinky.gen/sources_1/bd/blinky/ipshared/2da8/hdl/sc_transaction_regulator_v1_0_vl_rfs.sv" \

vlog -work xil_defaultlib  -incr "+incdir+../../../../blinky.gen/sources_1/bd/blinky/ipshared/ec67/hdl" "+incdir+../../../../blinky.gen/sources_1/bd/blinky/ipshared/86fe/hdl" "+incdir+../../../../blinky.gen/sources_1/bd/blinky/ipshared/f0b6/hdl/verilog" "+incdir+../../../../blinky.gen/sources_1/bd/blinky/ipshared/0127/hdl/verilog" "+incdir+/home/richard/embedded/Vivado/2024.2/data/xilinx_vip/include" -l xilinx_vip -l xpm -l axi_infrastructure_v1_1_0 -l axi_vip_v1_1_19 -l processing_system7_vip_v1_0_21 -l xil_defaultlib -l axi_lite_ipif_v3_0_4 -l lib_cdc_v1_0_3 -l interrupt_control_v3_1_5 -l axi_gpio_v2_0_35 -l xlconstant_v1_1_9 -l proc_sys_reset_v5_0_16 -l smartconnect_v1_0 -l axi_register_slice_v2_1_33 \
"../../../../blinky.gen/sources_1/bd/blinky/ip/blinky_axi_smc_0/bd_0/ip/ip_3/sim/bd_706f_s00tr_0.sv" \

vlog -work smartconnect_v1_0  -incr "+incdir+../../../../blinky.gen/sources_1/bd/blinky/ipshared/ec67/hdl" "+incdir+../../../../blinky.gen/sources_1/bd/blinky/ipshared/86fe/hdl" "+incdir+../../../../blinky.gen/sources_1/bd/blinky/ipshared/f0b6/hdl/verilog" "+incdir+../../../../blinky.gen/sources_1/bd/blinky/ipshared/0127/hdl/verilog" "+incdir+/home/richard/embedded/Vivado/2024.2/data/xilinx_vip/include" -l xilinx_vip -l xpm -l axi_infrastructure_v1_1_0 -l axi_vip_v1_1_19 -l processing_system7_vip_v1_0_21 -l xil_defaultlib -l axi_lite_ipif_v3_0_4 -l lib_cdc_v1_0_3 -l interrupt_control_v3_1_5 -l axi_gpio_v2_0_35 -l xlconstant_v1_1_9 -l proc_sys_reset_v5_0_16 -l smartconnect_v1_0 -l axi_register_slice_v2_1_33 \
"../../../../blinky.gen/sources_1/bd/blinky/ipshared/63ed/hdl/sc_si_converter_v1_0_vl_rfs.sv" \

vlog -work xil_defaultlib  -incr "+incdir+../../../../blinky.gen/sources_1/bd/blinky/ipshared/ec67/hdl" "+incdir+../../../../blinky.gen/sources_1/bd/blinky/ipshared/86fe/hdl" "+incdir+../../../../blinky.gen/sources_1/bd/blinky/ipshared/f0b6/hdl/verilog" "+incdir+../../../../blinky.gen/sources_1/bd/blinky/ipshared/0127/hdl/verilog" "+incdir+/home/richard/embedded/Vivado/2024.2/data/xilinx_vip/include" -l xilinx_vip -l xpm -l axi_infrastructure_v1_1_0 -l axi_vip_v1_1_19 -l processing_system7_vip_v1_0_21 -l xil_defaultlib -l axi_lite_ipif_v3_0_4 -l lib_cdc_v1_0_3 -l interrupt_control_v3_1_5 -l axi_gpio_v2_0_35 -l xlconstant_v1_1_9 -l proc_sys_reset_v5_0_16 -l smartconnect_v1_0 -l axi_register_slice_v2_1_33 \
"../../../../blinky.gen/sources_1/bd/blinky/ip/blinky_axi_smc_0/bd_0/ip/ip_4/sim/bd_706f_s00sic_0.sv" \

vlog -work smartconnect_v1_0  -incr "+incdir+../../../../blinky.gen/sources_1/bd/blinky/ipshared/ec67/hdl" "+incdir+../../../../blinky.gen/sources_1/bd/blinky/ipshared/86fe/hdl" "+incdir+../../../../blinky.gen/sources_1/bd/blinky/ipshared/f0b6/hdl/verilog" "+incdir+../../../../blinky.gen/sources_1/bd/blinky/ipshared/0127/hdl/verilog" "+incdir+/home/richard/embedded/Vivado/2024.2/data/xilinx_vip/include" -l xilinx_vip -l xpm -l axi_infrastructure_v1_1_0 -l axi_vip_v1_1_19 -l processing_system7_vip_v1_0_21 -l xil_defaultlib -l axi_lite_ipif_v3_0_4 -l lib_cdc_v1_0_3 -l interrupt_control_v3_1_5 -l axi_gpio_v2_0_35 -l xlconstant_v1_1_9 -l proc_sys_reset_v5_0_16 -l smartconnect_v1_0 -l axi_register_slice_v2_1_33 \
"../../../../blinky.gen/sources_1/bd/blinky/ipshared/cef3/hdl/sc_axi2sc_v1_0_vl_rfs.sv" \

vlog -work xil_defaultlib  -incr "+incdir+../../../../blinky.gen/sources_1/bd/blinky/ipshared/ec67/hdl" "+incdir+../../../../blinky.gen/sources_1/bd/blinky/ipshared/86fe/hdl" "+incdir+../../../../blinky.gen/sources_1/bd/blinky/ipshared/f0b6/hdl/verilog" "+incdir+../../../../blinky.gen/sources_1/bd/blinky/ipshared/0127/hdl/verilog" "+incdir+/home/richard/embedded/Vivado/2024.2/data/xilinx_vip/include" -l xilinx_vip -l xpm -l axi_infrastructure_v1_1_0 -l axi_vip_v1_1_19 -l processing_system7_vip_v1_0_21 -l xil_defaultlib -l axi_lite_ipif_v3_0_4 -l lib_cdc_v1_0_3 -l interrupt_control_v3_1_5 -l axi_gpio_v2_0_35 -l xlconstant_v1_1_9 -l proc_sys_reset_v5_0_16 -l smartconnect_v1_0 -l axi_register_slice_v2_1_33 \
"../../../../blinky.gen/sources_1/bd/blinky/ip/blinky_axi_smc_0/bd_0/ip/ip_5/sim/bd_706f_s00a2s_0.sv" \

vlog -work smartconnect_v1_0  -incr "+incdir+../../../../blinky.gen/sources_1/bd/blinky/ipshared/ec67/hdl" "+incdir+../../../../blinky.gen/sources_1/bd/blinky/ipshared/86fe/hdl" "+incdir+../../../../blinky.gen/sources_1/bd/blinky/ipshared/f0b6/hdl/verilog" "+incdir+../../../../blinky.gen/sources_1/bd/blinky/ipshared/0127/hdl/verilog" "+incdir+/home/richard/embedded/Vivado/2024.2/data/xilinx_vip/include" -l xilinx_vip -l xpm -l axi_infrastructure_v1_1_0 -l axi_vip_v1_1_19 -l processing_system7_vip_v1_0_21 -l xil_defaultlib -l axi_lite_ipif_v3_0_4 -l lib_cdc_v1_0_3 -l interrupt_control_v3_1_5 -l axi_gpio_v2_0_35 -l xlconstant_v1_1_9 -l proc_sys_reset_v5_0_16 -l smartconnect_v1_0 -l axi_register_slice_v2_1_33 \
"../../../../blinky.gen/sources_1/bd/blinky/ipshared/0127/hdl/sc_node_v1_0_vl_rfs.sv" \

vlog -work xil_defaultlib  -incr "+incdir+../../../../blinky.gen/sources_1/bd/blinky/ipshared/ec67/hdl" "+incdir+../../../../blinky.gen/sources_1/bd/blinky/ipshared/86fe/hdl" "+incdir+../../../../blinky.gen/sources_1/bd/blinky/ipshared/f0b6/hdl/verilog" "+incdir+../../../../blinky.gen/sources_1/bd/blinky/ipshared/0127/hdl/verilog" "+incdir+/home/richard/embedded/Vivado/2024.2/data/xilinx_vip/include" -l xilinx_vip -l xpm -l axi_infrastructure_v1_1_0 -l axi_vip_v1_1_19 -l processing_system7_vip_v1_0_21 -l xil_defaultlib -l axi_lite_ipif_v3_0_4 -l lib_cdc_v1_0_3 -l interrupt_control_v3_1_5 -l axi_gpio_v2_0_35 -l xlconstant_v1_1_9 -l proc_sys_reset_v5_0_16 -l smartconnect_v1_0 -l axi_register_slice_v2_1_33 \
"../../../../blinky.gen/sources_1/bd/blinky/ip/blinky_axi_smc_0/bd_0/ip/ip_6/sim/bd_706f_sarn_0.sv" \
"../../../../blinky.gen/sources_1/bd/blinky/ip/blinky_axi_smc_0/bd_0/ip/ip_7/sim/bd_706f_srn_0.sv" \
"../../../../blinky.gen/sources_1/bd/blinky/ip/blinky_axi_smc_0/bd_0/ip/ip_8/sim/bd_706f_sawn_0.sv" \
"../../../../blinky.gen/sources_1/bd/blinky/ip/blinky_axi_smc_0/bd_0/ip/ip_9/sim/bd_706f_swn_0.sv" \
"../../../../blinky.gen/sources_1/bd/blinky/ip/blinky_axi_smc_0/bd_0/ip/ip_10/sim/bd_706f_sbn_0.sv" \

vlog -work smartconnect_v1_0  -incr "+incdir+../../../../blinky.gen/sources_1/bd/blinky/ipshared/ec67/hdl" "+incdir+../../../../blinky.gen/sources_1/bd/blinky/ipshared/86fe/hdl" "+incdir+../../../../blinky.gen/sources_1/bd/blinky/ipshared/f0b6/hdl/verilog" "+incdir+../../../../blinky.gen/sources_1/bd/blinky/ipshared/0127/hdl/verilog" "+incdir+/home/richard/embedded/Vivado/2024.2/data/xilinx_vip/include" -l xilinx_vip -l xpm -l axi_infrastructure_v1_1_0 -l axi_vip_v1_1_19 -l processing_system7_vip_v1_0_21 -l xil_defaultlib -l axi_lite_ipif_v3_0_4 -l lib_cdc_v1_0_3 -l interrupt_control_v3_1_5 -l axi_gpio_v2_0_35 -l xlconstant_v1_1_9 -l proc_sys_reset_v5_0_16 -l smartconnect_v1_0 -l axi_register_slice_v2_1_33 \
"../../../../blinky.gen/sources_1/bd/blinky/ipshared/7f4f/hdl/sc_sc2axi_v1_0_vl_rfs.sv" \

vlog -work xil_defaultlib  -incr "+incdir+../../../../blinky.gen/sources_1/bd/blinky/ipshared/ec67/hdl" "+incdir+../../../../blinky.gen/sources_1/bd/blinky/ipshared/86fe/hdl" "+incdir+../../../../blinky.gen/sources_1/bd/blinky/ipshared/f0b6/hdl/verilog" "+incdir+../../../../blinky.gen/sources_1/bd/blinky/ipshared/0127/hdl/verilog" "+incdir+/home/richard/embedded/Vivado/2024.2/data/xilinx_vip/include" -l xilinx_vip -l xpm -l axi_infrastructure_v1_1_0 -l axi_vip_v1_1_19 -l processing_system7_vip_v1_0_21 -l xil_defaultlib -l axi_lite_ipif_v3_0_4 -l lib_cdc_v1_0_3 -l interrupt_control_v3_1_5 -l axi_gpio_v2_0_35 -l xlconstant_v1_1_9 -l proc_sys_reset_v5_0_16 -l smartconnect_v1_0 -l axi_register_slice_v2_1_33 \
"../../../../blinky.gen/sources_1/bd/blinky/ip/blinky_axi_smc_0/bd_0/ip/ip_11/sim/bd_706f_m00s2a_0.sv" \

vlog -work smartconnect_v1_0  -incr "+incdir+../../../../blinky.gen/sources_1/bd/blinky/ipshared/ec67/hdl" "+incdir+../../../../blinky.gen/sources_1/bd/blinky/ipshared/86fe/hdl" "+incdir+../../../../blinky.gen/sources_1/bd/blinky/ipshared/f0b6/hdl/verilog" "+incdir+../../../../blinky.gen/sources_1/bd/blinky/ipshared/0127/hdl/verilog" "+incdir+/home/richard/embedded/Vivado/2024.2/data/xilinx_vip/include" -l xilinx_vip -l xpm -l axi_infrastructure_v1_1_0 -l axi_vip_v1_1_19 -l processing_system7_vip_v1_0_21 -l xil_defaultlib -l axi_lite_ipif_v3_0_4 -l lib_cdc_v1_0_3 -l interrupt_control_v3_1_5 -l axi_gpio_v2_0_35 -l xlconstant_v1_1_9 -l proc_sys_reset_v5_0_16 -l smartconnect_v1_0 -l axi_register_slice_v2_1_33 \
"../../../../blinky.gen/sources_1/bd/blinky/ipshared/37bc/hdl/sc_exit_v1_0_vl_rfs.sv" \

vlog -work xil_defaultlib  -incr "+incdir+../../../../blinky.gen/sources_1/bd/blinky/ipshared/ec67/hdl" "+incdir+../../../../blinky.gen/sources_1/bd/blinky/ipshared/86fe/hdl" "+incdir+../../../../blinky.gen/sources_1/bd/blinky/ipshared/f0b6/hdl/verilog" "+incdir+../../../../blinky.gen/sources_1/bd/blinky/ipshared/0127/hdl/verilog" "+incdir+/home/richard/embedded/Vivado/2024.2/data/xilinx_vip/include" -l xilinx_vip -l xpm -l axi_infrastructure_v1_1_0 -l axi_vip_v1_1_19 -l processing_system7_vip_v1_0_21 -l xil_defaultlib -l axi_lite_ipif_v3_0_4 -l lib_cdc_v1_0_3 -l interrupt_control_v3_1_5 -l axi_gpio_v2_0_35 -l xlconstant_v1_1_9 -l proc_sys_reset_v5_0_16 -l smartconnect_v1_0 -l axi_register_slice_v2_1_33 \
"../../../../blinky.gen/sources_1/bd/blinky/ip/blinky_axi_smc_0/bd_0/ip/ip_12/sim/bd_706f_m00e_0.sv" \

vlog -work smartconnect_v1_0  -incr "+incdir+../../../../blinky.gen/sources_1/bd/blinky/ipshared/ec67/hdl" "+incdir+../../../../blinky.gen/sources_1/bd/blinky/ipshared/86fe/hdl" "+incdir+../../../../blinky.gen/sources_1/bd/blinky/ipshared/f0b6/hdl/verilog" "+incdir+../../../../blinky.gen/sources_1/bd/blinky/ipshared/0127/hdl/verilog" "+incdir+/home/richard/embedded/Vivado/2024.2/data/xilinx_vip/include" -l xilinx_vip -l xpm -l axi_infrastructure_v1_1_0 -l axi_vip_v1_1_19 -l processing_system7_vip_v1_0_21 -l xil_defaultlib -l axi_lite_ipif_v3_0_4 -l lib_cdc_v1_0_3 -l interrupt_control_v3_1_5 -l axi_gpio_v2_0_35 -l xlconstant_v1_1_9 -l proc_sys_reset_v5_0_16 -l smartconnect_v1_0 -l axi_register_slice_v2_1_33 \
"../../../../blinky.gen/sources_1/bd/blinky/ipshared/3718/hdl/sc_switchboard_v1_0_vl_rfs.sv" \

vlog -work axi_register_slice_v2_1_33  -incr -v2k5 "+incdir+../../../../blinky.gen/sources_1/bd/blinky/ipshared/ec67/hdl" "+incdir+../../../../blinky.gen/sources_1/bd/blinky/ipshared/86fe/hdl" "+incdir+../../../../blinky.gen/sources_1/bd/blinky/ipshared/f0b6/hdl/verilog" "+incdir+../../../../blinky.gen/sources_1/bd/blinky/ipshared/0127/hdl/verilog" "+incdir+/home/richard/embedded/Vivado/2024.2/data/xilinx_vip/include" -l xilinx_vip -l xpm -l axi_infrastructure_v1_1_0 -l axi_vip_v1_1_19 -l processing_system7_vip_v1_0_21 -l xil_defaultlib -l axi_lite_ipif_v3_0_4 -l lib_cdc_v1_0_3 -l interrupt_control_v3_1_5 -l axi_gpio_v2_0_35 -l xlconstant_v1_1_9 -l proc_sys_reset_v5_0_16 -l smartconnect_v1_0 -l axi_register_slice_v2_1_33 \
"../../../../blinky.gen/sources_1/bd/blinky/ipshared/3ee4/hdl/axi_register_slice_v2_1_vl_rfs.v" \

vlog -work xil_defaultlib  -incr -v2k5 "+incdir+../../../../blinky.gen/sources_1/bd/blinky/ipshared/ec67/hdl" "+incdir+../../../../blinky.gen/sources_1/bd/blinky/ipshared/86fe/hdl" "+incdir+../../../../blinky.gen/sources_1/bd/blinky/ipshared/f0b6/hdl/verilog" "+incdir+../../../../blinky.gen/sources_1/bd/blinky/ipshared/0127/hdl/verilog" "+incdir+/home/richard/embedded/Vivado/2024.2/data/xilinx_vip/include" -l xilinx_vip -l xpm -l axi_infrastructure_v1_1_0 -l axi_vip_v1_1_19 -l processing_system7_vip_v1_0_21 -l xil_defaultlib -l axi_lite_ipif_v3_0_4 -l lib_cdc_v1_0_3 -l interrupt_control_v3_1_5 -l axi_gpio_v2_0_35 -l xlconstant_v1_1_9 -l proc_sys_reset_v5_0_16 -l smartconnect_v1_0 -l axi_register_slice_v2_1_33 \
"../../../../blinky.gen/sources_1/bd/blinky/ip/blinky_axi_smc_0/sim/blinky_axi_smc_0.v" \

vcom -work xil_defaultlib -93  -incr \
"../../../../blinky.gen/sources_1/bd/blinky/ip/blinky_rst_ps7_0_50M_0/sim/blinky_rst_ps7_0_50M_0.vhd" \

vlog -work xil_defaultlib  -incr -v2k5 "+incdir+../../../../blinky.gen/sources_1/bd/blinky/ipshared/ec67/hdl" "+incdir+../../../../blinky.gen/sources_1/bd/blinky/ipshared/86fe/hdl" "+incdir+../../../../blinky.gen/sources_1/bd/blinky/ipshared/f0b6/hdl/verilog" "+incdir+../../../../blinky.gen/sources_1/bd/blinky/ipshared/0127/hdl/verilog" "+incdir+/home/richard/embedded/Vivado/2024.2/data/xilinx_vip/include" -l xilinx_vip -l xpm -l axi_infrastructure_v1_1_0 -l axi_vip_v1_1_19 -l processing_system7_vip_v1_0_21 -l xil_defaultlib -l axi_lite_ipif_v3_0_4 -l lib_cdc_v1_0_3 -l interrupt_control_v3_1_5 -l axi_gpio_v2_0_35 -l xlconstant_v1_1_9 -l proc_sys_reset_v5_0_16 -l smartconnect_v1_0 -l axi_register_slice_v2_1_33 \
"../../../../blinky.gen/sources_1/bd/blinky/sim/blinky.v" \

vlog -work xil_defaultlib \
"glbl.v"

