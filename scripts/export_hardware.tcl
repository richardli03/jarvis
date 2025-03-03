# Hardware export script (.xsa)

# Ensure environment variables are set
if {![info exists ::env(SYNTH_HDL_SRCS)]} {
  puts "Missing environment variable SYNTH_HDL_SRCS, quitting.";
  exit 1;
}

if {![info exists ::env(FPGA_PART_NO)]} {
  puts "Missing env FPGA_PART_NO, quitting.";
  exit 1;
}

if {![info exists ::env(XDC_FILE)]} {
  puts "Missing env XDC_FILE, quitting.";
  exit 1;
}

if {![info exists ::env(SYNTH_TOP_MODULE)]} {
  puts "Missing env SYNTH_TOP_MODULE, quitting.";
  exit 1;
}

# Create directories
file mkdir xsa/

write_hw_platform -fixed -force -include_bit -file ./xsa/$::env(SYNTH_TOP_MODULE)_$::env(FPGA_PART_NO).xsa
