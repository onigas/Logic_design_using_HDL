# L7.2: VGA screen saver

Reproducible Vivado 2022.2 project for Nexys A7-100T / Nexys4 DDR.

From the Vivado Tcl Console, change to this directory and run:

```tcl
source create_project.tcl
```

The design uses the 65 MHz pixel clock as its only sequential clock. Sprite coordinates are updated on a one-cycle `frame_tick`, once per VGA frame. `BTNL` is synchronized and debounced and starts the movement; `BTNC` resets the design.

For a 240 x 160 sprite on 1024 x 768 active video, the maximum upper-left coordinates are `C1max = 784` and `R1max = 608`.
