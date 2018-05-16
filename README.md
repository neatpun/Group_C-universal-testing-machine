
# Group_C-universal-testing-machine
Software for controlling a custom universal testing machine designed for testing polyimide  sheets with and without SMA (shape memory alloy) coating.

You can see the [Presentation](https://github.com/neatpun/Group_C-universal-testing-machine/tree/master/Presentation%20%26%20demo%20videos) to know more about the project.

## Demo
### Software interface
![GUI demonstration GIF](https://raw.githubusercontent.com/neatpun/Group_C-universal-testing-machine/master/Presentation%20%26%20demo%20videos/GIF%20(for%20readme)/Software-demo.gif)
### UTM cycle control
See [this](https://github.com/neatpun/Group_C-universal-testing-machine/blob/master/Presentation%20%26%20demo%20videos/UTM%20cycle%20control%20demo.mp4) video.

## Installation instructions
For 64 bit windows, download this [release](https://github.com/neatpun/Group_C-universal-testing-machine/releases/tag/v3).
For other platforms:

 1. Get [Processing](https://processing.org/download/) 
 2. Download the 'Code' folder. 
 3. Inside the 'Processing' subfolder, open gui.pde with
    Processing. 
 4. Now you can run it as well as export it (File>Export application).

## Configuration Instructions
### 2.1 Before you start...
This software will facilitate communication between Universal Testing Machine (the electrical components include Arduino, Load Cell and Gear Motor) and the PC.
So first of all, make sure that the UTM itself is ready:
● Check that the load cell is in place and connected to amplifier
● Check that the gear motor is in place and connected to motor controller
● Check that both the amplifier and motor controller are connected to the Arduino
After ensuring this, connect the Arduino to PC using an USB cable.
Then, simply double click on the exe file to start the software.
### 2.2 A note about simulation mode
If you don’t have the UTM or Arduino with you, it is still possible to use the software. The software has a built in simulation mode, that simulates motor position using a slider and generates load cell values that approximate the expected real life behavior of load cell.   

The values generated also have some randomness, so every time you use the software in simulation mode, they will be different.

The simulation mode was mainly meant to be used for testing by developers, but you can play around with it. You can do everything with the simulation mode that can you do with the UTM connected. So you can follow all instructions in the user manual using the simulation mode.

**Please see the [**User Manual**](https://github.com/neatpun/Group_C-universal-testing-machine/tree/master/User%20Manual) for usage instructions.**


This project was done by Prathamesh (me), Sai Kumar, Rahul and Vishal.