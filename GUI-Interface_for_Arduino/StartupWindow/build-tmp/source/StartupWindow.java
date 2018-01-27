import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import controlP5.*; 
import processing.serial.*; 

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
float inpX, inpY, inpH, inpW; // input parameters

public void setup() {
	// initial size of the window
	

	// a line at 75% of the window
	atWidth = 0.75f * width;

	// set button parameters
	btnX = 0.80f * width;
	btnY = 0.80f * height;
	btnHeight = 0.15f * height;
	btnWidth = 0.15f * width;

	// set input parameters for input 1 : i.e. speed
	inpX = 0.80f * width;
	inpY = 0.20f * height;
	inpH = 0.15f * height;
	inpW = 0.15f * width;

	// make resizable window
	surface.setResizable(true);
	
	gui = new ControlP5(this); // gui controller which will add buttons, sliders etc

	createButton( (int) btnX, (int) btnY, (int) btnHeight, (int) btnWidth, gui);

	createInput("Speed", (int) inpX, (int) inpY, (int) inpH, (int) inpW, gui);

	createGraph1();
}

int x = 2, y = 3;

public void draw() {
	background(153);
	fill(0);
  	line(atWidth, 0, atWidth, height);
  	gui.setGraphics(this,0,0);
}
// For Creating GUI Controllers

// for creating a button
public void createButton(int btnX, int btnY, int btnHeight, int btnWidth, ControlP5 gui) {
	gui.addButton("Start")
	.setValue(1)
	.setPosition(btnX, btnY)
	.setSize(btnWidth, btnHeight);
} 

// for adding an input
public void createInput(String name, int inpX, int inpY, int inpH, int inpW, ControlP5 gui) {
	gui.addTextfield(name)
	.setPosition(inpX, inpY)
	.setSize(inpW, inpH);
}

Serial myPort;


PFont f;



public void createGraph1(){
rect(50,100,650,550);
for(int i=100;i<700;i+=50){
  stroke(220);
  line(50,i,700,i);
  fill(0);
  text(650-i,20,i);
  
}
for(int i=50;i<=700;i+=50){
   stroke(220);
  line(i,100,i,650);
  fill(0);
  text(i-50,i,665);
}

}




public void plot(float prev_x,float prev_y,float curr_x,float curr_y){
  stroke(0);
  float x1=map(prev_x,0,1000,50,700);
  float x2=map(curr_x,0,1000,50,700);
  float y1=map(prev_y,0,1000,650,100);
  float y2=map(curr_y,0,1000,650,100);
  
  beginShape();
  vertex(x1,y1);
  vertex(x2,y2);
  endShape();

}


//float data(){
//if(myPort.available()>0){

//}
//}
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
