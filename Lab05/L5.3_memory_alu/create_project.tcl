# Run in Vivado 2022.2: source {/absolute/path/to/create_project.tcl}
set lab_dir [file normalize [file dirname [info script]]]
set project_dir [file join $lab_dir vivado_project]
create_project l5_3_memory_alu $project_dir -part xc7a100tcsg324-1 -force
set_property target_language Verilog [current_project]
add_files -fileset sources_1 [list [file join $lab_dir rtl alu_modules.v] [file join $lab_dir rtl rom16x4.v] [file join $lab_dir rtl hex7seg8.v] [file join $lab_dir rtl memory_alu_top.v]]
add_files -fileset constrs_1 [file join $lab_dir constraints memory_alu.xdc]
add_files -fileset sim_1 [list [file join $lab_dir sim tb_memory_alu.sv] [file join $lab_dir sim tb_hex7seg8.sv]]
set_property top memory_alu_top [get_filesets sources_1]
set_property top tb_memory_alu [get_filesets sim_1]
update_compile_order -fileset sources_1
update_compile_order -fileset sim_1
puts "Created l5_3_memory_alu under $project_dir"
