# L8.4 – Bluetooth UART Echo and LED Control

## Objective

Extend **L8.3 UART Echo** using an **HC-06 Bluetooth SPP module** on the
**JB Pmod header**, then decode the ASCII digit received from the Android
**Serial Bluetooth Terminal** application to select an onboard LED.
The previous UART echo behavior and the seven-segment hexadecimal display
remain active. This task has no testbench, in keeping with Lab 08.

## Wiring – verified arrangement reported by the instructor

| HC-06 signal | FPGA top port | Nexys4 DDR Pmod | FPGA package pin |
| --- | --- | --- | --- |
| **TXD** | `RxD` (FPGA input) | **JB4** | **H14** |
| **RXD** | `TxD` (FPGA output) | **JB3** | **G16** |
| GND | GND | JB ground | — |
| Supply | 3.3 V (if supported by the HC-06 breakout) | JB 3V3 | — |

The instructor has already tested Bluetooth echo on H14/G16. The LED extension
in this package **has not yet been tested on the board**. Check the specific
HC-06 breakout's supply voltage and RX-level requirements before powering it.
Do **not** connect 5 V logic to JB signal pins. The original slide describes
the HC-05/06 orientation with its EN/KEY pin protruding; confirm the physical
module orientation by its signal labels, not by appearance alone.

**UART**: 9600 baud, 8 data bits, no parity, 1 stop bit, no flow control,
subject to the configured HC-06 baud rate. The original 25 MHz UART clock,
~190 Hz display clock, UART FSMs, and `clkdiv` are unchanged.

## Commands

| Character from phone | ASCII byte | Effect |
| --- | --- | --- |
| `0` | `0x30` | Turn on **LED0**; turn off LED1–LED9 |
| `1` | `0x31` | Turn on **LED1**; turn off the others |
| `2` | `0x32` | Turn on **LED2**; turn off the others |
| `3` ... `9` | `0x33` ... `0x39` | Turn on **LED3** ... **LED9**, respectively |
| `X` | `0x58` | Turn off **all LED0–LED9** |
| Other characters, `CR`, `LF` | — | No change in LED state |

Every character is still **echoed back to the phone** regardless of its
meaning as an LED command. The seven-segment display still shows the last
received byte in **hexadecimal**, e.g. `31` after sending `1`. The commands
are ASCII: pressing `1` sends `0x31`, not binary `0x01`.

**LED numbering is literal**: `0` selects the onboard LED labeled **LED0**,
`1` selects **LED1**, and so on through `9` / **LED9**. Only one LED0–LED9
is active at a time. Uppercase `X` turns them all off, as does **BTNR**.

## Generate the project (Vivado 2022.2)

Close other Vivado projects and run, adjusting the folder path:

```tcl
source {C:/Labs/Logic_design_using_HDL/Lab08/L8.4_Bluetooth_LED/create_project.tcl}
```

Click **Generate Bitstream** or run:

```tcl
source {C:/Labs/Logic_design_using_HDL/Lab08/L8.4_Bluetooth_LED/build_bitstream.tcl}
```

The project is generated in `build/L8_4_Bluetooth_LED/`. Program the FPGA
using **Hardware Manager** and the generated `Top_Module.bit`.

## Hardware checks

1. Connect/power the HC-06 and pair it with an Android phone.
2. Open **Serial Bluetooth Terminal**; connect to the HC-06 at the configured
   baud rate, with 8N1 framing. Disable local echo in the application if it
   offers that setting, to distinguish returned bytes from locally shown input.
3. Send `1`: **LED1** must light; received echo must be `1`; display shows `31`.
4. Send `2`: **LED2** must light and LED1 must go out; echo `2`, display `32`.
5. Send `9`: **LED9** lights. Send `0`: **LED0** lights, LED9 goes out;
   echo `0`, display shows `30`.
6. Send uppercase `X`: all **LED0–LED9** go out; echo `X`, display shows `58`.
7. Send `A` or press Enter with CR/LF enabled: LED state does not change;
   received bytes are still echoed.
8. Press **BTNR**: LED0–LED9 go out. Then release reset.

## Scope / implementation

Original L8.3 modules (`uart_rx`, `uart_tx`, `clkdiv`, `test_rx_ctrl`,
`test_tx_ctrl`, `x7segb`) are copied without modification. Only
`src/Top_Module.v` adds a clocked ASCII-to-LED decoder, and the XDC assigns
JB H14/G16 plus the ten onboard LED pins (LED0–LED9). No simulation files were added.

**Status**: instructor reports that the previous L8.4 Bluetooth echo and
LED1–LED9 control work on the physical FPGA. The revised LED0 / uppercase-X
behavior has undergone source-level checks only; its Vivado build and hardware
operation must be validated after downloading the updated project.
