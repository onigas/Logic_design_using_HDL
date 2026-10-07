# Run in Vivado 2022.2: vivado -mode batch -source create_project.tcl
set lab_dir [file normalize [file dirname [info script]]]
set project_dir [file join $lab_dir vivado_project]
create_project l4_1_hdl_rom $project_dir -part xc7a100tcsg324-1 -force
set_property target_language Verilog [current_project]

add_files -fileset sources_1 [list \
    [file join $lab_dir rtl rom8x8.v] \
    [file join $lab_dir rtl rom8x8_board_top.v]]
add_files -fileset constrs_1 [file join $lab_dir constraints rom8x8_board.xdc]
add_files -fileset sim_1 [file join $lab_dir sim tb_rom8x8.sv]
set_property top rom8x8_board_top [get_filesets sources_1]
set_property top tb_rom8x8 [get_filesets sim_1]
update_compile_order -fileset sources_1
update_compile_order -fileset sim_1
puts "Created L4.1 project at $project_dir"
