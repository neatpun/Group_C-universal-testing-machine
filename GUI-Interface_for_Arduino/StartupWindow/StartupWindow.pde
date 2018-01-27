//import processing.serial.*;
//Serial myPort;


void setup(){
size(1000,700);
line(750,0,750,700);
createGraph1();
noLoop();
String portName = Serial.list()[0];
 myPort = new Serial(this, portName, 9600);

}


void draw(){

plot_graph();

  
  
}