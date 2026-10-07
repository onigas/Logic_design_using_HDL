# Laboratory 5: four-bit ALU and seven-segment display

Student source package for Vivado 2022.2 and the Nexys 4 DDR / Nexys A7-100T
board with the XC7A100T-1CSG324C device. Each exercise folder is standalone.

| Exercise | Circuit | Board output |
| --- | --- | --- |
| L5.1 | Four-bit ALU | LED[7:0] |
| L5.2 | Same ALU with an eight-bit hexadecimal display | AN0, AN1 and SEG[6:0] |
| L5.3 | Two ROM reads, a four-bit adder, hexadecimal display | AN0, AN1 and SEG[6:0] |

## Build the projects

In the Vivado 2022.2 Tcl Console, source one script at a time:

    source {C:/Lab5/L5.1_alu_leds/create_project.tcl}
    source {C:/Lab5/L5.2_alu_display/create_project.tcl}
    source {C:/Lab5/L5.3_memory_alu/create_project.tcl}

The scripts resolve paths relative to their own locations and create a project under each exercise's vivado_project folder.
