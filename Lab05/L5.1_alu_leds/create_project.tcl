# Run in Vivado 2022.2: source {/absolute/path/to/create_project.tcl}
set lab_dir [file normalize [file dirname [info script]]]
set project_dir [file join $lab_dir vivado_project]
create_project l5_1_alu_leds $project_dir -part xc7a100tcsg324-1 -force
set_property target_language Verilog [current_project]
add_files -fileset sources_1 [list [file join $lab_dir rtl alu_modules.v] [file join $lab_dir rtl alu_top.v] [file join $lab_dir rtl alu_board_top.v]]
add_files -fileset constrs_1 [file join $lab_dir constraints alu_board.xdc]
add_files -fileset sim_1 [list [file join $lab_dir sim tb_alu_top.sv]]
set_property top alu_board_top [get_filesets sources_1]
set_property top tb_alu_top [get_filesets sim_1]
update_compile_order -fileset sources_1
update_compile_order -fileset sim_1
puts "Created l5_1_alu_leds under $project_dir"
