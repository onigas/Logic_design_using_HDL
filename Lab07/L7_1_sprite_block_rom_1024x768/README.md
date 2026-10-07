# L7.1: VGA sprite from Block ROM

Reproducible Vivado 2022.2 project for Nexys A7-100T / Nexys4 DDR.

From the Vivado Tcl Console, change to this directory and run:

```tcl
source create_project.tcl
```

The design uses 1024 x 768 @ approximately 60 Hz, a 65 MHz pixel clock, and a 240 x 160 image stored in inferred Block ROM. `SW[3:0]` and `SW[7:4]` select the horizontal and vertical sprite position. `BTNC` resets the VGA logic.

The active video area starts at `hbp = 296` and `vbp = 35`. The primary image is `data/loons240x160.mem`; an additional Pamukkale image is included for the optional two-image task.
