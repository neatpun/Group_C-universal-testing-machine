#

# Development of Software Platform for UTM

# Software Requirements Specification

# 1.0

# 26/1/18

# Prathamesh Naik

# Sai Kumar Reddy

# Vishal Maurya

# Rahul Kumar

# Balmangaraj

#

Prepared for

CS 258 Software Engineering

Spring 2018

**Table of Contents**

1. Introduction        1

1.1 Purpose        1

1.2 Scope        1

1.3 Definitions, Acronyms, and Abbreviations        2

1.4 References        3

1.5 Overview        3

2. General Description        4

2.1 Product Perspective        4

2.2 Product Functions        4

2.3 User Characteristics        5

2.4 General Constraints        5

2.5 Assumptions and Dependencies        6

2.6 User Documentation        6

3. Specific Requirements        7

3.1 External Interface Requirements        7

3.1.1 User Interfaces        7

3.1.2 Hardware Interfaces        8

3.1.3 Software Interfaces        10

3.1.4 Communications Interfaces        10

3.2 Functional Requirements        11

3.2.1 To control the Universal Testing Machine.        11

3.2.2 Showing real time values of varying mechanical quantities.        11

3.2.3 Plotting graphs in real-time: load vs deformation and stress vs strain.        12

3.2.4 Exporting data to Excel file.        12

3.2.5 Printing graphs.        13

3.2.6 &quot;Smoothing&quot; of raw data from amplifier connected to load cell sensor.        13

3.3 Non-Functional Requirements        14

3.3.1 Performance        14

3.3.2 Reliability        14

3.3.3 Availability        14

3.3.4 Security        14

3.3.5 Maintainability        14

3.3.6 Portability        14

3.5 Design Constraints        14

3.5.1 Operating system        14

3.5.2 Software platform        14

3.5.3 Microcontroller        14

3.5.4 Hardware components        14

# 1. Introduction

## 1.1 Purpose

The purpose of this document is to present a detailed description of the software system/platform for Universal Testing Machine (UTM). It will explain the purpose, functionalities and features of the system, the interfaces of the system, what the system will do and the constraints under which it must operate. This document is intended for both the stakeholders and the developers of the system.

**1.2 Scope**

This software system will be a software platform for a custom made Universal Testing Machine. This system will be designed to maximize the researcher&#39;s productivity by providing tools to assist in automating the material testing process. Specifically, it&#39;ll be used to find out the mechanical properties of polyimide sheets with and without SMA (shape memory alloy) coating. The system will meet the user&#39;s needs while remaining easy to understand and use.

More specifically, this system is designed to

1. Allow a user to control the Universal Testing Machine. Users will be able to specify speed and no. of cycles as well as control the motion of motor (which involves pausing it, restarting it and controlling direction) through GUI.

2. Get data output from the UTM, process it and run calculations on it, then show the useful information to the user, in the form of Graph or Excel file.

This software will facilitate communication between Universal Testing Machine (the electrical components include Arduino, Load Cell and Gear Motor) and the PC with which it is connected through USB cable. The main objective of this software is to get values of stress on the polyimide sheet for different values of strain when it is elongated in the universal testing machine. This process will be repeated for a user specified no. of cycles.

The output will be shown to the user in the form of graph or excel file. Based on the data received from UTM, certain mechanical properties of UTM would also be calculated and shown to the user.

This software will also show real-time data output while the UTM is running.

## 1.3 Definitions, Acronyms, and Abbreviations

| **Term** | **Definition** |
| --- | --- |
| **UTM** | A universal testing machine (UTM), also known as a universal tester, materials testing machine or materials test frame, is used to test the tensile strength and compressive strength of materials. The &quot;universal&quot; part of the name reflects that it can perform many standard tensile and compression tests on materials, components, and structures (in other words, that it is versatile).In this project, we&#39;ll be working on a custom UTM which was made to test properties of polyimide sheets with and without SMA coating. |
| **SMA** | A shape-memory alloy (SMA) is an alloy that &quot;remembers&quot; its original shape and that when deformed returns to its pre-deformed shape when heated. |
| **GUI** | The graphical user interface (GUI), is a type of user interface that allows users to interact with electronic devices through graphical icons and visual indicators such as secondary notation, instead of text-based user interfaces, typed command labels or text navigation. |
| **Strain** | Strain is the relative change in shape or size of an object due to externally-applied forces. |
| **Stress** | Stress is the associated force (per unit area) associated with a strain. |
| **Arduino** | Arduino is an open-source platform used for building electronics projects. Arduino consists of both a physical programmable circuit board (often referred to as a microcontroller) and a piece of software, or IDE (Integrated Development Environment) is used to write and upload computer code to the physical board.In this project we will be working on Arduino Uno which is one the variants of Arduino microcontrollers. |
| **Load cell** | A load cell is a transducer that is used to create an electrical signal whose magnitude is directly proportional to the force being measured. |
| **Amplifier** | An amplifier is an electronic device that increases the voltage, current, or power of a signal.It&#39;ll be used for amplifying the output voltage of load cell to make it noticeable to the Arduino. |
| **Gear motor** | A geared DC Motor has a gear assembly attached to the motor. It&#39;s speed can be controlled. |
| **Motor controller/driver** | A Motor Controller is a device that acts as intermediary between a machine&#39;s microcontroller, batteries and motors. |

## 1.4 References

Most of the definitions were adapted from Wikipedia entries of respective terms.

This SRS is based on following templates / examples:

1.The template Abhishek Srivastava Sir sent us.

2.IEEE Recommended Practice for Software Requirements template

3. SRS example from Michigan State University.

## 1.5 Overview

# The rest of the SRS document is divided into four main parts: -

**1. General Description**

This section gives an overview of the functionality of the product. It describes the informal requirements and is used to establish a context for the technical requirements specification in the next section.

**2. Specific Requirements**

This section describes in technical terms the details of the functionality of the product.There are 4 subsections:

**i. External Interface Requirements**

A brief overview of the hardware, software and interface requirements is provided.

**ii. Functional Requirements**

This section describes specific features related to the basic functions of this software.

**iii. Non-Functional Requirements**

This section describes the characteristics of the system. That includes performance, reliability, portability etc.



# 2. General Description

## 2.1 Product Perspective

 This software will interface a PC with a custom Universal Testing Machine through Arduino. There are two parts to it: the code that will run on PC and code that will run on Arduino. This software will be designed in an open source platform, processing. The client interacts with the software&#39;s GUI where he/she inputs the data. The software will control the motor in UTM as well as take sensor outputs from Arduino, run calculations on it to convert it to stress and strain values and then will show the real-time output to user. Based on the output the user can study the mechanical properties of the polyimide sheet.

## 2.2 Product Functions

(Note: Technical details are given in section 3.)

- To control the UTM

                Users will control the UTM as per their needs through GUI of this software platform. This includes starting and stopping the motor, setting custom speed and no. of cycles, as well as changing direction of the motor.

- To show real time output relating to mechanical properties of polyimide sheet being tested

                This software will show the value of load and the stress developed in the material as the strain changes due to deformation caused by motion of the motor. Output will also be shown visually in the form of a graph.

- To export the results after testing is finished

                After testing has been finished, users will be able to get an excel file with all the captured and processed data.

## 2.3 User Characteristics

 There is only one class of users who will use this software: researchers studying mechanical properties of polyimide sheets. All the features and functions of this software pertain to them.

 They will be knowledgeable about all the relevant mechanical properties that the software will show them. They will also decide on the testing procedure.

 The GUI will be made self-explanatory so that effective testing may be carried out as per their requirements.

 The software will be made such that knowledge of electrical components involved including the control circuit and the microcontroller will not be required in order to use it.

## 2.4 General Constraints

 The general constraints on this application software include: -

** 1. Fast Response Time:**

 The software should be able to keep up with Arduino output and should also be able to give instructions to Arduino quickly.

** 2. User Friendly Interface:**

 The GUI should be user friendly and self-explanatory enough so that researchers should be able to use test polyimide sheets as per their requirement.

** 3. Easy installation and software portability**

 The software should run on Microsoft windows platform and any researcher wanting to use the UTM should be able to install the software on their PC with relative ease.

** 4. Hardware constraints**

 The software should interface well with the custom UTM. This means it should communicate with the Arduino which will control the motor using a motor controller, as well as get the sensor outputs such as force values from the load cell and amplifier. The Arduino code is part of the software platform.

## 2.5 Assumptions and Dependencies

 This software will be created using the &quot;Processing&quot; platform (an open-source computer programming language and integrated development environment).

 It will have multiple dependencies such as external libraries which have not been completely determined yet.

 It&#39;ll be assumed that the UTM is in proper physical state and available with user.

 Further, it is dependent on multiple electrical components such as the Arduino, Load cell, Amplifier, Motor, Motor Controller, Power supply. It&#39;ll be assumed that all of them are working properly and that the circuit connections are properly made.

 Users are assumed to use the Microsoft Windows operating system. Further it is assumed that a USB cable can be used to connect their PC and the UTM (more specifically, the Arduino part).

## 2.6 User Documentation

A user manuals and a tutorial will be delivered along with the software.

# 3. Specific Requirements

## 3.1 External Interface Requirements

### 3.1.1 User Interfaces

User Interface will consist of a window which will display:

                        **3.1.1.1 Real-time values of varying mechanical quantities.**

This will include stress, strain, load and deformation of the polyimide sheet.

**3.1.1.2 A Graph between Tensile Stress and Strain**

**                        3.1.1.3 A Graph between Load And Deformation**

                                        Both of them should update in real-time.

It will also consist of the following options:

                        **3.1.1.4 Various input options for all required details.**

This will include speed of the motor, length, thickness and other relevant properties of the polyimide sheet, no. of cycles to test for etc.

                        **3.1.1.5 Buttons to control the motor**

There will be a start button, a pause button and a change direction button in case the user wants manual control of the motor.

                        **3.1.1.6 Option to export the data to an excel file once the testing has finished.**

**                       **

**                        3.1.1.7 Option to print the graph.**

### 3.1.2 Hardware Interfaces

 ![](data:image/*;base64,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5EyEL8/OTBB55pWoIFAKAeawUjI9Pk5EznhGxbVYtWqVmZmZKS5uAoYABPIgwByWRx5DRIHICUExszGWL19udu3aZZYtW5ZZZIQDAQjkTuDAgQNm/fr1Zv/+/bmHSnwNCCByGkAqrckVV1xhVqxYYaanp0sLnXghAIHECezcudPs27fP7NixI/FIcD8EAUROCIqZjXHPPfeYubk5s23btswiIxwIQCB3Aps2bTJLliwxGzZsyD1U4mtAAJHTAFKJTd761rean/3sZ+Ytb3lLieETMwQgkCCBX/ziF2bx4sXm5z//eYLe43IXBBA5XVDNYMzHHnvMfOELXzB79+7NIBpCgAAESiBw7rnnms2bN5vVq1eXEC4xNiCAyGkAqdQmN9xwg3n99dfN9u3bS0VA3BCAQCIERNy87W1vM1u3bk3EY9zUIIDI0aCcsI3rr7/eHDp0yOzevdscffTRCUeC6xCAQI4E5BbVxRdfbM466ywETo4JnjAmRM6EAEvo/vjjj5s1a9aYK6+80ixdutScccYZRo6Z84EABCDQBwE5Ji5HxA8ePGjuu+8+88gjj3CLqo9EJGATkZNAkmJx8d57760mFvnv7W9/u5mdnY3FNfyAAAQKITA1NWV++tOfVn9snXnmmeYTn/hEIZETZhsCiJw21OgDAQhAAAIQgED0BBA50acIByEAAQhAAAIQaEMAkdOGGn0gAAEIQAACEIieACIn+hThIAQgAAEIQAACbQggctpQow8EIAABCEAAAtETQOREnyIchAAEIAABCECgDQFEThtq9IEABCAAAQhAIHoCiJzoU4SDEIAABCAAAQi0IYDIaUONPhCAAAQgAAEIRE8AkRN9inCwawKrVq0yMzMzXZthfAhMTEBqtc2TxuUpwW378d2YOG0M0CMBRE6P8DHdP4GTTz7ZfOlLXzJr1641c3Nz/TuEBxAYQWDRokXm8OHDaoy07akFhqFiCCByikk1gdYJyF/FN910k5G/cp9++unq/7f5axeyENAioC06tO1pccROOQQQOeXkmkgdAtPT02blypVm3bp18z994IEHqttW999/P6wgECUBbdGhbS9K6DiVNAFETtLpw/k2BG655ZZqyf/mm28+ovuo37WxRR8IhCSgLTq07YVkxVgQEAKIHOqgKAJNVmsGrfIUBYlgoyWgLTq07UULHseSJYDISTZ1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)

While the Universal Testing Machine is working, the communication between various hardware components will be frequent (multiple messages per second).

**3.1.2.1 PC &lt;=&gt; Arduino**

The software on PC will interface with an Arduino Uno microcontroller using a USB cable.

This will involve serial communication, i.e., sending data one bit at a time, sequentially.

The software on PC will send control instructions to Arduino which the code on Arduino (which is also part of the software platform) will receive. These control instructions will predominantly involve instruction relating to control the motor.

The Arduino part of the software platform (i.e. the code running on Arduino) will collect information from sensor (Load cell) at a certain frequency and send it to the software running on PC.

This process will happen approximately thrice per second.

**3.1.2.2 Arduino =&gt; Motor Controller =&gt;Motor**

Based on instruction received from the software on PC, the code on Arduino will appropriately control the motor using the motor controller. This will involve communication method specific to the motor controller. The motor controller has not been completely decided yet, so this section of the SRS will be updated later.

The motor controller will then control the motor behavior accordingly.

This process will happen multiple times per second. The exact frequency would depend on type of testing.

**3.1.2.3 Arduino &lt;= Amplifier &lt;= Load cell**

The load cell will generate a voltage proportion to the force applied on the polyimide sheet. However, this voltage is very small so it will be amplified before being fed into the Arduino. The Arduino has an analog input pin which can read voltages from 0 to 5 V, it&#39;ll be used to read the voltage from the amplifier. The Arduino code will then do a process known as &quot;smoothing&quot; (which reduces the influence of random noise) before transmitting these values to PC.

This process will happen approximately thrice per second.

### 3.1.3 Software Interfaces

**3.1.3.1 Processing 3.3.6**

Processing is a Java based programming language and Integrated Development environment(IDE) which will be used for the development of software platform for Universal Testing Machine(UTM).

Processing will be used to create the GUI as well as to interface with Arduino.

In the process of development, many Processing libraries could be used. This section of SRS will be kept updated each time a new library is used or if a library has been removed.

**3.1.3.2 Arduino Integrated Development environment (IDE)**

It will be used to write code and upload it to the Arduino Uno board. The Arduino programing language is based on c/c++.

### 3.1.4 Communications Interfaces

No communication interface is required by this product.



## 3.2 Functional Requirements

**3.2.1 To control the Universal Testing Machine**

_3.2.1.1 Introduction_

This will involve controlling the motor. Then the elongation and compression of polyimide sheet can be controlled.

_3.2.1.2 Inputs_

Users will have to specify inputs such as custom speed input and no. of cycles or manually use options such as start, pause and change direction.

_3.2.1.3 Processing_

Based on User input, the PC part of the software will send appropriate instructions to Arduino part of the software. The code on Arduino will interpret these instructions and transmit corresponding control commands to motor controller. Finally, the motor controller will control and drive the motor.

_3.2.1.5 Error Handling_

It does not seem possible to detect errors in behavior of motor at runtime, since the motor only takes instructions and does not respond back. Thus extensive testing would have to be done to ensure motor is behaving appropriately to all situations and commands.

**3.2.2 Showing real time values of varying mechanical quantities**

_3.2.2.1 Introduction_

These quantities include stress, strain, load and deformation of the polyimide sheet. Due to the motor, the polyimide sheet will be elongated and compressed (deformation). This strain on the sheet will have a corresponding stress which is what we&#39;re interested in.

This stress can be calculated knowing the load and area of sheet. The load on the sheet will be measured by load cell. the load cell will generate a voltage proportion to the force applied on the polyimide sheet. However, this voltage is very small so it will be amplified before being fed into the Arduino.

_3.2.2.2 Inputs_

Users will start testing by first specifying motor control options as given in 3.2.1.

The Arduino has an analog input pin which can read voltages from 0 to 5 V, it&#39;ll be used to read the voltage from the amplifier connected to the load cell.

_3.2.2.3 Processing_

The Arduino code will then do a process known as &quot;smoothing&quot; (which reduces the influence of random noise) before transmitting these values to PC. The PC software will interpolate the force on object based on the voltage reading by Arduino. Then the PC software will calculate stress from force and area using a formula. The strain will be calculated from the position of motor, which itself will be calculated using time elapsed, speed of motor and period or frequency of cycles.

_3.2.2.4 Outputs_

The real time stress and strain values will be shown to the user, along with the load and deformation values.

_3.2.2.5 Error Handling_

If there is any sudden decrease in stress, that might indicate the polyimide sheet has broken. In that case the motor will be temporarily stopped and User will be notified to decide on the next action.

**3.2.3 Plotting graphs in real-time: load vs deformation and stress vs strain**

_3.2.3.1 Introduction_

Based on the values obtained each instant (as described in 3.2.2), a new vertex will be added to the graph and it will be updated.

_3.2.3.2 Inputs_

The inputs will be the real-time values of various mechanical quantities, which will be calculated as described in 3.2.2.

_3.2.3.3 Processing_

Each instant a new vertex will be added to graph (based on the corresponding values of the mechanical quantities) and it&#39;ll connected to the previous one through a curve.

_3.2.3.4 Outputs_

Two continuously updating graphs will be shown to the user.

**3.2.4 Exporting data to Excel file**

_3.2.4.1 Introduction_

After testing has been finished, users will be able to get an excel file with all the captured and processed data.

_3.2.4.2 Inputs_

Users will click on a button for exporting data.

_3.2.4.3 Processing_

Data will be written to an Excel file.

_3.2.4.4 Outputs_

After it is ready, users will be notified that the Excel file has been created.

**3.2.5 Printing graphs**

_3.2.5.1 Introduction_

After testing has been finished, users will be able to print the graphs obtained.

_3.2.5.2 Inputs_

Users will click on a button for printing graphs.

_3.2.5.3 Processing_

Data will be written to a file such as a PDF or a JPEG. (To be determined). Then a print command would be sent to printer.

_3.2.5.4 Outputs_

Printer will print the graph. The file containing the graph will also be available for users.

**3.2.6 &quot;Smoothing&quot; of raw data from amplifier connected to load cell sensor.**

_3.2.6.1 Introduction_

The voltage read by Arduino from amplifier connected to load cell has a lot of random noise. To fix this problem, Arduino code will do a process called &quot;Smoothing&quot; before sending voltage reading to PC software.

_3.2.6.2 Inputs_

The Arduino has an analog input pin which can read voltages from 0 to 5 V, it&#39;ll be used to read the voltage from the amplifier connected to the load cell.

_3.2.6.3 Processing_

Smoothing involves taking average of multiple data points. So for example if a voltage reading is required every 100 ms, Arduino will be coded to actually take 10 readings separated by 10 ms and then average them. This process results in most of the random noise in sensor data cancelling out.

_3.2.6.4 Outputs_

The Arduino code will send the processed data (voltage readings) to the PC software.

## 3.3 Non-Functional Requirements

### 3.3.1 Performance

Performance of the software is not a big concern since no heavy processing is done. However, the motor and load cell, amplifier and motor driver should have appropriate resolution and response time.

### 3.3.2 Reliability

Since the UTM will be used for research, reliably getting correct results is important. While testing can make sure the software is bug free, it will be important to periodically check that hardware components such as the load cell sensor are working properly and giving correct output.

### 3.3.3 Availability

The software will be used by users with PCs having a wide variety of hardware configuration. Thus the software should work on PCs with the windows operating system and any hardware configuration.

### 3.3.4 Security

Since physical access to UTM will be required for using the software, security is not an issue.

### 3.3.5 Maintainability

The hardware components in the UTM can be changed later for any reason. Thus the software should be such that minimal amount of code (only the code interfacing with the hardware) needs to be changed if that happens.

### 3.3.6 Portability

Any user with a windows PC should be able to install this software and connect to the UTM.

## 3.4 Design Constraints

**3.4.1** Operating system: Windows

**3.4.2** Software should be made using the &quot;Processing&quot; platform (see 3.1.3.1)

**3.4.3** Arduino Uno as the microcontroller. The coding for it would be done using the Arduino IDE. (see 3.1.3.2)

**3.4.4** Arduino Uno will be required to interface with specific motor controller, motor, amplifier and load cell. The models are not yet completely fixed and this constraint will be updated later.