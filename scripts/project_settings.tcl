################################################################################
# Author : Christian Amstutz
# Date   : 2017-05-02
#
# Contains the general project settings, which are included by other scripts.
################################################################################

set fpga_part "xcku040-ffva1156-1-c"

set proj_name "workflow_test"
set top_design "top_workflow"

# Paths ########################################################################

set rtl_dir "src/rtl"
set ip_dir "src/ip"
set bd_dir "src/bd"
set constr_dir "src/constraints"

# Read RTL sources #############################################################
read_vhdl "$rtl_dir/top_workflow.vhdl"
read_vhdl "$rtl_dir/or_gate.vhdl"

# Read IPs #####################################################################
read_ip "$ip_dir/multiplier/multiplier.xci"

# Read Block Designs ###########################################################

# Read constraints #############################################################
read_xdc "$constr_dir/workflow_test.xdc"
