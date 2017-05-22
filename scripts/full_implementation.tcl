################################################################################
# Author : Christian Amstutz
# Date   : 2017-05-18
#
# This scripts runs a full implementation of a Vivado project.
################################################################################

# Save current path
set current_dir [pwd]

# Read project settings from file
set script_dir [file dirname [info script]]
source [file join $script_dir project_settings.tcl]

set_property part $fpga_part [current_project]
#set_property BOARD_PART $board_part [current_project]
set_property DEFAULT_LIB $default_library [current_project]
set_property TARGET_LANGUAGE VHDL [current_project]
set_property SIMULATOR_LANGUAGE Mixed [current_project]

# Block diagrams have been tested but not fully integrated to the workflow
# Generate Block Designs (BD)
foreach bd $block_designs {
  set bd_path [file dirname $bd]
  set bd_name [file rootname [file tail $bd]]
  # remove trailing '_bd'
  regsub {_bd$} $bd_name {} bd_name

  cd $bd_path
  source [file tail $bd]
  cd $current_dir
  set bd_config_file "$bd_path/.srcs/sources_1/bd/$bd_name/$bd_name.bd"
  generate_target all [get_files $bd_config_file]
}

# Create list of non block design IPs
list non_bd_ips
foreach ip [get_ips] {
  set ip_filename [get_property IP_FILE $ip]
  if ![string match "*$bd_dir*" "$ip_filename"] {
    lappend non_bd_ips $ip
  }
}

# Enable Out-Of-Context syntehsis for IPs
foreach ip $non_bd_ips {
  set ip_filename [get_property IP_FILE $ip]
  set_property generate_synth_checkpoint true [get_files $ip_filename]
}

generate_target all [get_ips $non_bd_ips]

## Disable the use of IP constraints
#foreach ip $non_bd_ips {
#  set ip_filename [get_property IP_FILE $ip]
#  set ip_xdc [get_files -of_objects [get_files $ip_filename] -filter {FILE_TYPE == XDC}]
#  set_property is_enabled false $ip_xdc
#}

synth_ip [get_ips $non_bd_ips]

# define and create project output directories
set outputDir ./output
set checkpointDir $outputDir/checkpoints
file mkdir $checkpointDir
set reportDir $outputDir/reports
file mkdir $reportDir
set netlistDir $outputDir/netlists
file mkdir $netlistDir
set constraintOutDir $outputDir/constraints
file mkdir $constraintOutDir

# Synthesize design
synth_design -top $top_design -part $fpga_part
write_checkpoint -force $checkpointDir/post_synth
report_timing_summary -file $reportDir/post_synth_timing_summary.rpt
report_power -file $reportDir/post_synth_power.rpt

# Optimize and place the design
opt_design
place_design
phys_opt_design
write_checkpoint -force $checkpointDir/post_place
report_timing_summary -file $reportDir/post_place_timing_summary.rpt

# Route the design
route_design
write_checkpoint -force $checkpointDir/post_route
report_timing_summary -file $reportDir/post_route_timing_summary.rpt
report_timing -sort_by group -max_paths 100 -path_type summary -file $reportDir/post_route_timing.rpt
report_clock_utilization -file $reportDir/clock_util.rpt
report_utilization -file $reportDir/post_route_util.rpt
report_power -file $reportDir/post_route_power.rpt
report_drc -file $reportDir/post_imp_drc.rpt
write_verilog -force $netlistDir/${top_design}_impl_netlist.v
write_xdc -no_fixed_only -force $constraintOutDir/${top_design}_impl.xdc

# Generate bit stream
write_bitstream -force $proj_name.bit
