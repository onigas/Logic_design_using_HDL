# Vivado 2022.2: Nexys4 DDR / Nexys A7-100T, Artix-7 XC7A100T.
set lab_dir [file dirname [file normalize [info script]]]
set project_name L9_4_PWM_Audio
set project_dir [file join $lab_dir build $project_name]
set project_file [file join $project_dir "${project_name}.xpr"]

set rtl_files [list [file join $lab_dir src PWMDriver.vhd] \
                    [file join $lab_dir src PWMAudio.vhd]]
set xdc_file [file join $lab_dir constraints Nexys4DDR_PWM_Audio.xdc]
set coe_file [file normalize [file join $lab_dir data pwm.coe]]
foreach required_file [concat $rtl_files [list $xdc_file $coe_file]] {
    if {![file isfile $required_file]} { error "Required file is missing: $required_file" }
}
if {[llength [get_projects -quiet]] > 0} {
    set active_project [current_project]
    if {[get_property NAME $active_project] ne $project_name ||
        [file normalize [get_property DIRECTORY $active_project]] ne $project_dir} {
        error "Close the current Vivado project before creating $project_name."
    }
    puts "Using the open project: $project_file"
} elseif {[file exists $project_file]} {
    open_project $project_file
    puts "Opened existing project: $project_file"
} else {
    create_project $project_name $project_dir -part xc7a100tcsg324-1
    set_property target_language VHDL [current_project]
    set_property simulator_language Mixed [current_project]
    set_property default_lib xil_defaultlib [current_project]
    add_files -norecurse -fileset sources_1 $rtl_files
    add_files -norecurse -fileset constrs_1 [list $xdc_file]

    # Recreate the original 1024 x 10 asynchronous sine-wave ROM.
    create_ip -name dist_mem_gen -vendor xilinx.com -library ip -version 8.0 \
              -module_name dist_mem_gen_0
    set_property -dict [list \
        CONFIG.depth {1024} \
        CONFIG.data_width {10} \
        CONFIG.memory_type {rom} \
        CONFIG.input_options {non_registered} \
        CONFIG.output_options {non_registered} \
        CONFIG.coefficient_file $coe_file] [get_ips dist_mem_gen_0]
    # Synthesize this small ROM together with the top-level design.
    set_property generate_synth_checkpoint false [get_files dist_mem_gen_0.xci]
    generate_target all [get_ips dist_mem_gen_0]

    set_property top PWMAudio [get_filesets sources_1]
    update_compile_order -fileset sources_1
    puts "Created project: $project_file"
}
