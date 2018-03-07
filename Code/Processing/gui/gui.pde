
 
 
 import processing.serial.*;

import cc.arduino.*;

Arduino arduino;


import controlP5.*;
import java.util.*;

ControlP5 cp5;

int myColor = color(255);

int c1,c2;

float n,n1;



void setup() {
  
  size(800,600);
  noStroke();
  
  println(Arduino.list());
  arduino = new Arduino(this, Arduino.list()[0], 57600);
  // arduino.analogWrite(9, constrain(mouseX / 2, 0, 255));
  //arduino.pinMode(i, Arduino.OUTPUT);
  //    arduino.pinMode(i, Arduino.INPUT);
  //arduino.analogRead(i)
  // arduino.digitalWrite(pin, Arduino.HIGH);
  cp5 = new ControlP5(this);
  
 add_controls();
     

     
       //PFont font = createFont("arial",20);

  

                 
  //cp5.addTextfield("cycles_input")
  //   .setPosition(20,170)
  //   .setSize(200,40)
  //   .setFont(createFont("arial",20))
  //   .setAutoClear(false)
  //   ;
       

  

hide_controls();
     
  //textFont(font);
     
     
     

}


void draw() {
  background(250,180,220);
  myColor = lerpColor(c1,c2,n);
  n += (1-n)* 0.1; 
  
  
  fill(255);

  //text(0, 360,180);
}
void dropdown(int n) {

  hide_controls();
  if(n==0)
  {cp5.getController("up").show();
cp5.getController("pause").show();
cp5.getController("down").show();}
  else if(n==1)
  {cp5.getController("run").show();
cp5.getController("pause cycles").show();}


  
}

public void run() {
  cp5.get(Textfield.class,"cycles_input").clear();
}

// function colorA will receive changes from 
// controller with name colorA
public void resume() {
  println("a button event from colorA: ");
  c1 = c2;
  c2 = color(0,160,100);
  delay(1000);
}

// function colorB will receive changes from 
// controller with name colorB
public void pause() {
  println("a button event from colorB: ");
  c1 = c2;
  c2 = color(150,0,0);
}

// function colorC will receive changes from 
// controller with name colorC
public void change_direction() {
  println("a button event from colorC: ");
  c1 = c2;
  c2 = color(255,255,0);
}






void hide_controls()

{cp5.getController("up").hide();
cp5.getController("down").hide();
cp5.getController("pause").hide();

cp5.getController("run").hide();
cp5.getController("pause cycles").hide();}

void add_controls()
{ // Top controls
   cp5.addBang("reset")
     .setPosition(500,20)
     .setSize(60,19)
     .getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER)

     ;
     
     
       List l = Arrays.asList("Manual", "Cycles");

  cp5.addScrollableList("dropdown")
     .setPosition(590, 20)
     .setSize(200, 100)
     .setBarHeight(20)
     .setItemHeight(20)
     .addItems(l)
     // .setType(ScrollableList.LIST) // currently supported DROPDOWN and LIST
     ;
  
  
  
  //Manual controls
  cp5.addBang("up")

     .setPosition(500,100)
     .setSize(200,19)
     .getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER)
     ;
  
  cp5.addBang("pause")

     .setPosition(500,120)
     .setSize(200,19)
     .getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER)
     ;
     
  cp5.addBang("down")
     .setPosition(500,140)
     .setSize(200,19)
     .getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER)

     ;
     
     //Cycle Controls
     
       cp5.addBang("run")

     .setPosition(500,100)
     .setSize(200,19)
     .getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER)
     ;
  

  cp5.addBang("pause cycles")

     .setPosition(500,120)
     .setSize(200,19)
     .setCaptionLabel("Pause")
     .getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER)
     //.toUpperCase(false)
     ;}