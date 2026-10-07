# LDHDL Laboratory 6.2 - VGA letters from PROM, 1024x768 @ 60 Hz
set script_dir [file normalize [file dirname [info script]]]
set project_name "L6_2_letters_1024x768"
set project_dir [file normalize [file join $script_dir "vivado_project"]]
if {[llength [get_projects -quiet]] > 0} { close_project }
if {[file exists $project_dir]} { file delete -force $project_dir }
create_project $project_name $project_dir -part xc7a100tcsg324-1 -force
set_property target_language Verilog [current_project]
set_property simulator_language Mixed [current_project]
set src_files [glob -nocomplain [file join $script_dir "src" "*.v"]]
if {[llength $src_files] == 0} { error "No Verilog source files found" }
add_files -norecurse $src_files
set xdc_file [file join $script_dir "constraints" "Nexys4DDR_Master.xdc"]
add_files -fileset constrs_1 -norecurse $xdc_file
create_ip -name clk_wiz -vendor xilinx.com -library ip -version 6.0 -module_name clk_65mhz
set_property -dict [list CONFIG.PRIM_IN_FREQ {100.000} CONFIG.CLKOUT1_REQUESTED_OUT_FREQ {65.000} CONFIG.USE_RESET {true} CONFIG.RESET_TYPE {ACTIVE_HIGH} CONFIG.USE_LOCKED {false}] [get_ips clk_65mhz]
generate_target all [get_ips clk_65mhz]
set_property top vga_stripes_top [current_fileset]
update_compile_order -fileset sources_1
update_compile_order -fileset sim_1
save_project_as $project_name $project_dir -force
puts "L6.2 project created successfully at $project_dir"
