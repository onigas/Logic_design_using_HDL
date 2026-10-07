# Vivado 2022.2: Nexys4 DDR / Nexys A7-100T, Artix-7 XC7A100T.
# Source this file in Vivado's Tcl Console, or use vivado -mode batch -source.
set lab_dir [file dirname [file normalize [info script]]]
set project_name L8_3_Echo
set project_dir [file join $lab_dir build $project_name]
set project_file [file join $project_dir "${project_name}.xpr"]

set rtl_files [list \
    [file join $lab_dir src clkdiv.v] \
    [file join $lab_dir src test_rx_ctrl.v] \
    [file join $lab_dir src test_tx_ctrl.v] \
    [file join $lab_dir src Top_Module.v] \
    [file join $lab_dir src uart_rx.v] \
    [file join $lab_dir src uart_tx.v] \
    [file join $lab_dir src x7segb.v]]
set xdc_file [file join $lab_dir constraints Nexys4DDR_UART.xdc]
foreach required_file [concat $rtl_files [list $xdc_file]] {
    if {![file isfile $required_file]} {
        error "Required file is missing: $required_file"
    }
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
    set_property top Top_Module [get_filesets sources_1]
    update_compile_order -fileset sources_1
    puts "Created project: $project_file"
}
