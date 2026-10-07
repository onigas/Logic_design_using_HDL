# Run the complete L9.1 behavioral simulation in Vivado 2022.2/XSim.
set sim_lab_dir [file dirname [file normalize [info script]]]
source [file join $sim_lab_dir create_project.tcl]
set_property xsim.simulate.runtime {0ns} [get_filesets sim_1]
launch_simulation -simset sim_1 -mode behavioral
run all
