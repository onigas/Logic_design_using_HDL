# Run in Vivado 2022.2: vivado -mode batch -source create_project.tcl
set lab_dir [file normalize [file dirname [info script]]]
set project_dir [file join $lab_dir vivado_project]
set coe [file normalize [file join $lab_dir data block_rom8x16.coe]]

create_project l4_3_block_rom $project_dir -part xc7a100tcsg324-1 -force
set_property target_language Verilog [current_project]
add_files -fileset sources_1 [list \
    [file join $lab_dir rtl block_rom_board_top.v] \
    [file join $lab_dir rtl sevenseg_hex.v]]
add_files -fileset constrs_1 [file join $lab_dir constraints block_rom_board.xdc]
add_files -fileset sim_1 [list \
    [file join $lab_dir sim tb_block_rom8x16.sv] \
    [file join $lab_dir sim tb_sevenseg_hex.sv]]

create_ip -name blk_mem_gen -vendor xilinx.com -library ip -module_name block_rom8x16
set_property CONFIG.Memory_Type {Single_Port_ROM} [get_ips block_rom8x16]
set_property -dict [list \
    CONFIG.Interface_Type {Native} \
    CONFIG.Write_Width_A {16} \
    CONFIG.Read_Width_A {16} \
    CONFIG.Write_Depth_A {8} \
    CONFIG.Enable_A {Always_Enabled} \
    CONFIG.Register_PortA_Output_of_Memory_Primitives {false} \
    CONFIG.Register_PortA_Output_of_Memory_Core {false} \
    CONFIG.Load_Init_File {true} \
    CONFIG.Coe_File $coe] [get_ips block_rom8x16]
generate_target all [get_ips block_rom8x16]

set_property top block_rom_board_top [get_filesets sources_1]
set_property top tb_block_rom8x16 [get_filesets sim_1]
update_compile_order -fileset sources_1
update_compile_order -fileset sim_1
puts "Created L4.3 project with block_rom8x16 IP at $project_dir"
