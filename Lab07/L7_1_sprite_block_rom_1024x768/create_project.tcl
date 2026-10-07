# LDHDL Laboratory 7.1 - VGA sprite from Block ROM, 1024x768 @ 60 Hz
set script_dir [file normalize [file dirname [info script]]]
set project_name "L7_1_sprite_block_rom_1024x768"
set project_dir [file normalize [file join $script_dir "vivado_project"]]
if {[llength [get_projects -quiet]] > 0} { close_project }
if {[file exists $project_dir]} { file delete -force $project_dir }
create_project $project_name $project_dir -part xc7a100tcsg324-1 -force
set_property target_language Verilog [current_project]
set_property simulator_language Mixed [current_project]
set src_files [glob -nocomplain [file join $script_dir "src" "*.v"]]
if {[llength $src_files] == 0} { error "No Verilog source files found" }
add_files -norecurse $src_files
set mem_file [file join $script_dir "data" "loons240x160.mem"]
if {![file exists $mem_file]} { error "ROM initialization file not found: $mem_file" }
add_files -norecurse $mem_file
set_property file_type {Memory Initialization Files} [get_files [file tail $mem_file]]
set xdc_file [file join $script_dir "constraints" "NexysA7_100T_vga.xdc"]
add_files -fileset constrs_1 -norecurse $xdc_file
create_ip -name clk_wiz -vendor xilinx.com -library ip -version 6.0 -module_name clk_65mhz
set_property -dict [list CONFIG.PRIM_IN_FREQ {100.000} CONFIG.CLKOUT1_REQUESTED_OUT_FREQ {65.000} CONFIG.USE_RESET {true} CONFIG.RESET_TYPE {ACTIVE_HIGH} CONFIG.USE_LOCKED {false}] [get_ips clk_65mhz]
generate_target all [get_ips clk_65mhz]
set_property top vga_bsprite_top [current_fileset]
update_compile_order -fileset sources_1
update_compile_order -fileset sim_1
save_project_as $project_name $project_dir -force
puts "L7.1 project created successfully at $project_dir"
