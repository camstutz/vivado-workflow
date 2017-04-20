#!/usr/bin/tclsh
# author : Christian Amstutz


# evaluate current directory
set currentDir [file dirname [info script]]

# Read project settings
if { [catch {source [file join $currentDir project_settings.tcl]} errmsg] } {
    puts "Error in Vivado automation script : ${errmsg}"
    exit
}

# define output directory
set outputDir ./vivado
file mkdir $outputDir

# Read source files
read_vhdl "rtl/or_gate.vhdl"

# Read constraints
read_xdc "constraints/workflow_test.xdc"

# Synthesize design
synth_design -top $top_design -part $thepart
write_checkpoint -force $outputDir/post_synth
report_timing_summary -file $outputDir/post_synth_timing_summary.rpt
report_power -file $outputDir/post_synth_power.rpt

# Optimize and place the design
opt_design
place_design
phys_opt_design
write_checkpoint -force $outputDir/post_place
report_timing_summary -file $outputDir/post_place_timing_summary.rpt

# Route the design
route_design
write_checkpoint -force $outputDir/post_route
report_timing_summary -file $outputDir/post_route_timing_summary.rpt
report_timing -sort_by group -max_paths 100 -path_type summary -file $outputDir/post_route_timing.rpt
report_clock_utilization -file $outputDir/clock_util.rpt
report_utilization -file $outputDir/post_route_util.rpt
report_power -file $outputDir/post_route_power.rpt
report_drc -file $outputDir/post_imp_drc.rpt
write_verilog -force $outputDir/${top_design}_impl_netlist.v
write_xdc -no_fixed_only -force $outputDir/${top_design}_impl.xdc

# Generate bit stream
write_bitstream -force $proj_name.bit
