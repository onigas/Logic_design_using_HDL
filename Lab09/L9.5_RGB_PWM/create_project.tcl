# Vivado 2022.2: Nexys4 DDR / Nexys A7-100T, Artix-7 XC7A100T.
set lab_dir [file dirname [file normalize [info script]]]
set project_name L9_5_RGB_PWM
set project_dir [file join $lab_dir build $project_name]
set project_file [file join $project_dir "${project_name}.xpr"]

set rtl_files [list [file join $lab_dir src rgb_pwm.v]]
set xdc_file [file join $lab_dir constraints Nexys4DDR_RGB_PWM.xdc]
set sim_file [file join $lab_dir sim rgb_pwm_tb.sv]
foreach required_file [concat $rtl_files [list $xdc_file $sim_file]] {
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
    set_property target_language Verilog [current_project]
    set_property default_lib xil_defaultlib [current_project]
    add_files -norecurse -fileset sources_1 $rtl_files
    add_files -norecurse -fileset constrs_1 [list $xdc_file]
    set_property top rgb_pwm [get_filesets sources_1]
    update_compile_order -fileset sources_1
    puts "Created project: $project_file"
}

# Also update previously generated L9.5 projects with the simulation source.
if {[lsearch -exact [get_files -quiet -of_objects [get_filesets sim_1]] $sim_file] < 0} {
    add_files -norecurse -fileset sim_1 [list $sim_file]
}
set_property top rgb_pwm_tb [get_filesets sim_1]
set_property xsim.simulate.runtime {10ms} [get_filesets sim_1]
update_compile_order -fileset sim_1
