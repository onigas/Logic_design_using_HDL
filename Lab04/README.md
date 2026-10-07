# Laboratory 4: FPGA memories

Complete source package for Vivado 2022.2 and the Nexys 4 DDR / Nexys A7-100T.
Use the FPGA part printed on the physical board. The included project scripts
select xc7a100tcsg324-1.

| Exercise | Architecture | Board input | Board output |
| --- | --- | --- | --- |
| L4.1 | HDL ROM, 8 x 8 | SW[2:0] | LED[7:0] |
| L4.2 | Distributed Memory Generator ROM, 16 x 8 | SW[3:0] | LED[7:0] |
| L4.3 | Block Memory Generator ROM, 8 x 16 | SW[2:0], CLK100MHZ | four 7-segment digits |

## Open the projects

For each exercise, run its create_project.tcl from Vivado 2022.2:

    vivado -mode batch -source L4.1_hdl_rom/create_project.tcl
    vivado -mode batch -source L4.2_distributed_rom/create_project.tcl
    vivado -mode batch -source L4.3_block_rom/create_project.tcl

Run these commands in the folder that contains this README. Each script resolves
its own location, creates a project in its vivado_project folder, adds RTL,
simulation and XDC sources, sets both top modules, and generates any required IP.

## Personal-data exercise

Run:

    python tools/make_personal_coe.py A1B2C3 20230928

The script writes two personal COE files to personal_data/, reports the expected
testbench constants, and leaves the example data untouched.
