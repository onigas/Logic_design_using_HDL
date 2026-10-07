# Laboratory 6: VGA controller

Vivado 2022.2 source package for the Nexys4 DDR / Nexys A7-100T (`xc7a100tcsg324-1`).

This laboratory uses **1024 x 768 @ 60 Hz** with a **65 MHz pixel clock** for the implemented designs.

| Exercise | Topic | Main result |
| --- | --- | --- |
| L6.1 | VGA timing and stripes | Alternating red/green horizontal stripes |
| L6.2 | VGA + PROM sprite | Display a 32 x 16 character bitmap and move it using switches |

## Create a project

Each exercise has its own `create_project.tcl`. Open **Vivado 2022.2 -> Window -> Tcl Console**, change to the selected exercise directory, and run:

```tcl
source create_project.tcl
```

No BAT file and no laboratory-level Tcl script are required.
