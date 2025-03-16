##Clock signal
set_property -dict { PACKAGE_PIN Y9   IOSTANDARD LVCMOS33 } [get_ports { clk_in }]; # 100MHz
create_clock -add -name sys_clk_pin -period 10.00 -waveform {0 5} [get_ports { clk_in }];


##Switches
set_property -dict { PACKAGE_PIN F22   IOSTANDARD LVCMOS18 } [get_ports { channel_select[0] }]; # Sch=SW0
set_property -dict { PACKAGE_PIN G22   IOSTANDARD LVCMOS18 } [get_ports { channel_select[1] }]; # Sch=SW1
set_property -dict { PACKAGE_PIN H22   IOSTANDARD LVCMOS18 } [get_ports { channel_select[2] }]; # Sch=SW2
set_property -dict { PACKAGE_PIN F21   IOSTANDARD LVCMOS18 } [get_ports { channel_select[3] }]; # Sch=SW3


##Buttons
set_property -dict { PACKAGE_PIN P16   IOSTANDARD LVCMOS18 } [get_ports { reset_btn }]; # Sch=BTNC
set_property -dict { PACKAGE_PIN R16   IOSTANDARD LVCMOS18 } [get_ports { duty_btn }]; # Sch=BTND
set_property -dict { PACKAGE_PIN N15   IOSTANDARD LVCMOS18 } [get_ports { edge_centerModeBtn }]; # Sch=BTNL
set_property -dict { PACKAGE_PIN R18   IOSTANDARD LVCMOS18 } [get_ports { low_hightrueBtn }]; # Sch=BTNR
#set_property -dict { PACKAGE_PIN T18   IOSTANDARD LVCMOS18 } [get_ports { BTNU }];  # Sch=BTNU

##LEDs
set_property -dict { PACKAGE_PIN T22   IOSTANDARD LVCMOS33 } [get_ports { PWM0 }]; # Sch=LED0
set_property -dict { PACKAGE_PIN T21   IOSTANDARD LVCMOS33 } [get_ports { PWM1 }]; # Sch=LED1
set_property -dict { PACKAGE_PIN U22   IOSTANDARD LVCMOS33 } [get_ports { PWM2 }]; # Sch=LED2
set_property -dict { PACKAGE_PIN U21   IOSTANDARD LVCMOS33 } [get_ports { PWM3 }]; # Sch=LED3

##Pmod Header JA
#set_property -dict { PACKAGE_PIN Y11   IOSTANDARD LVCMOS33 } [get_ports { PWM_OUT[0] }]; # Sch=JA1
#set_property -dict { PACKAGE_PIN AA11  IOSTANDARD LVCMOS33 } [get_ports { PWM_OUT[1] }]; # Sch=JA2
#set_property -dict { PACKAGE_PIN Y10   IOSTANDARD LVCMOS33 } [get_ports { PWM_OUT[2] }]; # Sch=JA3
#set_property -dict { PACKAGE_PIN AA9   IOSTANDARD LVCMOS33 } [get_ports { PWM_OUT[3] }]; # Sch=JA4
