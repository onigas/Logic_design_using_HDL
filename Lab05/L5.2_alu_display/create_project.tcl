# Run in Vivado 2022.2: source {/absolute/path/to/create_project.tcl}
set lab_dir [file normalize [file dirname [info script]]]
set project_dir [file join $lab_dir vivado_project]
create_project l5_2_alu_display $project_dir -part xc7a100tcsg324-1 -force
set_property target_language Verilog [current_project]
add_files -fileset sources_1 [list [file join $lab_dir rtl alu_modules.v] [file join $lab_dir rtl alu_top.v] [file join $lab_dir rtl hex7seg8.v] [file join $lab_dir rtl alu4_top.v]]
add_files -fileset constrs_1 [file join $lab_dir constraints alu_display.xdc]
add_files -fileset sim_1 [list [file join $lab_dir sim tb_alu_top.sv] [file join $lab_dir sim tb_alu4_top.sv] [file join $lab_dir sim tb_hex7seg8.sv]]
set_property top alu4_top [get_filesets sources_1]
set_property top tb_alu4_top [get_filesets sim_1]
update_compile_order -fileset sources_1
update_compile_order -fileset sim_1
puts "Created l5_2_alu_display under $project_dir"
