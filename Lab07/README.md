# Laboratory 7: VGA sprites and screen-saver animation

Vivado 2022.2 source package for the Nexys4 DDR / Nexys A7-100T (`xc7a100tcsg324-1`).

The implemented designs use **1024 x 768 @ 60 Hz** with a **65 MHz pixel clock** and a 240 x 160 RGB image stored in FPGA Block RAM.

| Exercise | Topic | Main result |
| --- | --- | --- |
| L7.1 | Sprite from Block ROM | Display a 240 x 160 image at a selectable position |
| L7.2 | Screen saver | Move the sprite and bounce it at the display boundaries |

## Create a project

Each exercise has its own `create_project.tcl`. In the Vivado 2022.2 Tcl Console, change to the selected exercise directory and run:

```tcl
source create_project.tcl
```

No BAT file and no laboratory-level Tcl script are required.

- [`L7_1_sprite_block_rom_1024x768`](L7_1_sprite_block_rom_1024x768/)
- [`L7_2_screen_saver_1024x768`](L7_2_screen_saver_1024x768/)

The main image is `loons240x160`. The second image in L7.1 is included for the optional two-image extension exercise.
