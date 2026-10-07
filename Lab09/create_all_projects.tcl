# Generate all four independent Lab09 projects in Vivado 2022.2.
set all_labs_dir [file dirname [file normalize [info script]]]
if {[llength [get_projects -quiet]] > 0} {
    error "Close the current Vivado project before running this script."
}
foreach exercise {L9.1_PWM_LED L9.2_DC_Motor L9.3_Knight_Rider L9.4_PWM_Audio} {
    source [file join $all_labs_dir $exercise create_project.tcl]
    close_project
}
puts "All Lab09 projects are ready. Open an exercise's build folder and its .xpr."
