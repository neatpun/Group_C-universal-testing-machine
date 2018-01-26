// Startup Window For Universal Testing Machine
import controlP5.*; // using ControlP5 library for building the gui

ControlP5 gui; // variable for controlling gui components
float atWidth; // at which a line will appear
float btnX, btnY, btnHeight, btnWidth; // button parameters

void setup() {
	// initial size of the window
	size(800,400);

	// a line at 75% of the window
	atWidth = 0.75 * width;

	// set button coordinates
	btnX = 0.80 * width;
	btnY = 0.80 * height;
	btnHeight = 0.15 * height;
	btnWidth = 0.15 * width;

	// make resizable window
	surface.setResizable(true);
	
	gui = new ControlP5(this); // gui controller which will add buttons, sliders etc
	gui.addButton("Start", 1, (int) btnX, (int) btnY, (int) btnWidth, (int) btnHeight);
}


void draw() {
	background(153);
  	line(atWidth, 0, atWidth, height);
}