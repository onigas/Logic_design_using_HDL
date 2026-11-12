# Digilent Nexys A7-100T / Nexys4 DDR master pin assignments.
# https://github.com/Digilent/digilent-xdc/blob/master/Nexys-A7-100T-Master.xdc
set_property -dict { PACKAGE_PIN E3 IOSTANDARD LVCMOS33 } [get_ports { CLK100MHZ }]
set_property -dict { PACKAGE_PIN N17 IOSTANDARD LVCMOS33 } [get_ports { BTNC }]
set_property -dict { PACKAGE_PIN J15 IOSTANDARD LVCMOS33 } [get_ports { SW[0] }]
set_property -dict { PACKAGE_PIN A11 IOSTANDARD LVCMOS33 } [get_ports { AUD_PWM }]
set_property -dict { PACKAGE_PIN D12 IOSTANDARD LVCMOS33 } [get_ports { AUD_SD }]
create_clock -period 10.000 -name sys_clk_pin [get_ports CLK100MHZ]
set_false_path -from [get_ports {SW[0]}] -to [get_pins -hier -filter {NAME =~ *play_pipe_reg*/D}]
set_false_path -from [get_ports BTNC] -to [get_pins -hier -filter {NAME =~ *reset_pipe_reg*/PRE}]
