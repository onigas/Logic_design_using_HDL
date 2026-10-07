# Source and Slide Notes

## Scope

The supplied L9 PDF contains exercises L9.1, L9.2, and L9.3. The original web
source directory also contains an L9.4 audio-PWM folder, but there is no L9.4
section in the supplied PDF. The repository therefore packages L9.1-L9.3 only.

No simulation sources or simulation assignments are included.

## Required presentation changes

### Slides 11-12 - remove simulation

The current presentation asks for a PWM simulation and then introduces
"L9.1.1 Simulation of generated PWM signal". These two slides should be removed
for the hardware-only laboratory version. The following slide,
"L9.1.2 PWM signal generator implementation", becomes the next task.

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
- 17-bit PWM counter with period `99999` for a 1 kHz PWM period.
- Comparison using `count[16:9]` and an 8-bit duty value.
- Existing asynchronous reset style in the PWM modules.
- Original Knight Rider timing constants and state behavior.

The 8-bit comparison is intentionally retained. Because the PWM period is
100000 clock cycles while `count[16:9]` has 512-count steps, values at the
high end of the switch range saturate at 100% duty. This is a consequence of
the original implementation, not a packaging error.
