# Tools
VIVADO=vivado -mode batch -source
VENV_NAME=jarvis_venv
PYTHON=../${VENV_NAME}/bin/python
SURFER=surfer

# Available bitstreams; used for .PHONY
BITSTREAMS=flip_flop.bit
PROGRAM_TARGETS=$(BITSTREAMS:%.bit=%.program)
TARGET_DIRECTORY=NULL

CMOD_A7_PART_NO=xc7a35tcpg236-1
ZYBO_PART_NO=xc7z010clg400-1

#TODO: Make settable through the cli 
# FPGA_PART_NO=${CMOD_A7_PART_NO}
FPGA_PART_NO=${ZYBO_PART_NO}

# Avoid conflicts with files of the same name
.PHONY: test_all clean *.program #$(PROGRAM_TARGETS)

# Test all modules with cocotb
test_all:
	${PYTHON} -m pytest -v -o log_cli=True verif/py/

# Clean temporary files
clean:
	rm -rf sim_build

# Include module makefiles
include hdl/components.mk
include hdl/interfaces.mk

# Applies to the rest of the file, used to expand generate/program bitstream to
# any target
.SECONDEXPANSION:

# Test a module
%.test:
	${PYTHON} -m pytest -v -o log_cli=True verif/py/interfaces/test_$*.py

# Test and display waveforms for a module #TODO: Add config directory for waveforms
%.waves:
	${PYTHON} -m pytest -v -o log_cli=True verif/py/interfaces/test_$*.py
	${SURFER} ../sim_build/$*/$*.fst -s waves/interfaces/$*.ron &

# Generate a bitstream
%.bit: ../scripts/synthesis_place_route.tcl $${%_TOP} $${_XDC} $${%_SRCS} $${%_DEPS}
	@echo "________________________________________________"
	@echo "Building $*"
	@echo "TOP: ${$*_TOP}"
	@echo "XDC: ${$*_XDC}"
	@echo "SRCS: ${$*_SRCS}"
	@echo "DEPS: ${$*_DEPS}"
	@echo "________________________________________________"
	SYNTH_HDL_SRCS="${$*_SRCS}" FPGA_PART_NO=${FPGA_PART_NO} XDC_FILE="${$*_XDC}" SYNTH_TOP_MODULE="$*" ${VIVADO} ../scripts/synthesis_place_route.tcl || true
	mv vivado.log log/vivado_$*.log || true
	mv vivado.jou log/vivado_$*.jou || true
	mv clockInfo.txt log/clock_info_$*.txt || true

# Program a bitstream
%.program:
	djtgcfg enum
	djtgcfg prog -d Zybo -i 1 -f bit/$*_${FPGA_PART_NO}.bit

# Export hardware
%.xsa: ../scripts/synthesis_place_route.tcl ../scripts/export_hardware.tcl $${%_TOP} $${_XDC} $${%_SRCS} $${%_DEPS}
	@echo "________________________________________________"
	@echo "Building $*"
	@echo "TOP: ${$*_TOP}"
	@echo "XDC: ${$*_XDC}"
	@echo "SRCS: ${$*_SRCS}"
	@echo "DEPS: ${$*_DEPS}"
	@echo "________________________________________________"
	SYNTH_HDL_SRCS="${$*_SRCS}" FPGA_PART_NO=${FPGA_PART_NO} XDC_FILE="${$*_XDC}" SYNTH_TOP_MODULE="$*" ${VIVADO} ../scripts/synthesis_place_route.tcl ../scripts/export_hardware.tcl || true
	mv vivado.log log/vivado_$*.log || true
	mv vivado.jou log/vivado_$*.jou || true
	mv clockInfo.txt log/clock_info_$*.txt || true
