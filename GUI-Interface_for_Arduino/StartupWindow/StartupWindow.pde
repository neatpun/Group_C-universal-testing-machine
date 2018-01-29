//import processing.serial.*;
//Serial myPort;
// Startup Window For Universal Testing Machine
import controlP5.*; // using ControlP5 library for building the gui

ControlP5 gui; // variable for controlling gui components
float atWidth; // at which a line will appear
float btnX, btnY, btnHeight, btnWidth; // button parameters
float inpX, inpY, inpH, inpW, colorCode; // input parameters

void setup() {

  createGraph1();
  noLoop();
  String portName = Serial.list()[0];
  myPort = new Serial(this, portName, 9600);
  // initial size of the window
  size(1000, 700);
  // a line at 75% of the window
  atWidth = 0.75 * width;

  // set button parameters
  btnX = 0.80 * width;
  btnY = 0.80 * height;
  btnHeight = 0.15 * height;
  btnWidth = 0.15 * width;

  // set input parameters for input 1 : i.e. speed
  inpX = 0.80 * width;
  inpY = 0.20 * height;
  inpH = 0.06 * height;
  inpW = 0.15 * width;
  colorCode = 255;

  gui = new ControlP5(this); // gui controller which will add buttons, sliders etc

  createButton("Start", (int) btnX, (int) btnY, (int) btnHeight, (int) btnWidth, gui);

  createInput("Speed", (int) inpX, (int) inpY, (int) inpH, (int) inpW, (int) colorCode, gui);

  inpY = 0.31 * height;

  createInput("Length", (int) inpX, (int) inpY, (int) inpH, (int) inpW, (int) colorCode, gui);

  inpY = 0.42 * height;

  createInput("Breadth", (int) inpX, (int) inpY, (int) inpH, (int) inpW, (int) colorCode, gui);
}

void draw() {
  fill(0);
  line(atWidth, 0, atWidth, height);
  gui.setGraphics(this, 0, 0);
  plot_graph();
}