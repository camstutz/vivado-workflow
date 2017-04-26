################################################################################
# Author : Christian Amstutz
# Date   : 2017-04-26
#
# This scripts runs a full implementation of a Vivado project.
################################################################################

# evaluate current directory
set currentDir [file dirname [info script]]

# Read project settings from file
if { [catch {source [file join $currentDir project_settings.tcl]} errmsg] } {
    puts "Error in Vivado automation script : ${errmsg}"
    exit
}

# Read source files
read_vhdl "rtl/top_workflow.vhdl"
read_vhdl "rtl/or_gate.vhdl"

# Read IPs
set_property part $fpga_part [current_project]
read_ip "ip/multiplier/multiplier.xci"

set_property generate_synth_checkpoint false [get_files ip/multiplier/multiplier.xci];
generate_target all [get_ips multiplier]

# disable the use of IP constraints
#set multiplier_xdc [get_files -of_objects [get_files ip/multiplier/multiplier.xci] -filter {FILE_TYPE == XDC}]
#set_property is_enabled false [get_files $multiplier_xdc]

# define and create output directories
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

# Read constraints
read_xdc "constraints/workflow_test.xdc"

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
