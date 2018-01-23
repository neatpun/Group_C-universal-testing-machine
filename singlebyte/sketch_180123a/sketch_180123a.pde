import processing.serial.*;
Serial myPort;

// at the top of the program:
float xPos = 0; // horizontal position of the graph
float yPos = 0; // vertical position of the graph

//// change the number below to match your port:





void setup () {
  size(800, 600);        // window size
 
  // List all the available serial ports
  
    // List all the available serial ports
    // if using Processing 2.1 or later, use Serial.printArray() ->wrong usage?
   // println(Serial.list());
 printArray(Serial.list());
  background(#081640);
  
  String portName = Serial.list()[0];

myPort = new Serial(this, portName, 9600);
}


void draw () {
   // draw the line in a pretty color:
  stroke(#A8D9A7);
  line(xPos, height, xPos, yPos);
  
  // at the edge of the screen, go back to the beginning:
  if (xPos >= width) {
    xPos = 0;
    // clear the screen by resetting the background:
    background(#081640);
  } else {
    // increment the horizontal position for the next reading:
    xPos++;
  }
}
void serialEvent (Serial myPort) {
  // get the byte:
  int inByte = myPort.read();
  // print it:
  println(inByte);
  yPos = height - inByte;
}