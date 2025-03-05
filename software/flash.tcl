connect
connect -url tcp:127.0.0.1:3121
bpremove -all
targets -set -filter {jtag_cable_name =~ "Digilent Zybo 210279652026A" && level==0 && jtag_device_ctx=="jsn-Zybo-210279652026A-13722093-0"}
fpga -file /home/richard/code/jarvis/software/blinky_4/xgpio_example/_ide/bitstream/blinky_wrapper_7.bit
after 3000
targets -set -nocase -filter {name =~"APU*"}
loadhw -hw /home/richard/code/jarvis/software/blinky_4/platform/export/platform/hw/blinky_wrapper_7.xsa -mem-ranges {0x40000000 0xbfffffff}
configparams force-mem-access 1
targets -set -nocase -filter {name =~"APU*"}
source /home/richard/code/jarvis/software/blinky_4/xgpio_example/_ide/psinit/ps7_init.tcl
ps7_init
ps7_post_config
targets -set -nocase -filter {name =~ "*A9*#0"}
rst -processor
dow /home/richard/code/jarvis/software/blinky_4/xgpio_example/build/xgpio_example.elf
con
configparams force-mem-access 0
exit
