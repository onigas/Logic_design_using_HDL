set build_lab_dir [file dirname [file normalize [info script]]]
source [file join $build_lab_dir create_project.tcl]
reset_run synth_1
launch_runs synth_1 -jobs 4
wait_on_run synth_1
if {[get_property PROGRESS [get_runs synth_1]] ne "100%"} {
    error "Synthesis failed: [get_property STATUS [get_runs synth_1]]"
}
launch_runs impl_1 -to_step write_bitstream -jobs 4
wait_on_run impl_1
if {[get_property PROGRESS [get_runs impl_1]] ne "100%"} {
    error "Implementation failed: [get_property STATUS [get_runs impl_1]]"
}
set bitstream_file [file join [get_property DIRECTORY [get_runs impl_1]] PWMAudio.bit]
if {![file isfile $bitstream_file]} { error "Bitstream was not generated: $bitstream_file" }
puts "Bitstream generated: $bitstream_file"
