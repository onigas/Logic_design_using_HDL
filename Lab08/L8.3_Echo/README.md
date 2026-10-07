# L8.3 - UART Echo

Send characters from the serial terminal. The FPGA receives each byte and
transmits the same byte back. For example, send `A`; the received reply
should also be `A`, and the seven-segment display should show `41`.

Disable **Local echo** in PuTTY (Terminal > Local echo > Force off) so that
the displayed character comes from the FPGA. Use no hardware flow control.

The transmitter loads `txbuff <= tx_data;`, with no `+8'h30` conversion.
The downloaded L8.3 archive already contains this correct line; it is
preserved here. `rx_data` is connected directly to the transmitter's
`tx_data`, as in the original project.

## Create and run

1. Download or clone the complete repository to a writable folder.
2. Open Vivado 2022.2 and close any other project.
3. In the Tcl Console, run the following, replacing the path with your folder:

   ```tcl
   source {C:/Labs/Logic_design_using_HDL/Lab08/L8.3_Echo/create_project.tcl}
   ```

4. Click **Generate Bitstream**, or run:

   ```tcl
   source {C:/Labs/Logic_design_using_HDL/Lab08/L8.3_Echo/build_bitstream.tcl}
   ```

5. Connect the board's **PROG/UART** USB connector. Use **Open Hardware Manager
   > Open Target > Auto Connect > Program Device** and select
   `build/L8_3_Echo/L8_3_Echo.runs/impl_1/Top_Module.bit`.
6. Press **BTNR** once to reset the design, then release it.
7. Open the board's COM port in PuTTY or another serial terminal:
   **9600 baud, 8 data bits, no parity, 1 stop bit, no flow control**.

The project file is generated at `build/L8_3_Echo/L8_3_Echo.xpr`.
Sources remain in `src/`; the generated project references them directly.
The script opens an existing generated project when run again. Close this
project before creating a different exercise.

The original `clkdiv`, divided clocks, UART FSMs, and baud counters are retained.
