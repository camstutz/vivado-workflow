create_clock -period 10 -name sys_clk
set_property PACKAGE_PIN AJ18 [get_ports sys_clk]
set_property IOSTANDARD LVCMOS18 [get_ports sys_clk]

set_property PACKAGE_PIN AF14 [get_ports a_in]
set_property IOSTANDARD LVCMOS18 [get_ports a_in]
set_property PACKAGE_PIN AF15 [get_ports b_in]
set_property IOSTANDARD LVCMOS18 [get_ports b_in]

set_property PACKAGE_PIN AD18 [get_ports {p_out[0]}]
set_property IOSTANDARD LVCMOS18 [get_ports {p_out[0]}]
set_property PACKAGE_PIN AD19 [get_ports {p_out[1]}]
set_property IOSTANDARD LVCMOS18 [get_ports {p_out[1]}]
set_property PACKAGE_PIN AG14 [get_ports {p_out[2]}]
set_property IOSTANDARD LVCMOS18 [get_ports {p_out[2]}]
set_property PACKAGE_PIN AG15 [get_ports {p_out[3]}]
set_property IOSTANDARD LVCMOS18 [get_ports {p_out[3]}]

set_property PACKAGE_PIN AG19 [get_ports q_out]
set_property IOSTANDARD LVCMOS18 [get_ports q_out]

set_property PACKAGE_PIN AJ14 [get_ports {r_out[0]}]
set_property IOSTANDARD LVCMOS18 [get_ports {r_out[0]}]
set_property PACKAGE_PIN AJ15 [get_ports {r_out[1]}]
set_property IOSTANDARD LVCMOS18 [get_ports {r_out[1]}]
set_property PACKAGE_PIN AG16 [get_ports {r_out[2]}]
set_property IOSTANDARD LVCMOS18 [get_ports {r_out[2]}]
set_property PACKAGE_PIN AG17 [get_ports {r_out[3]}]
set_property IOSTANDARD LVCMOS18 [get_ports {r_out[3]}]
