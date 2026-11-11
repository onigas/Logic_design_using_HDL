# Laboratory 11 | I²C master design in Verilog

Read [the laboratory handout](Laboratory_11.pdf). This standalone 120-minute exercise uses a Nexys4 DDR and Vivado 2022.2 with Artix-7 and XSim support. Simulation needs only the project files. For hardware, use a USB data cable and a serial terminal. Python is optional.

## Student workflow

1. Open the Lab11 directory in your clone or extracted download. From a Vivado command prompt there, run `vivado -mode batch -source create_project.tcl -tclargs student`.
2. Open `build_student/lab11.xpr`. Complete the four TODOs in `student/temperature_sequence.v`. The starter compiles and reaches the 250 µs testbench timeout until the sequencer is implemented.
3. Run Behavioral Simulation with `tb_lab11`. Add the signals listed on page 8, restart, and Run All. The target model withholds the first ACK before returning positive and negative temperature words. The PASS message confirms two complete ASCII lines.
4. Generate the bitstream. Connect the powered board via PROG/UART. When ready to replace its current configuration, use Hardware Manager to program `build_student/lab11.runs/impl_1/lab11_top.bit`. Open the board's serial port at 115200 baud, 8N1, flow control off. Reports begin automatically.

## Design and scope

The RTL folder contains the top level, open-drain I²C engine, signed decimal formatter and UART transmitter. The selected sequencer schedules one combined read each second. The constraints file maps SCL to C14, SDA to C15 and serial TX to D4. The testbench models pulled-up pins and decodes UART independently of the formatter.

The sensor is assumed to be in its power-up configuration, with continuous conversion and 13-bit resolution. CPU RESET resets the FPGA logic. If a previous project changed the sensor mode, restore its power-up defaults before running the exercise. The controller assumes one master. Permanently low SCL stalls the byte engine.

## Reference solution and hardware evidence

The [student sequencer](student/temperature_sequence.v) and [reference solution](reference/temperature_sequence.v) share the same RTL modules and testbench. To build the reference, run `vivado -mode batch -source create_project.tcl -tclargs reference` and open `build_reference/lab11.xpr`. Generate its bitstream in Vivado. The [serial capture](uart_capture.txt) contains ten readings from the physical board.

The reference passed the pin-level XSim test. Vivado 2022.2 generated the Artix-7 bitstream with worst setup slack +4.513 ns and worst hold slack +0.131 ns on the constrained clock. The starter separately compiled and reached the expected timeout.

During the reference board run on 11 November 2026, ten consecutive COM8 records ranged from +23.50 to +23.56 °C. The capture includes elapsed PC timestamps. This test establishes functional acquisition in that run. Absolute accuracy would require comparison with a calibrated thermometer.

## Technical sources

- [Analog Devices ADT7420 data sheet](https://www.analog.com/media/en/technical-documentation/data-sheets/ADT7420.pdf)
- [Digilent Nexys4 DDR reference manual, section 13](https://digilent.com/reference/_media/nexys4-ddr/nexys4ddr_rm.pdf)
- [Digilent Nexys4 DDR master XDC](https://github.com/Digilent/digilent-xdc/blob/master/Nexys-4-DDR-Master.xdc)
