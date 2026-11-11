# Run with Vivado 2022.2. Supply an optional new project directory.
set root [file dirname [file normalize [info script]]]
set dest [file join $root build]
if {$argc > 0} {set dest [file normalize [lindex $argv 0]]}
create_project lab10 $dest -part xc7a100tcsg324-1
add_files [glob [file join $root rtl *.v]]
add_files -fileset constrs_1 [list [file join $root constraints nexys4_ddr.xdc]]
add_files -fileset sim_1 [list [file join $root sim tb_lab10.v]]
set_property top lab10_top [get_filesets sources_1]
set_property top tb_lab10 [get_filesets sim_1]
set_property xsim.simulate.runtime all [get_filesets sim_1]
update_compile_order -fileset sources_1
update_compile_order -fileset sim_1
