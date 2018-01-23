/**
 * Simple Read
 * 
 * Read data from the serial port and change the color of a rectangle
 * when a switch connected to a Wiring or Arduino board is pressed and released.
 * This example works with the Wiring / Arduino program that follows below.
 */


import processing.serial.*;

Serial myPort;  // Create object from Serial class
String val="000";      // Data received from the serial port
/**
 * Words. 
 * 
 * The text() function is used for writing words to the screen.
 * The letters can be aligned left, center, or right with the 
 * textAlign() function. 
 */
  
PFont f;
  
void setup() {
  size(640, 360);
  
  // Create the font
  //printArray(PFont.list());
  f = createFont("SourceCodePro-Regular.ttf", 24);
  textFont(f);
    String portName = Serial.list()[0];
 myPort = new Serial(this, portName, 9600);
}

void draw() {
  
  if ( myPort.available() > 0) {  // If data is available,
    val = myPort.readStringUntil('\n');         // read it and store it in val
  }
println(val); //print it out in the console

  background(102);
  textAlign(RIGHT);
  fill(0);
  text(val, width*0.75, 95);
  
  myPort.clear();
  delay(300);
  
}