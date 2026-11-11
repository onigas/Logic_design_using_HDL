# vivado -mode batch -source create_project.tcl -tclargs student|reference
set root [file dirname [file normalize [info script]]]
set variant student
if {$argc>0} {set variant [lindex $argv 0]}
if {$variant ni {student reference}} {error "Select student or reference"}
set dest [file join $root build_$variant]
if {$argc>1} {set dest [file normalize [lindex $argv 1]]}
create_project lab11 $dest -part xc7a100tcsg324-1
add_files [glob [file join $root rtl *.v]]
add_files [list [file join $root $variant temperature_sequence.v]]
add_files -fileset constrs_1 [list [file join $root constraints nexys4_ddr.xdc]]
add_files -fileset sim_1 [list [file join $root sim tb_lab11.v]]
set_property top lab11_top [get_filesets sources_1]
set_property top tb_lab11 [get_filesets sim_1]
set_property xsim.simulate.runtime all [get_filesets sim_1]
update_compile_order -fileset sources_1
update_compile_order -fileset sim_1
