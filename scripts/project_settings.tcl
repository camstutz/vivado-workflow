################################################################################
# Author : Christian Amstutz
# Date   : 2017-05-18
#
# Contains the general project settings, which are included by other scripts.
################################################################################

set fpga_part "xcku040-ffva1156-1-c"
#set board_part "xilinx.com:kcu105:part0:1.1"

set proj_name "workflow_test"
set top_design "top_workflow"
set default_library "work"

# Paths ########################################################################
set rtl_dir "src/rtl"
set ip_dir "src/ip"
set bd_dir "src/bd"
set constr_dir "src/constraints"
set user_ip_repo "ip_repo"

# Read RTL sources #############################################################
read_vhdl "$rtl_dir/top_workflow.vhdl"
read_vhdl "$rtl_dir/or_gate.vhdl"

# Read IPs #####################################################################
read_ip "$ip_dir/multiplier/multiplier.xci"

# Read Block Designs ###########################################################
list block_designs
lappend block_designs src/bd/multiply_bd/multiply_bd_bd.tcl

# Read constraints #############################################################
read_xdc "$constr_dir/workflow_test.xdc"
