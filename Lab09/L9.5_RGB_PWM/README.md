# L9.5 - RGB LED Color Control using PWM

Control the two onboard RGB LEDs independently using all 16 switches on the
**Nexys4 DDR / Nexys A7-100T**, FPGA **xc7a100tcsg324-1**, with **Vivado 2022.2**.
No external modules or IP cores are required.

## Switch mapping

| LED | Red (3 bits) | Green (3 bits) | Blue (2 bits) |
| --- | --- | --- | --- |
| LED16 | SW[7:5] | SW[4:2] | SW[1:0] |
| LED17 | SW[15:13] | SW[12:10] | SW[9:8] |

Each byte is `RRRGGGBB` (RGB332), giving 256 color settings per LED.
The upper and lower bytes are independent. BTNC is an active-high reset:
hold it to blank both LEDs, then release it to restore the switch-selected colors.

## Architecture and brightness

The 100 MHz clock drives **one shared 8-bit PWM counter** for all six channels.
It wraps every 256 clocks, so the PWM frequency is **390.625 kHz** and the
period is **2.56 microseconds**. No derived clocks or clock divider are used.

Each output is active high for `threshold` clock cycles per frame:

- Red/green: `floor(level * 127 / 7)` -> `0, 18, 36, 54, 72, 90, 108, 127`.
- Blue: `floor(level * 127 / 3)` -> `0, 42, 84, 127`.
- Duty cycle: `threshold / 256`; maximum **49.609375%**, zero means fully off.

Small lookup tables implement these mappings without divider hardware.
The conservative brightness limit follows Digilent's recommendation to use PWM
and limit RGB LED duty to about 50%. This is linear electrical duty, without
gamma correction or color calibration; perceived intensity is not linear and
equal RGB levels need not produce a calibrated white.

Switch inputs pass through two synchronizer stages. Their values are latched
at the frame boundary, keeping thresholds constant throughout each frame.
Outputs are registered and share the same phase. Switches are not debounced:
changing several switches may briefly display intermediate colors.
BTNC asserts the reset synchronizer asynchronously and releases it synchronously;
the datapath and LEDs reset on the next clock. Startup reset is initialized
using FPGA configuration register values.

## Board constraints

The XDC matches the official Digilent masters for both supported boards:

| Signal | Package pin | I/O standard |
| --- | --- | --- |
| CLK100MHZ | E3 | LVCMOS33 |
| BTNC | N17 | LVCMOS33 |
| SW[0..7] | J15, L16, M13, R15, R17, T18, U18, R13 | LVCMOS33 |
| SW[8..9] | T8, U8 | **LVCMOS18** |
| SW[10..15] | R16, T13, H6, U12, U11, V10 | LVCMOS33 |
| LED16 R/G/B | N15 / M16 / R12 | LVCMOS33 |
| LED17 R/G/B | N16 / R11 / G14 | LVCMOS33 |

Do not change SW8/SW9 to LVCMOS33. The XDC defines a 10 ns clock and excludes
only the asynchronous external paths into the first synchronization stage.

Sources:
[Nexys A7 master XDC](https://github.com/Digilent/digilent-xdc/blob/master/Nexys-A7-100T-Master.xdc),
[Nexys4 DDR master XDC](https://github.com/Digilent/digilent-xdc/blob/master/Nexys-4-DDR-Master.xdc),
[Nexys A7 reference manual](https://digilent.com/reference/_media/reference/programmable-logic/nexys-a7/nexys-a7_rm.pdf).

## Create, simulate and build

In the Vivado 2022.2 Tcl Console, close any unrelated project and run (adjust
the repository path):

```tcl
source {C:/Labs/Logic_design_using_HDL/Lab09/L9.5_RGB_PWM/create_project.tcl}
```

The project is `build/L9_5_RGB_PWM/L9_5_RGB_PWM.xpr`, with top module `rgb_pwm`.
Scripts resolve paths relative to their own location and support paths with spaces.
Re-running the creation script opens or reuses the existing project.

Run **Run Behavioral Simulation**, or:

```tcl
source {C:/Labs/Logic_design_using_HDL/Lab09/L9.5_RGB_PWM/run_simulation.tcl}
```

The self-checking test measures high cycles over complete 256-clock periods.
It tests all 256 words on each LED with the other LED off, complementary words
on both LEDs, all-on/all-off, reset during PWM, held reset and recovery.
It finishes in about 6 ms with `PASS: L9.5 all RGB332 levels, independent channels, reset and recovery`.

Generate the bitstream with **Generate Bitstream**, or:

```tcl
source {C:/Labs/Logic_design_using_HDL/Lab09/L9.5_RGB_PWM/build_bitstream.tcl}
```

Batch alternatives, from this exercise directory:

```text
vivado -mode batch -source run_simulation.tcl
vivado -mode batch -source build_bitstream.tcl
```

The build script checks synthesis and implementation completion and the bitstream
file, then writes timing, utilization and DRC reports under `build/`.
Generated files are excluded from version control.

## Test on the board

1. Connect and power the board, then open **Hardware Manager -> Open Target ->
   Auto Connect** in Vivado.
2. Choose **Program Device** and select
   `build/L9_5_RGB_PWM/L9_5_RGB_PWM.runs/impl_1/rgb_pwm.bit`.
3. Start with all switches off: both RGB LEDs should be off.
4. Try the following hexadecimal switch words (SW15 is the most significant bit):

| SW[15:0] | LED16 | LED17 |
| --- | --- | --- |
| 00E0 | Red | Off |
| 001C | Green | Off |
| 0003 | Blue | Off |
| 00FC | Yellow | Off |
| 00E3 | Magenta | Off |
| 001F | Cyan | Off |
| 00FF | White mixture | Off |
| E000 | Off | Red |
| 1C00 | Off | Green |
| 0300 | Off | Blue |
| E003 | Blue | Red |
| FFFF | White mixture | White mixture |

5. Change each color field through its levels and check increasing brightness.
   Changing one byte should leave the other LED unchanged.
6. Hold BTNC: both LEDs turn off. Release it: the selected colors return.

## Validation

Validated with Vivado 2022.2 on 2026-11-12:

- XSim behavioral simulation: PASS (5.99375 ms simulated time).
- Synthesis, implementation and bitstream generation: completed successfully.
- Routed timing at 100 MHz: WNS +6.362 ns, WHS +0.122 ns, no failing endpoints.
- DRC: no errors; one non-blocking `CFGBVS-1` warning because configuration-bank
  voltage metadata is not supplied in the Digilent master pin constraints.
  No DRC severity overrides are used.

The timing report also lists external input/output delays as unspecified:
switches/reset are asynchronous inputs and the LEDs are not a synchronous
external interface. Internal register timing is constrained by the 100 MHz clock.
Physical brightness, color balance and operation must be checked on the board.
