# Generate all three independent projects in Vivado 2022.2.
# Each project is closed after creation; open its .xpr afterward.
set all_labs_dir [file dirname [file normalize [info script]]]
if {[llength [get_projects -quiet]] > 0} {
    error "Close the current Vivado project before running this script."
}
foreach exercise {L8.1_TX L8.2_RX L8.3_Echo} {
    source [file join $all_labs_dir $exercise create_project.tcl]
    close_project
}
puts "All three projects are ready. Open an exercise's build folder and its .xpr."
