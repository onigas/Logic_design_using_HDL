# Source and Slide Notes

## Scope

All four exercises in the original L9 source directory are packaged:
L9.1-L9.4. The supplied PDF describes L9.1-L9.3; L9.4 is documented in its
own exercise README. L9.1 includes behavioral simulation. No simulation
assignments are added to L9.2-L9.4.

## Required presentation changes

### Slides 11-12 - retain L9.1 simulation

Keep these two slides and the "L9.1.1 Simulation of generated PWM signal"
task. The project-generation Tcl script now includes `sim/pwmsim.sv` with
simulation top `pwmsim`. The testbench starts with the original duty setting
of 97, adds a defined reset, checks a complete 1 ms PWM period for each duty
setting, and terminates after approximately 5 ms. Use **Run Behavioral
Simulation** or `run_simulation.tcl`.

The expected duty for `SW=97` is 49.664%, because the retained RTL compares
`count[16:9]` with SW. Values from 196 through 255 saturate at 100%; the
switch value is not a direct percentage or an evenly scaled 0-255 duty.

### Slide 19 - L9.3 undriven signals

The original Knight Rider source declares:

```verilog
wire inc,dec;
```

but neither signal has a driver, while both are used in the `mode[0]` branch.
That makes this branch dependent on an undriven internal net.

The packaged source uses the minimum deterministic correction:

```verilog
wire inc = 1'b0;
wire dec = 1'b0;
```

With this correction, `SW0=0` runs the Knight Rider animation and `SW0=1`
holds the current brightness values. The normal Knight Rider path and its PWM
timing are otherwise unchanged.

Update the corresponding declaration shown on slide 19. The code shown on
slide 20 can remain unchanged.

## L9.2 hardware safety

The Pmod DHB1 reference manual recommends driving EN low before changing DIR.
The current top-level RTL connects the direction switches directly to the DIR
outputs, so the laboratory procedure must enforce this sequence:

1. Set `SW[7:0]=0` so both PWM enable outputs are low.
2. Change `SW15` and/or `SW14` to select the direction.
3. Restore `SW[7:0]` to the desired motor speed.

This should be repeated on the hardware-test slide (slide 18), even though the
general warning already appears earlier in the presentation.

## Optional wording cleanup

On slide 16, "the previous lab" is better written as "the previous exercise
(L9.1)", because the PWM generator is created earlier in the same laboratory.

## Retained design choices

- 100 MHz board clock.
- L9.1-L9.3: 17-bit PWM counter with period `99999` for a 1 kHz PWM period.
- Comparison using `count[16:9]` and an 8-bit duty value.
- Existing asynchronous reset style in the PWM modules.
- Original Knight Rider timing constants and state behavior.

The 8-bit comparison is intentionally retained. Because the PWM period is
100000 clock cycles while `count[16:9]` has 512-count steps, values at the
high end of the switch range saturate at 100% duty. This is a consequence of
the original implementation, not a packaging error.

## L9.4 audio project

`PWMAudio.vhd`, `PWMDriver.vhd`, and `pwm.coe` are copied from the original
source directory without RTL or data changes. The XDC includes the active
original clock, nine switches, and two audio-pin constraints; in particular,
SW8 remains **LVCMOS18**. The audio output retains its required open-drain
behavior (`0` / `Z`).

Instead of importing the old `dist_mem_gen_0.xci` with generated paths, the
Tcl script recreates Distributed Memory Generator v8.0 with the same
functional settings: ROM, depth 1024, data width 10, non-registered input
and output, and initialization from the original `pwm.coe`. The ROM is
synthesized with the top-level design. Generated IP files stay under `build/`.

The sine-wave address frequency is `100 MHz / (1024 * (SW + 1))`; decimal
SW=97 gives approximately 996.49 Hz. The audio PWM carrier remains
`100 MHz / 1024 = 97.65625 kHz`. These are separate frequencies. Very small
SW values can yield ultrasonic or aliased output, as in the original code.

## Preparation checks

- Icarus Verilog 12.0 compiled the L9.1-L9.3 design tops without errors.
- The L9.1 testbench passed reset, 100000-clock period, and duty checks for
  switch values 97, 0, 195, 196, and 255.
- GHDL 4.1 analyzed both L9.4 VHDL files without errors. This is a syntax
  check; the actual Vivado ROM IP was not generated in this environment.
- The original L9.4 VHDL, 1024-sample COE data, and active XDC assignments
  were compared with the packaged files and are unchanged.
- Tcl control flow and file references were checked with stubbed Vivado
  commands, including all four projects, the ROM settings, and adding the
  simulation to a previously generated L9.1 project without duplicate files.

Vivado 2022.2/XSim, synthesis, implementation, bitstream generation, and
on-board operation have not been run in the preparation environment.
