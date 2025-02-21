#!/usr/bin/env bash
#**********************************************************************************************************
# Vivado (TM) v2024.2 (64-bit)
#
# Script generated by Vivado on Thu Feb 20 11:24:34 EST 2025
# SW Build 5239630 on Fri Nov 08 22:34:34 MST 2024
#
# Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
# Copyright 2022-2024 Advanced Micro Devices, Inc. All Rights Reserved. 
#
# Filename     : blinky.sh
# Simulator    : Cadence Xcelium Parallel Simulator
# Description  : Simulation script generated by export_simulation Tcl command
# Purpose      : Run 'compile', 'elaborate', 'simulate' steps for compiling, elaborating and simulating the
#                design. The script will copy the library mapping file from the compiled library directory,
#                create design library directories and library mappings in the mapping file.
#
# Usage        : blinky.sh
#                blinky.sh [-lib_map_path] [-step] [-keep_index] [-noclean_files]*
#                blinky.sh [-reset_run]
#                blinky.sh [-reset_log]
#                blinky.sh [-help]
#
#               * The -noclean_files switch is deprecated and will not peform any function (by default, the
#                 simulator generated files will not be removed unless -reset_run switch is used)
#
# Prerequisite : Before running export_simulation, you must first compile the AMD simulation library
#                using the 'compile_simlib' Tcl command (for more information, run 'compile_simlib -help'
#                command in the Vivado Tcl shell). After compiling the library, specify the -lib_map_path
#                switch with the directory path where the library is created while generating the script
#                with export_simulation.
#
#                Alternatively, you can set the library path by setting the following project property:-
#
#                 set_property compxlib.<simulator>_compiled_library_dir <path> [current_project]
#
#                You can also point to the simulation library by either setting the 'lib_map_path' global
#                variable in this script or specify it with the '-lib_map_path' switch while executing this
#                script (type 'blinky.sh -help' for more information).
#
#                Note: For pure RTL based designs, the -lib_map_path switch can be specified later with the
#                generated script, but if design is targetted for system simulation containing SystemC/C++/C
#                sources, then the library path MUST be specified upfront when calling export_simulation.
#
#                For more information, refer 'Vivado Design Suite User Guide:Logic simulation (UG900)'
#
#**********************************************************************************************************

# catch pipeline exit status
set -Eeuo pipefail

# set xmvhdl compile options
xmvhdl_opts="-64bit -messages -relax -logfile .tmp_log -update"

# set xmvlog compile options
xmvlog_opts="-64bit -messages -logfile .tmp_log -update"

# set xmelab elaboration options
xmelab_opts="-64bit -relax -access +r -namemap_mixgen -messages -logfile elaborate.log"

# set xmsim simulation options
xmsim_opts="-64bit -logfile simulate.log"

# set design libraries for elaboration
design_libs_elab="-libname xilinx_vip -libname xpm -libname axi_infrastructure_v1_1_0 -libname axi_vip_v1_1_19 -libname processing_system7_vip_v1_0_21 -libname xil_defaultlib -libname axi_lite_ipif_v3_0_4 -libname lib_cdc_v1_0_3 -libname interrupt_control_v3_1_5 -libname axi_gpio_v2_0_35 -libname xlconstant_v1_1_9 -libname proc_sys_reset_v5_0_16 -libname smartconnect_v1_0 -libname axi_register_slice_v2_1_33 -libname xilinx_vip -libname unisims_ver -libname unimacro_ver -libname secureip"

# set design libraries
design_libs=(simprims_ver xilinx_vip xpm axi_infrastructure_v1_1_0 axi_vip_v1_1_19 processing_system7_vip_v1_0_21 xil_defaultlib axi_lite_ipif_v3_0_4 lib_cdc_v1_0_3 interrupt_control_v3_1_5 axi_gpio_v2_0_35 xlconstant_v1_1_9 proc_sys_reset_v5_0_16 smartconnect_v1_0 axi_register_slice_v2_1_33)

# simulation root library directory
sim_lib_dir="xcelium_lib"

# script info
echo -e "blinky.sh - Script generated by export_simulation (Vivado v2024.2 (64-bit)-id)\n"

# main steps
run()
{
  check_args $*
  setup
  if [[ ($b_step == 1) ]]; then
    case $step in
      "compile" )
       init_lib
       compile
      ;;
      "elaborate" )
       elaborate
      ;;
      "simulate" )
       simulate
      ;;
      * )
        echo -e "ERROR: Invalid or missing step '$step' (type \"./blinky.sh -help\" for more information)\n"
        exit 1
      esac
  else
    init_lib
    compile
    elaborate
    simulate
  fi
}

# RUN_STEP: <compile>
compile()
{
  xmvlog -work xilinx_vip $xmvlog_opts -sv +incdir+"../../../../blinky.gen/sources_1/bd/blinky/ipshared/ec67/hdl" +incdir+"../../../../blinky.gen/sources_1/bd/blinky/ipshared/86fe/hdl" +incdir+"../../../../blinky.gen/sources_1/bd/blinky/ipshared/f0b6/hdl/verilog" +incdir+"../../../../blinky.gen/sources_1/bd/blinky/ipshared/0127/hdl/verilog" +incdir+"/home/drew/embedded/xilinx/Vivado/2024.2/data/xilinx_vip/include" \
  "/home/drew/embedded/xilinx/Vivado/2024.2/data/xilinx_vip/hdl/axi4stream_vip_axi4streampc.sv" \
  "/home/drew/embedded/xilinx/Vivado/2024.2/data/xilinx_vip/hdl/axi_vip_axi4pc.sv" \
  "/home/drew/embedded/xilinx/Vivado/2024.2/data/xilinx_vip/hdl/xil_common_vip_pkg.sv" \
  "/home/drew/embedded/xilinx/Vivado/2024.2/data/xilinx_vip/hdl/axi4stream_vip_pkg.sv" \
  "/home/drew/embedded/xilinx/Vivado/2024.2/data/xilinx_vip/hdl/axi_vip_pkg.sv" \
  "/home/drew/embedded/xilinx/Vivado/2024.2/data/xilinx_vip/hdl/axi4stream_vip_if.sv" \
  "/home/drew/embedded/xilinx/Vivado/2024.2/data/xilinx_vip/hdl/axi_vip_if.sv" \
  "/home/drew/embedded/xilinx/Vivado/2024.2/data/xilinx_vip/hdl/clk_vip_if.sv" \
  "/home/drew/embedded/xilinx/Vivado/2024.2/data/xilinx_vip/hdl/rst_vip_if.sv" \
  2>&1 | tee compile.log; cat .tmp_log > xmvlog.log 2>/dev/null

  xmvlog -work xpm $xmvlog_opts -sv +incdir+"../../../../blinky.gen/sources_1/bd/blinky/ipshared/ec67/hdl" +incdir+"../../../../blinky.gen/sources_1/bd/blinky/ipshared/86fe/hdl" +incdir+"../../../../blinky.gen/sources_1/bd/blinky/ipshared/f0b6/hdl/verilog" +incdir+"../../../../blinky.gen/sources_1/bd/blinky/ipshared/0127/hdl/verilog" +incdir+"/home/drew/embedded/xilinx/Vivado/2024.2/data/xilinx_vip/include" \
  "/home/drew/embedded/xilinx/Vivado/2024.2/data/ip/xpm/xpm_fifo/hdl/xpm_fifo.sv" \
  "/home/drew/embedded/xilinx/Vivado/2024.2/data/ip/xpm/xpm_memory/hdl/xpm_memory.sv" \
  "/home/drew/embedded/xilinx/Vivado/2024.2/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \
  2>&1 | tee -a compile.log; cat .tmp_log >> xmvlog.log 2>/dev/null

  xmvhdl -work xpm -V93 $xmvhdl_opts \
  "/home/drew/embedded/xilinx/Vivado/2024.2/data/ip/xpm/xpm_VCOMP.vhd" \
  2>&1 | tee -a compile.log; cat .tmp_log > xmvhdl.log 2>/dev/null

  xmvlog -work axi_infrastructure_v1_1_0 $xmvlog_opts +incdir+"../../../../blinky.gen/sources_1/bd/blinky/ipshared/ec67/hdl" +incdir+"../../../../blinky.gen/sources_1/bd/blinky/ipshared/86fe/hdl" +incdir+"../../../../blinky.gen/sources_1/bd/blinky/ipshared/f0b6/hdl/verilog" +incdir+"../../../../blinky.gen/sources_1/bd/blinky/ipshared/0127/hdl/verilog" +incdir+"/home/drew/embedded/xilinx/Vivado/2024.2/data/xilinx_vip/include" \
  "../../../../blinky.gen/sources_1/bd/blinky/ipshared/ec67/hdl/axi_infrastructure_v1_1_vl_rfs.v" \
  2>&1 | tee -a compile.log; cat .tmp_log >> xmvlog.log 2>/dev/null

  xmvlog -work axi_vip_v1_1_19 $xmvlog_opts -sv +incdir+"../../../../blinky.gen/sources_1/bd/blinky/ipshared/ec67/hdl" +incdir+"../../../../blinky.gen/sources_1/bd/blinky/ipshared/86fe/hdl" +incdir+"../../../../blinky.gen/sources_1/bd/blinky/ipshared/f0b6/hdl/verilog" +incdir+"../../../../blinky.gen/sources_1/bd/blinky/ipshared/0127/hdl/verilog" +incdir+"/home/drew/embedded/xilinx/Vivado/2024.2/data/xilinx_vip/include" \
  "../../../../blinky.gen/sources_1/bd/blinky/ipshared/8c45/hdl/axi_vip_v1_1_vl_rfs.sv" \
  2>&1 | tee -a compile.log; cat .tmp_log >> xmvlog.log 2>/dev/null

  xmvlog -work processing_system7_vip_v1_0_21 $xmvlog_opts -sv +incdir+"../../../../blinky.gen/sources_1/bd/blinky/ipshared/ec67/hdl" +incdir+"../../../../blinky.gen/sources_1/bd/blinky/ipshared/86fe/hdl" +incdir+"../../../../blinky.gen/sources_1/bd/blinky/ipshared/f0b6/hdl/verilog" +incdir+"../../../../blinky.gen/sources_1/bd/blinky/ipshared/0127/hdl/verilog" +incdir+"/home/drew/embedded/xilinx/Vivado/2024.2/data/xilinx_vip/include" \
  "../../../../blinky.gen/sources_1/bd/blinky/ipshared/86fe/hdl/processing_system7_vip_v1_0_vl_rfs.sv" \
  2>&1 | tee -a compile.log; cat .tmp_log >> xmvlog.log 2>/dev/null

  xmvlog -work xil_defaultlib $xmvlog_opts +incdir+"../../../../blinky.gen/sources_1/bd/blinky/ipshared/ec67/hdl" +incdir+"../../../../blinky.gen/sources_1/bd/blinky/ipshared/86fe/hdl" +incdir+"../../../../blinky.gen/sources_1/bd/blinky/ipshared/f0b6/hdl/verilog" +incdir+"../../../../blinky.gen/sources_1/bd/blinky/ipshared/0127/hdl/verilog" +incdir+"/home/drew/embedded/xilinx/Vivado/2024.2/data/xilinx_vip/include" \
  "../../../../blinky.gen/sources_1/bd/blinky/ip/blinky_processing_system7_0_0/sim/blinky_processing_system7_0_0.v" \
  2>&1 | tee -a compile.log; cat .tmp_log >> xmvlog.log 2>/dev/null

  xmvhdl -work axi_lite_ipif_v3_0_4 -V93 $xmvhdl_opts \
  "../../../../blinky.gen/sources_1/bd/blinky/ipshared/66ea/hdl/axi_lite_ipif_v3_0_vh_rfs.vhd" \
  2>&1 | tee -a compile.log; cat .tmp_log >> xmvhdl.log 2>/dev/null

  xmvhdl -work lib_cdc_v1_0_3 -V93 $xmvhdl_opts \
  "../../../../blinky.gen/sources_1/bd/blinky/ipshared/2a4f/hdl/lib_cdc_v1_0_rfs.vhd" \
  2>&1 | tee -a compile.log; cat .tmp_log >> xmvhdl.log 2>/dev/null

  xmvhdl -work interrupt_control_v3_1_5 -V93 $xmvhdl_opts \
  "../../../../blinky.gen/sources_1/bd/blinky/ipshared/d8cc/hdl/interrupt_control_v3_1_vh_rfs.vhd" \
  2>&1 | tee -a compile.log; cat .tmp_log >> xmvhdl.log 2>/dev/null

  xmvhdl -work axi_gpio_v2_0_35 -V93 $xmvhdl_opts \
  "../../../../blinky.gen/sources_1/bd/blinky/ipshared/6718/hdl/axi_gpio_v2_0_vh_rfs.vhd" \
  2>&1 | tee -a compile.log; cat .tmp_log >> xmvhdl.log 2>/dev/null

  xmvhdl -work xil_defaultlib -V93 $xmvhdl_opts \
  "../../../../blinky.gen/sources_1/bd/blinky/ip/blinky_axi_gpio_0_0/sim/blinky_axi_gpio_0_0.vhd" \
  2>&1 | tee -a compile.log; cat .tmp_log >> xmvhdl.log 2>/dev/null

  xmvlog -work xlconstant_v1_1_9 $xmvlog_opts +incdir+"../../../../blinky.gen/sources_1/bd/blinky/ipshared/ec67/hdl" +incdir+"../../../../blinky.gen/sources_1/bd/blinky/ipshared/86fe/hdl" +incdir+"../../../../blinky.gen/sources_1/bd/blinky/ipshared/f0b6/hdl/verilog" +incdir+"../../../../blinky.gen/sources_1/bd/blinky/ipshared/0127/hdl/verilog" +incdir+"/home/drew/embedded/xilinx/Vivado/2024.2/data/xilinx_vip/include" \
  "../../../../blinky.gen/sources_1/bd/blinky/ipshared/e2d2/hdl/xlconstant_v1_1_vl_rfs.v" \
  2>&1 | tee -a compile.log; cat .tmp_log >> xmvlog.log 2>/dev/null

  xmvlog -work xil_defaultlib $xmvlog_opts +incdir+"../../../../blinky.gen/sources_1/bd/blinky/ipshared/ec67/hdl" +incdir+"../../../../blinky.gen/sources_1/bd/blinky/ipshared/86fe/hdl" +incdir+"../../../../blinky.gen/sources_1/bd/blinky/ipshared/f0b6/hdl/verilog" +incdir+"../../../../blinky.gen/sources_1/bd/blinky/ipshared/0127/hdl/verilog" +incdir+"/home/drew/embedded/xilinx/Vivado/2024.2/data/xilinx_vip/include" \
  "../../../../blinky.gen/sources_1/bd/blinky/ip/blinky_axi_smc_0/bd_0/ip/ip_0/sim/bd_706f_one_0.v" \
  2>&1 | tee -a compile.log; cat .tmp_log >> xmvlog.log 2>/dev/null

  xmvhdl -work proc_sys_reset_v5_0_16 -V93 $xmvhdl_opts \
  "../../../../blinky.gen/sources_1/bd/blinky/ipshared/0831/hdl/proc_sys_reset_v5_0_vh_rfs.vhd" \
  2>&1 | tee -a compile.log; cat .tmp_log >> xmvhdl.log 2>/dev/null

  xmvhdl -work xil_defaultlib -V93 $xmvhdl_opts \
  "../../../../blinky.gen/sources_1/bd/blinky/ip/blinky_axi_smc_0/bd_0/ip/ip_1/sim/bd_706f_psr_aclk_0.vhd" \
  2>&1 | tee -a compile.log; cat .tmp_log >> xmvhdl.log 2>/dev/null

  xmvlog -work smartconnect_v1_0 $xmvlog_opts -sv +incdir+"../../../../blinky.gen/sources_1/bd/blinky/ipshared/ec67/hdl" +incdir+"../../../../blinky.gen/sources_1/bd/blinky/ipshared/86fe/hdl" +incdir+"../../../../blinky.gen/sources_1/bd/blinky/ipshared/f0b6/hdl/verilog" +incdir+"../../../../blinky.gen/sources_1/bd/blinky/ipshared/0127/hdl/verilog" +incdir+"/home/drew/embedded/xilinx/Vivado/2024.2/data/xilinx_vip/include" \
  "../../../../blinky.gen/sources_1/bd/blinky/ipshared/f0b6/hdl/sc_util_v1_0_vl_rfs.sv" \
  "../../../../blinky.gen/sources_1/bd/blinky/ipshared/f49a/hdl/sc_mmu_v1_0_vl_rfs.sv" \
  2>&1 | tee -a compile.log; cat .tmp_log >> xmvlog.log 2>/dev/null

  xmvlog -work xil_defaultlib $xmvlog_opts -sv +incdir+"../../../../blinky.gen/sources_1/bd/blinky/ipshared/ec67/hdl" +incdir+"../../../../blinky.gen/sources_1/bd/blinky/ipshared/86fe/hdl" +incdir+"../../../../blinky.gen/sources_1/bd/blinky/ipshared/f0b6/hdl/verilog" +incdir+"../../../../blinky.gen/sources_1/bd/blinky/ipshared/0127/hdl/verilog" +incdir+"/home/drew/embedded/xilinx/Vivado/2024.2/data/xilinx_vip/include" \
  "../../../../blinky.gen/sources_1/bd/blinky/ip/blinky_axi_smc_0/bd_0/ip/ip_2/sim/bd_706f_s00mmu_0.sv" \
  2>&1 | tee -a compile.log; cat .tmp_log >> xmvlog.log 2>/dev/null

  xmvlog -work smartconnect_v1_0 $xmvlog_opts -sv +incdir+"../../../../blinky.gen/sources_1/bd/blinky/ipshared/ec67/hdl" +incdir+"../../../../blinky.gen/sources_1/bd/blinky/ipshared/86fe/hdl" +incdir+"../../../../blinky.gen/sources_1/bd/blinky/ipshared/f0b6/hdl/verilog" +incdir+"../../../../blinky.gen/sources_1/bd/blinky/ipshared/0127/hdl/verilog" +incdir+"/home/drew/embedded/xilinx/Vivado/2024.2/data/xilinx_vip/include" \
  "../../../../blinky.gen/sources_1/bd/blinky/ipshared/2da8/hdl/sc_transaction_regulator_v1_0_vl_rfs.sv" \
  2>&1 | tee -a compile.log; cat .tmp_log >> xmvlog.log 2>/dev/null

  xmvlog -work xil_defaultlib $xmvlog_opts -sv +incdir+"../../../../blinky.gen/sources_1/bd/blinky/ipshared/ec67/hdl" +incdir+"../../../../blinky.gen/sources_1/bd/blinky/ipshared/86fe/hdl" +incdir+"../../../../blinky.gen/sources_1/bd/blinky/ipshared/f0b6/hdl/verilog" +incdir+"../../../../blinky.gen/sources_1/bd/blinky/ipshared/0127/hdl/verilog" +incdir+"/home/drew/embedded/xilinx/Vivado/2024.2/data/xilinx_vip/include" \
  "../../../../blinky.gen/sources_1/bd/blinky/ip/blinky_axi_smc_0/bd_0/ip/ip_3/sim/bd_706f_s00tr_0.sv" \
  2>&1 | tee -a compile.log; cat .tmp_log >> xmvlog.log 2>/dev/null

  xmvlog -work smartconnect_v1_0 $xmvlog_opts -sv +incdir+"../../../../blinky.gen/sources_1/bd/blinky/ipshared/ec67/hdl" +incdir+"../../../../blinky.gen/sources_1/bd/blinky/ipshared/86fe/hdl" +incdir+"../../../../blinky.gen/sources_1/bd/blinky/ipshared/f0b6/hdl/verilog" +incdir+"../../../../blinky.gen/sources_1/bd/blinky/ipshared/0127/hdl/verilog" +incdir+"/home/drew/embedded/xilinx/Vivado/2024.2/data/xilinx_vip/include" \
  "../../../../blinky.gen/sources_1/bd/blinky/ipshared/63ed/hdl/sc_si_converter_v1_0_vl_rfs.sv" \
  2>&1 | tee -a compile.log; cat .tmp_log >> xmvlog.log 2>/dev/null

  xmvlog -work xil_defaultlib $xmvlog_opts -sv +incdir+"../../../../blinky.gen/sources_1/bd/blinky/ipshared/ec67/hdl" +incdir+"../../../../blinky.gen/sources_1/bd/blinky/ipshared/86fe/hdl" +incdir+"../../../../blinky.gen/sources_1/bd/blinky/ipshared/f0b6/hdl/verilog" +incdir+"../../../../blinky.gen/sources_1/bd/blinky/ipshared/0127/hdl/verilog" +incdir+"/home/drew/embedded/xilinx/Vivado/2024.2/data/xilinx_vip/include" \
  "../../../../blinky.gen/sources_1/bd/blinky/ip/blinky_axi_smc_0/bd_0/ip/ip_4/sim/bd_706f_s00sic_0.sv" \
  2>&1 | tee -a compile.log; cat .tmp_log >> xmvlog.log 2>/dev/null

  xmvlog -work smartconnect_v1_0 $xmvlog_opts -sv +incdir+"../../../../blinky.gen/sources_1/bd/blinky/ipshared/ec67/hdl" +incdir+"../../../../blinky.gen/sources_1/bd/blinky/ipshared/86fe/hdl" +incdir+"../../../../blinky.gen/sources_1/bd/blinky/ipshared/f0b6/hdl/verilog" +incdir+"../../../../blinky.gen/sources_1/bd/blinky/ipshared/0127/hdl/verilog" +incdir+"/home/drew/embedded/xilinx/Vivado/2024.2/data/xilinx_vip/include" \
  "../../../../blinky.gen/sources_1/bd/blinky/ipshared/cef3/hdl/sc_axi2sc_v1_0_vl_rfs.sv" \
  2>&1 | tee -a compile.log; cat .tmp_log >> xmvlog.log 2>/dev/null

  xmvlog -work xil_defaultlib $xmvlog_opts -sv +incdir+"../../../../blinky.gen/sources_1/bd/blinky/ipshared/ec67/hdl" +incdir+"../../../../blinky.gen/sources_1/bd/blinky/ipshared/86fe/hdl" +incdir+"../../../../blinky.gen/sources_1/bd/blinky/ipshared/f0b6/hdl/verilog" +incdir+"../../../../blinky.gen/sources_1/bd/blinky/ipshared/0127/hdl/verilog" +incdir+"/home/drew/embedded/xilinx/Vivado/2024.2/data/xilinx_vip/include" \
  "../../../../blinky.gen/sources_1/bd/blinky/ip/blinky_axi_smc_0/bd_0/ip/ip_5/sim/bd_706f_s00a2s_0.sv" \
  2>&1 | tee -a compile.log; cat .tmp_log >> xmvlog.log 2>/dev/null

  xmvlog -work smartconnect_v1_0 $xmvlog_opts -sv +incdir+"../../../../blinky.gen/sources_1/bd/blinky/ipshared/ec67/hdl" +incdir+"../../../../blinky.gen/sources_1/bd/blinky/ipshared/86fe/hdl" +incdir+"../../../../blinky.gen/sources_1/bd/blinky/ipshared/f0b6/hdl/verilog" +incdir+"../../../../blinky.gen/sources_1/bd/blinky/ipshared/0127/hdl/verilog" +incdir+"/home/drew/embedded/xilinx/Vivado/2024.2/data/xilinx_vip/include" \
  "../../../../blinky.gen/sources_1/bd/blinky/ipshared/0127/hdl/sc_node_v1_0_vl_rfs.sv" \
  2>&1 | tee -a compile.log; cat .tmp_log >> xmvlog.log 2>/dev/null

  xmvlog -work xil_defaultlib $xmvlog_opts -sv +incdir+"../../../../blinky.gen/sources_1/bd/blinky/ipshared/ec67/hdl" +incdir+"../../../../blinky.gen/sources_1/bd/blinky/ipshared/86fe/hdl" +incdir+"../../../../blinky.gen/sources_1/bd/blinky/ipshared/f0b6/hdl/verilog" +incdir+"../../../../blinky.gen/sources_1/bd/blinky/ipshared/0127/hdl/verilog" +incdir+"/home/drew/embedded/xilinx/Vivado/2024.2/data/xilinx_vip/include" \
  "../../../../blinky.gen/sources_1/bd/blinky/ip/blinky_axi_smc_0/bd_0/ip/ip_6/sim/bd_706f_sarn_0.sv" \
  "../../../../blinky.gen/sources_1/bd/blinky/ip/blinky_axi_smc_0/bd_0/ip/ip_7/sim/bd_706f_srn_0.sv" \
  "../../../../blinky.gen/sources_1/bd/blinky/ip/blinky_axi_smc_0/bd_0/ip/ip_8/sim/bd_706f_sawn_0.sv" \
  "../../../../blinky.gen/sources_1/bd/blinky/ip/blinky_axi_smc_0/bd_0/ip/ip_9/sim/bd_706f_swn_0.sv" \
  "../../../../blinky.gen/sources_1/bd/blinky/ip/blinky_axi_smc_0/bd_0/ip/ip_10/sim/bd_706f_sbn_0.sv" \
  2>&1 | tee -a compile.log; cat .tmp_log >> xmvlog.log 2>/dev/null

  xmvlog -work smartconnect_v1_0 $xmvlog_opts -sv +incdir+"../../../../blinky.gen/sources_1/bd/blinky/ipshared/ec67/hdl" +incdir+"../../../../blinky.gen/sources_1/bd/blinky/ipshared/86fe/hdl" +incdir+"../../../../blinky.gen/sources_1/bd/blinky/ipshared/f0b6/hdl/verilog" +incdir+"../../../../blinky.gen/sources_1/bd/blinky/ipshared/0127/hdl/verilog" +incdir+"/home/drew/embedded/xilinx/Vivado/2024.2/data/xilinx_vip/include" \
  "../../../../blinky.gen/sources_1/bd/blinky/ipshared/7f4f/hdl/sc_sc2axi_v1_0_vl_rfs.sv" \
  2>&1 | tee -a compile.log; cat .tmp_log >> xmvlog.log 2>/dev/null

  xmvlog -work xil_defaultlib $xmvlog_opts -sv +incdir+"../../../../blinky.gen/sources_1/bd/blinky/ipshared/ec67/hdl" +incdir+"../../../../blinky.gen/sources_1/bd/blinky/ipshared/86fe/hdl" +incdir+"../../../../blinky.gen/sources_1/bd/blinky/ipshared/f0b6/hdl/verilog" +incdir+"../../../../blinky.gen/sources_1/bd/blinky/ipshared/0127/hdl/verilog" +incdir+"/home/drew/embedded/xilinx/Vivado/2024.2/data/xilinx_vip/include" \
  "../../../../blinky.gen/sources_1/bd/blinky/ip/blinky_axi_smc_0/bd_0/ip/ip_11/sim/bd_706f_m00s2a_0.sv" \
  2>&1 | tee -a compile.log; cat .tmp_log >> xmvlog.log 2>/dev/null

  xmvlog -work smartconnect_v1_0 $xmvlog_opts -sv +incdir+"../../../../blinky.gen/sources_1/bd/blinky/ipshared/ec67/hdl" +incdir+"../../../../blinky.gen/sources_1/bd/blinky/ipshared/86fe/hdl" +incdir+"../../../../blinky.gen/sources_1/bd/blinky/ipshared/f0b6/hdl/verilog" +incdir+"../../../../blinky.gen/sources_1/bd/blinky/ipshared/0127/hdl/verilog" +incdir+"/home/drew/embedded/xilinx/Vivado/2024.2/data/xilinx_vip/include" \
  "../../../../blinky.gen/sources_1/bd/blinky/ipshared/37bc/hdl/sc_exit_v1_0_vl_rfs.sv" \
  2>&1 | tee -a compile.log; cat .tmp_log >> xmvlog.log 2>/dev/null

  xmvlog -work xil_defaultlib $xmvlog_opts -sv +incdir+"../../../../blinky.gen/sources_1/bd/blinky/ipshared/ec67/hdl" +incdir+"../../../../blinky.gen/sources_1/bd/blinky/ipshared/86fe/hdl" +incdir+"../../../../blinky.gen/sources_1/bd/blinky/ipshared/f0b6/hdl/verilog" +incdir+"../../../../blinky.gen/sources_1/bd/blinky/ipshared/0127/hdl/verilog" +incdir+"/home/drew/embedded/xilinx/Vivado/2024.2/data/xilinx_vip/include" \
  "../../../../blinky.gen/sources_1/bd/blinky/ip/blinky_axi_smc_0/bd_0/ip/ip_12/sim/bd_706f_m00e_0.sv" \
  2>&1 | tee -a compile.log; cat .tmp_log >> xmvlog.log 2>/dev/null

  xmvlog -work xil_defaultlib $xmvlog_opts +incdir+"../../../../blinky.gen/sources_1/bd/blinky/ipshared/ec67/hdl" +incdir+"../../../../blinky.gen/sources_1/bd/blinky/ipshared/86fe/hdl" +incdir+"../../../../blinky.gen/sources_1/bd/blinky/ipshared/f0b6/hdl/verilog" +incdir+"../../../../blinky.gen/sources_1/bd/blinky/ipshared/0127/hdl/verilog" +incdir+"/home/drew/embedded/xilinx/Vivado/2024.2/data/xilinx_vip/include" \
  "../../../../blinky.gen/sources_1/bd/blinky/ip/blinky_axi_smc_0/bd_0/sim/bd_706f.v" \
  2>&1 | tee -a compile.log; cat .tmp_log >> xmvlog.log 2>/dev/null

  xmvlog -work smartconnect_v1_0 $xmvlog_opts -sv +incdir+"../../../../blinky.gen/sources_1/bd/blinky/ipshared/ec67/hdl" +incdir+"../../../../blinky.gen/sources_1/bd/blinky/ipshared/86fe/hdl" +incdir+"../../../../blinky.gen/sources_1/bd/blinky/ipshared/f0b6/hdl/verilog" +incdir+"../../../../blinky.gen/sources_1/bd/blinky/ipshared/0127/hdl/verilog" +incdir+"/home/drew/embedded/xilinx/Vivado/2024.2/data/xilinx_vip/include" \
  "../../../../blinky.gen/sources_1/bd/blinky/ipshared/3718/hdl/sc_switchboard_v1_0_vl_rfs.sv" \
  2>&1 | tee -a compile.log; cat .tmp_log >> xmvlog.log 2>/dev/null

  xmvlog -work axi_register_slice_v2_1_33 $xmvlog_opts +incdir+"../../../../blinky.gen/sources_1/bd/blinky/ipshared/ec67/hdl" +incdir+"../../../../blinky.gen/sources_1/bd/blinky/ipshared/86fe/hdl" +incdir+"../../../../blinky.gen/sources_1/bd/blinky/ipshared/f0b6/hdl/verilog" +incdir+"../../../../blinky.gen/sources_1/bd/blinky/ipshared/0127/hdl/verilog" +incdir+"/home/drew/embedded/xilinx/Vivado/2024.2/data/xilinx_vip/include" \
  "../../../../blinky.gen/sources_1/bd/blinky/ipshared/3ee4/hdl/axi_register_slice_v2_1_vl_rfs.v" \
  2>&1 | tee -a compile.log; cat .tmp_log >> xmvlog.log 2>/dev/null

  xmvlog -work xil_defaultlib $xmvlog_opts +incdir+"../../../../blinky.gen/sources_1/bd/blinky/ipshared/ec67/hdl" +incdir+"../../../../blinky.gen/sources_1/bd/blinky/ipshared/86fe/hdl" +incdir+"../../../../blinky.gen/sources_1/bd/blinky/ipshared/f0b6/hdl/verilog" +incdir+"../../../../blinky.gen/sources_1/bd/blinky/ipshared/0127/hdl/verilog" +incdir+"/home/drew/embedded/xilinx/Vivado/2024.2/data/xilinx_vip/include" \
  "../../../../blinky.gen/sources_1/bd/blinky/ip/blinky_axi_smc_0/sim/blinky_axi_smc_0.v" \
  2>&1 | tee -a compile.log; cat .tmp_log >> xmvlog.log 2>/dev/null

  xmvhdl -work xil_defaultlib -V93 $xmvhdl_opts \
  "../../../../blinky.gen/sources_1/bd/blinky/ip/blinky_rst_ps7_0_50M_0/sim/blinky_rst_ps7_0_50M_0.vhd" \
  2>&1 | tee -a compile.log; cat .tmp_log >> xmvhdl.log 2>/dev/null

  xmvlog -work xil_defaultlib $xmvlog_opts +incdir+"../../../../blinky.gen/sources_1/bd/blinky/ipshared/ec67/hdl" +incdir+"../../../../blinky.gen/sources_1/bd/blinky/ipshared/86fe/hdl" +incdir+"../../../../blinky.gen/sources_1/bd/blinky/ipshared/f0b6/hdl/verilog" +incdir+"../../../../blinky.gen/sources_1/bd/blinky/ipshared/0127/hdl/verilog" +incdir+"/home/drew/embedded/xilinx/Vivado/2024.2/data/xilinx_vip/include" \
  "../../../../blinky.gen/sources_1/bd/blinky/sim/blinky.v" \
  2>&1 | tee -a compile.log; cat .tmp_log >> xmvlog.log 2>/dev/null

  xmvlog -work xil_defaultlib $xmvlog_opts \
  glbl.v \
  2>&1 | tee -a compile.log; cat .tmp_log >> xmvlog.log 2>/dev/null
}

# RUN_STEP: <elaborate>
elaborate()
{
  xmelab $xmelab_opts $design_libs_elab xil_defaultlib.blinky xil_defaultlib.glbl
}

# RUN_STEP: <simulate>
simulate()
{
  xmsim $xmsim_opts xil_defaultlib.blinky -input simulate.do
}

# STEP: setup
setup()
{
  # delete previous files for a clean rerun
  if [[ ($b_reset_run == 1) ]]; then
    reset_run
    echo -e "INFO: Simulation run files deleted.\n"
    exit 0
  fi

 # delete previous log files
  if [[ ($b_reset_log == 1) ]]; then
    reset_log
    echo -e "INFO: Simulation run log files deleted.\n"
    exit 0
  fi

  # add any setup/initialization commands here:-

  # <user specific commands>

}

# simulator index file/library directory processing
init_lib()
{
  if [[ ($b_keep_index == 1) ]]; then
    # keep previous design library mappings
    true
  else
    # define design library mappings
    create_lib_mappings
  fi

  if [[ ($b_keep_index == 1) ]]; then
    # do not recreate design library directories
    true
  else
    # create design library directories
    create_lib_dir
  fi
}

# define design library mappings
create_lib_mappings()
{
  file="hdl.var"
  touch $file

  file="cds.lib"
  if [[ -e $file ]]; then
    if [[ ($lib_map_path == "") ]]; then
      return
    else
      rm -rf $file
    fi
  fi

  touch $file

  if [[ ($lib_map_path == "") ]]; then
    lib_map_path="/home/drew/Documents/github/jarvis/software/blinky/blinky.cache/compile_simlib/xcelium"
  fi

  if [[ ($lib_map_path != "") ]]; then
    incl_ref="INCLUDE $lib_map_path/cds.lib"
    echo $incl_ref >> $file
  fi

  for (( i=0; i<${#design_libs[*]}; i++ )); do
    lib="${design_libs[i]}"
    mapping="DEFINE $lib $sim_lib_dir/$lib"
    echo $mapping >> $file
  done
}

# create design library directory
create_lib_dir()
{
  if [[ -e $sim_lib_dir ]]; then
    rm -rf $sim_lib_dir
  fi
  for (( i=0; i<${#design_libs[*]}; i++ )); do
    lib="${design_libs[i]}"
    lib_dir="$sim_lib_dir/$lib"
    if [[ ! -e $lib_dir ]]; then
      mkdir -p $lib_dir
    fi
  done
}

# delete generated data from the previous run
reset_run()
{
  files_to_remove=(xmvlog.log xmvhdl.log xmsc.log compile.log elaborate.log simulate.log diag_report.log xsc_report.log blinky_sc.so .tmp_log xcelium_lib waves.shm c.obj)
  for (( i=0; i<${#files_to_remove[*]}; i++ )); do
    file="${files_to_remove[i]}"
    if [[ -e $file ]]; then
      rm -rf $file
    fi
  done
}

# delete generated log files from the previous run
reset_log()
{
  files_to_remove=(xmvlog.log xmvhdl.log xmsc.log compile.log elaborate.log simulate.log diag_report.log xsc_report.log .tmp_log)
  for (( i=0; i<${#files_to_remove[*]}; i++ )); do
    file="${files_to_remove[i]}"
    if [[ -e $file ]]; then
      rm -rf $file
    fi
  done
}

# check switch argument value
check_arg_value()
{
  if [[ ($1 == "-step") && (($2 != "compile") && ($2 != "elaborate") && ($2 != "simulate")) ]];then
    echo -e "ERROR: Invalid or missing step '$2' (type \"./top.sh -help\" for more information)\n"
    exit 1
  fi

  if [[ ($1 == "-lib_map_path") && ($2 == "") ]];then
    echo -e "ERROR: Simulation library directory path not specified (type \"./blinky.sh -help\" for more information)\n"
    exit 1
  fi
}

# check command line arguments
check_args()
{
  arg_count=$#
  if [[ ("$#" == 1) && (("$1" == "-help") || ("$1" == "-h")) ]]; then
    usage
  fi
  while [[ "$#" -gt 0 ]]; do
    case $1 in
      -step)          check_arg_value $1 $2;step=$2;         b_step=1;         shift;;
      -lib_map_path)  check_arg_value $1 $2;lib_map_path=$2; b_lib_map_path=1; shift;;
      -gen_bypass)    b_gen_bypass=1    ;;
      -reset_run)     b_reset_run=1     ;;
      -reset_log)     b_reset_log=1     ;;
      -keep_index)    b_keep_index=1    ;;
      -noclean_files) b_noclean_files=1 ;;
      -help|-h)       ;;
      *) echo -e "ERROR: Invalid option specified '$1' (type "./top.sh -help" for more information)\n"; exit 1 ;;
    esac
     shift
  done

  # -reset_run is not applicable with other switches
  if [[ ("$arg_count" -gt 1) && ($b_reset_run == 1) ]]; then
    echo -e "ERROR: -reset_run switch is not applicable with other switches (type \"./top.sh -help\" for more information)\n"
    exit 1
  fi

  # -reset_log is not applicable with other switches
  if [[ ("$arg_count" -gt 1) && ($b_reset_log == 1) ]]; then
    echo -e "ERROR: -reset_log switch is not applicable with other switches (type \"./top.sh -help\" for more information)\n"
    exit 1
  fi

  # -keep_index is not applicable with other switches
  if [[ ("$arg_count" -gt 1) && ($b_keep_index == 1) ]]; then
    echo -e "ERROR: -keep_index switch is not applicable with other switches (type \"./top.sh -help\" for more information)\n"
    exit 1
  fi

  # -noclean_files is not applicable with other switches
  if [[ ("$arg_count" -gt 1) && ($b_noclean_files == 1) ]]; then
    echo -e "ERROR: -noclean_files switch is not applicable with other switches (type \"./top.sh -help\" for more information)\n"
    exit 1
  fi
}

# script usage
usage()
{
  msg="Usage: blinky.sh [-help]\n\
Usage: blinky.sh [-step]\n\
Usage: blinky.sh [-lib_map_path]\n\
Usage: blinky.sh [-reset_run]\n\
Usage: blinky.sh [-reset_log]\n\
Usage: blinky.sh [-keep_index]\n\
Usage: blinky.sh [-noclean_files]\n\n\
[-help] -- Print help information for this script\n\n\
[-step <name>] -- Execute specified step (simulate)\n\n\
[-lib_map_path <path>] -- Compiled simulation library directory path. The simulation library is compiled\n\
using the compile_simlib tcl command. Please see 'compile_simlib -help' for more information.\n\n\
[-reset_run] -- Delete simulator generated data files from the previous run and recreate simulator setup\n\
file/library mappings for a clean run. This switch will not execute steps defined in the script.\n\n\
NOTE: To keep simulator index file settings from the previous run, use the -keep_index switch\n\
NOTE: To regenerate simulator index file but keep the simulator generated files, use the -noclean_files switch\n\n\
[-reset_log] -- Delete simulator generated log files from the previous run\n\n\
[-keep_index] -- Keep simulator index file settings from the previous run\n\n\
[-noclean_files] -- Reset previous run, but do not remove simulator generated files from the previous run\n"
  echo -e $msg
  exit 0
}

# initialize globals
step=""
lib_map_path=""
b_step=0
b_lib_map_path=0
b_gen_bypass=0
b_reset_run=0
b_reset_log=0
b_keep_index=0
b_noclean_files=0

# launch script
run $*
