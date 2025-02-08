
cmake_minimum_required(VERSION 3.15)
project(bsp)
        
set(DRIVER_TARGETS coresightps_dcc;devcfg;dmaps;scugic;scutimer;scuwdt;xadcps)
set(DRIVER_LOCATIONS /home/richard/embedded/Vitis/2024.2/data/embeddedsw/XilinxProcessorIPLib/drivers/coresightps_dcc_v1_11;/home/richard/embedded/Vitis/2024.2/data/embeddedsw/XilinxProcessorIPLib/drivers/devcfg_v3_8;/home/richard/embedded/Vitis/2024.2/data/embeddedsw/XilinxProcessorIPLib/drivers/dmaps_v2_11;/home/richard/embedded/Vitis/2024.2/data/embeddedsw/XilinxProcessorIPLib/drivers/scugic_v5_4;/home/richard/embedded/Vitis/2024.2/data/embeddedsw/XilinxProcessorIPLib/drivers/scutimer_v2_6;/home/richard/embedded/Vitis/2024.2/data/embeddedsw/XilinxProcessorIPLib/drivers/scuwdt_v2_6;/home/richard/embedded/Vitis/2024.2/data/embeddedsw/XilinxProcessorIPLib/drivers/xadcps_v2_7)

list(LENGTH DRIVER_TARGETS no_of_drivers)
set(index 0)

while(${index} LESS ${no_of_drivers})
    list(GET DRIVER_TARGETS ${index} drv)
    list(GET DRIVER_LOCATIONS ${index} drv_dir)
    set(exp_dir "${drv_dir}/examples")
    add_custom_target(
        ${drv}_example ALL
        COMMAND lopper -f -O /home/richard/code/jarvis/software/jarvis-software/platform/ps7_cortexa9_0/standalone_ps7_cortexa9_0/bsp/libsrc/${drv} /home/richard/code/jarvis/software/jarvis-software/platform/ps7_cortexa9_0/standalone_ps7_cortexa9_0/bsp/hw_artifacts/ps7_cortexa9_0_baremetal.dts -- bmcmake_metadata_xlnx ps7_cortexa9_0 ${exp_dir} drvcmake_metadata
        BYPRODUCTS x${drv}_exlist.yaml)
    MATH(EXPR index "${index}+1")
endwhile()
