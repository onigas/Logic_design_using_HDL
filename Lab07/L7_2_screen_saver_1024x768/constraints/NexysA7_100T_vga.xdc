## Nexys A7-100T / Nexys4 DDR constraints for LDHDL VGA labs
proc set_port_pin {port pin iostd} { set obj [get_ports -quiet $port]; if {[llength $obj] > 0} { set_property -dict [list PACKAGE_PIN $pin IOSTANDARD $iostd] $obj } }
set_port_pin {CLK100MHZ} E3 LVCMOS33
create_clock -add -name sys_clk_pin -period 10.00 -waveform {0 5} [get_ports {CLK100MHZ}]
set_port_pin {BTNC} N17 LVCMOS33
set_port_pin {BTNL} P17 LVCMOS33
set_port_pin {VGA_R[0]} A3 LVCMOS33
set_port_pin {VGA_R[1]} B4 LVCMOS33
set_port_pin {VGA_R[2]} C5 LVCMOS33
set_port_pin {VGA_R[3]} A4 LVCMOS33
set_port_pin {VGA_G[0]} C6 LVCMOS33
set_port_pin {VGA_G[1]} A5 LVCMOS33
set_port_pin {VGA_G[2]} B6 LVCMOS33
set_port_pin {VGA_G[3]} A6 LVCMOS33
set_port_pin {VGA_B[0]} B7 LVCMOS33
set_port_pin {VGA_B[1]} C7 LVCMOS33
set_port_pin {VGA_B[2]} D7 LVCMOS33
set_port_pin {VGA_B[3]} D8 LVCMOS33
set_port_pin {VGA_HS} B11 LVCMOS33
set_port_pin {VGA_VS} B12 LVCMOS33
