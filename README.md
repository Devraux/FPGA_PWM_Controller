# PWM Controller for ZedBoard (Zynq FPGA)

This project implements a PWM controller on the ZedBoard using Zynq FPGA. It supports 4 PWM channels with adjustable duty cycle, mode (edge or center-aligned), and polarity.

## Features
- **4 PWM Channels** with independent settings
- **Duty Cycle**: Adjustable from 0% to 90% via button press
- **PWM Modes**: Edge-aligned and center-aligned
- **Polarity Control**: Invert PWM signal polarity
- **Debounced Inputs** for stable button presses

## Modules
- **clk_prescaler**: Divides input clock (100MHz) to 50Hz.
- **counter**: 10-bit counter for PWM timing.
- **debouncer**: Debounces button inputs.
- **PWM_duty_btn**: Adjusts PWM duty cycle.
- **PWM_mode_btn**: Toggles between edge/center mode.
- **PWM_Controller**: Generates PWM signal based on duty cycle, mode, and polarity.

## Pin Configuration

| Pin                | Function            | Description                           |
|--------------------|---------------------|---------------------------------------|
| `clk_in`           | Input clock         | 100 MHz clock                         |
| `reset_btn`        | Reset button        | Resets the system                     |
| `duty_btn`         | Duty cycle button   | Increments the duty cycle             |
| `low_hightrueBtn`  | Polarity button     | Toggles PWM polarity                 |
| `edge_centerModeBtn` | Mode button        | Toggles PWM mode (Edge/Center)        |
| `channel_select`   | Channel selector    | Selects PWM channel (4 channels)      |
| `PWM0`, `PWM1`, `PWM2`, `PWM3` | PWM outputs | PWM signals for each channel         |

## How to Use
1. **Channel Selection**: Use `channel_select` to choose the PWM channel.
2. **Duty Cycle**: Press `duty_btn` to increase duty cycle (0% to 90%).
3. **Mode Control**: Toggle PWM mode using `edge_centerModeBtn`.
4. **Polarity**: Change PWM polarity with `low_hightrueBtn`.
5. **Reset**: Press `reset_btn` to reset all settings.

## Installation
1. Create a Vivado project and add the Verilog files.
2. Set up pin constraints in the `.xdc` file.
3. Compile and upload to ZedBoard.
4. Test PWM output on the selected channels.

## PFGA schematic
![Image](https://github.com/user-attachments/assets/dfab7cfa-91ae-4996-b83c-aab01d73b7f5)
