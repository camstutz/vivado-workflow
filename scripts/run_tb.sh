################################################################################
# Author : Christian Amstutz
# Date   : 2017-04-26
#
# Shell script that managages the simulation of testbenches.
################################################################################

TB_DIR="$1"
TB_NAME="${TB_DIR##*/}"
TOP_DESIGN=$2
SIM_SCRIPT=${TB_DIR}/full_sim.tcl
OUTPUT_DIR="output"
WAV_OUTPUT_DIR=${OUTPUT_DIR}/wavedb

xelab -prj $TB_DIR/tb.prj -s ${TB_NAME}_sim xil_defaultlib.$TOP_DESIGN -debug typical

mkdir ${WAV_OUTPUT_DIR} -p
xsim ${TB_NAME}_sim -wdb ${WAV_OUTPUT_DIR}/${TB_NAME}.wdb -tclbatch $SIM_SCRIPT --gui
