source [file join [file dirname [info script]] create_project.tcl]
launch_simulation
run all
close_sim
launch_runs synth_1 -jobs 4
wait_on_run synth_1
if {[get_property PROGRESS [get_runs synth_1]] ne "100%"} { error "Synthesis failed" }
launch_runs impl_1 -to_step write_bitstream -jobs 4
wait_on_run impl_1
if {[get_property PROGRESS [get_runs impl_1]] ne "100%"} { error "Implementation failed" }
open_run impl_1
file mkdir [file join $ROOT output]
report_timing_summary -file [file join $ROOT output timing_summary.rpt]
report_utilization -file [file join $ROOT output utilization.rpt]
report_drc -file [file join $ROOT output drc.rpt]
file copy -force [file join $ROOT vivado switch_led.runs impl_1 switch_led_top.bit] [file join $ROOT output switch_led_top.bit]
puts "BUILD COMPLETE"
