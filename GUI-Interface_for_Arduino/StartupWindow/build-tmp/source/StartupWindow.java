import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import controlP5.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class StartupWindow extends PApplet {

// Startup Window For Universal Testing Machine
 // using ControlP5 library for building the gui

ControlP5 gui; // variable for controlling gui components
float atWidth; // at which a line will appear
float btnX, btnY, btnHeight, btnWidth; // button parameters

public void setup() {
	// initial size of the window
	

	// a line at 75% of the window
	atWidth = 0.75f * width;

	// set button coordinates
	btnX = 0.80f * width;
	btnY = 0.80f * height;
	btnHeight = 0.15f * height;
	btnWidth = 0.15f * width;

	// make resizable window
	surface.setResizable(true);
	
	gui = new ControlP5(this); // gui controller which will add buttons, sliders etc
	gui.addButton("Start", 1, (int) btnX, (int) btnY, (int) btnWidth, (int) btnHeight);
}


public void draw() {
	background(153);
  	line(atWidth, 0, atWidth, height);
}
  public void settings() { 	size(800,400); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "StartupWindow" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
