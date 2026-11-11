# Digilent Nexys4 DDR Rev. C master XDC, seven used ports.
set_property -dict {PACKAGE_PIN E3 IOSTANDARD LVCMOS33} [get_ports CLK100MHZ]
create_clock -name sys_clk -period 10.000 [get_ports CLK100MHZ]
set_property -dict {PACKAGE_PIN C12 IOSTANDARD LVCMOS33} [get_ports CPU_RESETN]
set_property -dict {PACKAGE_PIN E15 IOSTANDARD LVCMOS33} [get_ports ACL_MISO]
set_property -dict {PACKAGE_PIN F14 IOSTANDARD LVCMOS33} [get_ports ACL_MOSI]
set_property -dict {PACKAGE_PIN F15 IOSTANDARD LVCMOS33} [get_ports ACL_SCLK]
set_property -dict {PACKAGE_PIN D15 IOSTANDARD LVCMOS33} [get_ports ACL_CSN]
set_property -dict {PACKAGE_PIN D4 IOSTANDARD LVCMOS33} [get_ports UART_RXD_OUT]
