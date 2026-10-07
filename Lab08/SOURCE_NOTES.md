# Source Notes

## L8.3 echo byte

The original `L8.3.srcs.rar` downloaded from the laboratory website already
loads the byte without modification:

```verilog
txbuff <= tx_data;
```

The packaged L8.3 transmitter retains this line. There is no `+8'h30`
conversion. The top-level connection is also retained:

```verilog
uart_tx U3(.clk(clk25), .clr(clr), .tx_data(rx_data),
           .ready(ready), .tdre(tdre), .TxD(TxD));
```

All distributed RTL files are byte-for-byte copies of the downloaded
original sources. No functional patch was necessary to achieve the
requested raw-byte loading, because it is already present in those sources.

## Slide 9

The supplied presentation's **slide 9**, first code panel, contains:

```verilog
txbuff <= tx_data + 8'h30;
```

To match these sources and preserve raw bytes, replace that line with:

```verilog
txbuff <= tx_data;
```

This is a presentation/source mismatch. The presentation itself is not
modified in this package.

## Project packaging

- Added a `create_project.tcl` and `build_bitstream.tcl` for each exercise.
- Added an optional root `create_all_projects.tcl`.
- Supplied the original active pin and clock constraints for every project;
  removed unused commented-out master-XDC entries only. L8.1's constraints
  come from the `transmitter` folder in the original `UART.ZIP` download.
- Added short English instructions. Existing source comments and RTL logic
  remain unchanged.

The basic receiver's original asynchronous `rdrf_clr` control style is
retained. Portable synthesis reports warnings about this style; these
checks do not establish Vivado implementation or board functionality.
