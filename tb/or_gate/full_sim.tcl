################################################################################
# Author : Christian Amstutz
# Date   : 2017-04-26
#
# Testbench specific script that controls the simulation within Xilinx xsim.
################################################################################

#open_wave_config simulate_xsim.wcfg
add_wave {{/testbench/a_in}} {{/testbench/b_in}} {{/testbench/q_out}}
run all
