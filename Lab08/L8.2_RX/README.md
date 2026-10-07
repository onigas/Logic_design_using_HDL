# L8.2 - UART Receiver

Send a character from the serial terminal. The four rightmost seven-segment
digits show the received byte in hexadecimal. For example, sending `A`
should display `41`. This exercise does not transmit a reply to the PC.

## Create and run

1. Download or clone the complete repository to a writable folder.
2. Open Vivado 2022.2 and close any other project.
3. In the Tcl Console, run the following, replacing the path with your folder:

   ```tcl
   source {C:/Labs/Logic_design_using_HDL/Lab08/L8.2_RX/create_project.tcl}
   ```

4. Click **Generate Bitstream**, or run:

   ```tcl
   source {C:/Labs/Logic_design_using_HDL/Lab08/L8.2_RX/build_bitstream.tcl}
   ```

5. Connect the board's **PROG/UART** USB connector. Use **Open Hardware Manager
   > Open Target > Auto Connect > Program Device** and select
   `build/L8_2_RX/L8_2_RX.runs/impl_1/Top_Module.bit`.
6. Press **BTNR** once to reset the design, then release it.
7. Open the board's COM port in PuTTY or another serial terminal:
   **9600 baud, 8 data bits, no parity, 1 stop bit, no flow control**.

The project file is generated at `build/L8_2_RX/L8_2_RX.xpr`.
Sources remain in `src/`; the generated project references them directly.
The script opens an existing generated project when run again. Close this
project before creating a different exercise.

The original `clkdiv`, divided clocks, UART FSMs, and baud counters are retained.
