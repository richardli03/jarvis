source args.tcl

connect
connect -url tcp:127.0.0.1:3121
bpremove -all
targets -set -filter {jtag_cable_name =~ "Digilent Zybo 210279652026A" && level==0 && jtag_device_ctx=="jsn-Zybo-210279652026A-13722093-0"}
fpga -file $bit_file
after 3000
targets -set -nocase -filter {name =~"APU*"}
loadhw -hw $xsa_file -mem-ranges {0x40000000 0xbfffffff}
configparams force-mem-access 1
targets -set -nocase -filter {name =~"APU*"}
source $ps7_init_file
ps7_init
ps7_post_config
targets -set -nocase -filter {name =~ "*A9*#0"}
rst -processor
dow $elf_file
con
configparams force-mem-access 0
exit
