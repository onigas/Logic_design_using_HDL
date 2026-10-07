# Run in Vivado 2022.2: vivado -mode batch -source create_project.tcl
set lab_dir [file normalize [file dirname [info script]]]
set project_dir [file join $lab_dir vivado_project]
set coe [file normalize [file join $lab_dir data dist_rom16.coe]]

create_project l4_2_distributed_rom $project_dir -part xc7a100tcsg324-1 -force
set_property target_language Verilog [current_project]
add_files -fileset sources_1 [file join $lab_dir rtl dist_rom_board_top.v]
add_files -fileset constrs_1 [file join $lab_dir constraints dist_rom_board.xdc]
add_files -fileset sim_1 [file join $lab_dir sim tb_dist_rom16.sv]

create_ip -name dist_mem_gen -vendor xilinx.com -library ip -module_name dist_rom16
set_property -dict [list \
    CONFIG.depth {16} \
    CONFIG.data_width {8} \
    CONFIG.memory_type {rom} \
    CONFIG.input_options {Non Registered} \
    CONFIG.output_options {Non Registered} \
    CONFIG.coefficient_file $coe] [get_ips dist_rom16]
generate_target all [get_ips dist_rom16]

set_property top dist_rom_board_top [get_filesets sources_1]
set_property top tb_dist_rom16 [get_filesets sim_1]
update_compile_order -fileset sources_1
update_compile_order -fileset sim_1
puts "Created L4.2 project with dist_rom16 IP at $project_dir"
