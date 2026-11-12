# Program exactly one connected xc7a100t target through JTAG.
set ROOT [file normalize [file join [file dirname [info script]] ..]]
open_hw_manager
connect_hw_server
set targets [get_hw_targets -quiet]
if {[llength $targets] != 1} {error "Connect exactly one board, or select the intended board in Hardware Manager."}
open_hw_target [lindex $targets 0]
set devs [get_hw_devices -quiet -filter {PART == xc7a100t}]
if {[llength $devs] != 1} {error "Expected exactly one xc7a100t device"}
set dev [lindex $devs 0]
current_hw_device $dev
set bitfile [file join $ROOT output switch_led_top.bit]
if {![file exists $bitfile]} {
    set bitfile [file join $ROOT vivado switch_led.runs impl_1 switch_led_top.bit]
}
if {![file exists $bitfile]} {error "Build the bitstream before programming the board."}
set_property PROGRAM.FILE $bitfile $dev
program_hw_devices $dev
refresh_hw_device $dev
puts "SWITCH_LED_PROGRAMMING_COMPLETE"
close_hw_target
disconnect_hw_server
close_hw_manager
