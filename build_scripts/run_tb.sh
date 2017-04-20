#!/usr/bin/bash

TB_NAME=$1
TB_FOLDER="$TB_NAME"
TOP_DESIGN=$2
SIM_SCRIPT=full_sim.tcl

cd tb/$TB_FOLDER

xelab -prj tb.prj -s ${TB_NAME}_sim xil_defaultlib.$TOP_DESIGN -debug typical
xsim ${TB_NAME}_sim -wdb simulate_xsim.wdb --gui -tclbatch $SIM_SCRIPT

cd ../..
