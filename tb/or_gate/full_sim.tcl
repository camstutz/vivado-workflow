#!/usr/bin/tclsh
# author : Christian Amstutz

# This file contains code that is executed within the simulation environment.

#open_wave_config simulate_xsim.wcfg
add_wave {{/testbench/a_in}} {{/testbench/b_in}} {{/testbench/q_out}}
run all
