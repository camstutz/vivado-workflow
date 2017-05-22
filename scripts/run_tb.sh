################################################################################
# Author : Christian Amstutz
# Date   : 2017-05-18
#
# Shell script that managages the simulation of testbenches.
################################################################################

TB_DIR="$1"
TB_NAME="${TB_DIR##*/}"
TOP_DESIGN=$2
SIM_SCRIPT=${TB_DIR}/full_sim.tcl
OUTPUT_DIR="output"
WAV_OUTPUT_DIR=${OUTPUT_DIR}/wavedb

# Command line options
xvlog_opts="-m64 --relax -initfile ${TB_DIR}/xsim.ini"
xvhdl_opts="-m64 --relax -initfile ${TB_DIR}/xsim.ini"

xvlog $xvlog_opts -prj ${TB_DIR}/tb_verilog.prj
xvhdl $xvlog_opts -prj ${TB_DIR}/tb_vhdl.prj

xelab xil_defaultlib.$TOP_DESIGN -s ${TB_NAME}_sim -debug typical --relax -initfile ${TB_DIR}/xsim.ini

mkdir ${WAV_OUTPUT_DIR} -p
xsim ${TB_NAME}_sim -wdb ${WAV_OUTPUT_DIR}/${TB_NAME}.wdb -tclbatch $SIM_SCRIPT --gui
