#!/bin/bash
cd "$(dirname "${BASH_SOURCE[0]}")" || exit

venv_name="jarvis_venv"

# Setup and install python venv if it does not exist
if [ ! -d ../${venv_name} ]; then
    pyenv install 3.11
    pyenv local 3.11
    python3 -m venv ${venv_name}
    poetry install
fi

source ./${venv_name}/bin/activate
export PYTHONPYCACHEPREFIX=/tmp/pycache
export PYTHONPATH="$(pwd)"

# Enable open source tools.
source ${HOME}/embedded/oss-cad-suite/environment

# # Enable Xilinx.
# export XILINX_INSTALL_PATH="${HOME}/embedded/_xilinx/"
# VERSION="2016.4"
# export VIVADO_PATH=${XILINX_INSTALL_PATH}/Vivado/${VERSION}/
# # Calls the Xilinx setup scripts so that you can run the tools.
# # source ${VIVADO_PATH}/settings64.sh
# export PATH="${VIVADO_PATH}/bin:$PATH"
# # Setup variables for synthesis. You may need to change this based on your FPGA board.
# # export FPGA_PART=xc7a35tcpg236-1
# # export PS1="☕ $PS1"
