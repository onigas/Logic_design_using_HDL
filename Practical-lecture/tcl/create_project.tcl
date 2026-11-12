set ROOT [file normalize [file join [file dirname [info script]] ..]]
create_project switch_led [file join $ROOT vivado] -part xc7a100tcsg324-1 -force
set_property target_language Verilog [current_project]
add_files -norecurse [list [file join $ROOT rtl kcpsm6.v] [file join $ROOT rtl switch_led_top.v] [file join $ROOT firmware switch_led.v]]
add_files -fileset constrs_1 -norecurse [list [file join $ROOT constraints nexys4_ddr.xdc]]
add_files -fileset sim_1 -norecurse [list [file join $ROOT sim tb_switch_led.sv]]
set_property top switch_led_top [get_filesets sources_1]
set_property top tb_switch_led [get_filesets sim_1]
set_property xsim.simulate.runtime {0ns} [get_filesets sim_1]
update_compile_order -fileset sources_1
puts "Project ready: $ROOT/vivado/switch_led.xpr"

