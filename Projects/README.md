# Logic Design Using HDL — Project Proposals

**Target board:** Nexys 4 DDR / Nexys A7-100T  
**Design languages:** VHDL or Verilog  
**Development environment:** Vivado 2022.2  
**Suggested duration:** 4–5 weeks

The following **17 independent project proposals** link to detailed assignments. Students may reproduce and adapt open-source HDL reference implementations.

| No. | Project title | Maximum grade |
| ---: | --- | --- |
| 1 | [Digital Clock with Seven-Segment Display](Details/Project-01.md) | 3/5 |
| 2 | [Digital Alarm Clock with UART Interface](Details/Project-02.md) | 4/5 |
| 3 | [Advanced Digital Clock with VGA Display and Multiple Alarms](Details/Project-03.md) | 5/5 |
| 4 | [Multichannel PWM Generator](Details/Project-04.md) | To be specified |
| 5 | [Traffic Intersection with Pedestrian Crossings and VGA Monitoring](Details/Project-05.md) | To be specified |
| 6 | [SPI Interface for the ADXL362 Accelerometer](Details/Project-06.md) | To be specified |
| 7 | [Interactive VGA Graphics and Text Display](Details/Project-07.md) | 3/5 |
| 8 | [FPGA VGA Drawing Application](Details/Project-08.md) | 4/5 |
| 9 | [Advanced FPGA VGA Graphics Editor](Details/Project-09.md) | 5/5 |
| 10 | [FPGA-Based Pong / Space Invaders Game](Details/Project-10.md) | To be specified |
| 11 | [FPGA-Based Digital Logic Analyzer](Details/Project-11.md) | To be specified |
| 12 | [FPGA-Based FIR Digital Filter](Details/Project-12.md) | To be specified |
| 13 | [PWM Audio Signal Processor](Details/Project-13.md) | To be specified |
| 14 | [Digital Security System with Access Code](Details/Project-14.md) | To be specified |
| 15 | [FPGA-Based Digital Piano](Details/Project-15.md) | 4/5 |
| 16 | [FPGA-Based Digital Piano with Recording and Playback](Details/Project-16.md) | 5/5 |
| 17 | [FPGA-Based Robotic Arm Controller](Details/Project-17.md) | 5/5 (proposed) |


## Notes

Projects 1–3 are separate digital clock assignments with maximum grades 3/5, 4/5 and 5/5. Projects 7–9 are separate VGA graphics assignments with maximum grades 3/5, 4/5 and 5/5. The two piano projects and the robotic arm project (15–17) have already been selected by students. A maximum grade is a ceiling, not an automatic grade.

## General Project Guidelines

Students may reproduce and adapt existing open-source FPGA projects, reference designs, or tutorials. The primary objective is to understand digital hardware architectures and develop practical HDL design skills.

Each project should include:

- A functional HDL implementation running on the Nexys 4 DDR board.
- An explanation of the main design modules, datapath, control logic, and finite state machines, where applicable.
- Functional verification through simulation and hardware testing.
- A brief technical report including design architecture, simulation results, and FPGA resource utilization.
- At least one modification or extension of the reference implementation, whenever feasible.

The use of MicroBlaze or other embedded processors is not required. The focus is on digital hardware design.

## Recommended Project Schedule

| Week | Activities | Expected Deliverables |
| --- | --- | --- |
| 1 | Study the selected project, review reference designs, identify hardware modules, and prepare the architecture. | Block diagram and implementation plan |
| 2 | Implement or adapt HDL modules, develop testbenches, and perform functional simulations. | HDL source files and simulation results |
| 3 | Integrate the design, run synthesis and implementation, and test it on the Nexys 4 DDR. | Working FPGA prototype |
| 4 | Debug the system, validate its functionality, and measure FPGA resource utilization. | Functional demonstration and technical results |
| 5 | Implement optional extensions, finalize documentation, and present the project. | Final report, source code, and demonstration |

For four-week projects, the validation and final presentation activities may be combined.

## Evaluation Criteria

| Criterion | Weight |
| --- | ---: |
| Functional implementation on FPGA | 35% |
| Understanding and explanation of the HDL architecture | 25% |
| Simulation and hardware verification | 15% |
| Project documentation | 15% |
| Modifications or extensions | 10% |
| **Total** | **100%** |

Reproducing a reference design is acceptable, provided that students can explain its operation, identify the important modules, demonstrate the system, and document the implementation. Original improvements are encouraged but should not dominate the evaluation.

For project variants with maximum grades of **3/5, 4/5, and 5/5**, the rubric above is used to evaluate performance **within the selected variant**; it does not override that variant's maximum grade.
