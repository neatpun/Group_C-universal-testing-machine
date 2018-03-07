
 
 
 import processing.serial.*;

import cc.arduino.*;

Arduino arduino;


import controlP5.*;
import java.util.*;

ControlP5 cp5;

int myColor = color(255);

int c1,c2;

float n,n1;

//float f1,f2;

void setup() {
  //displayWidth  displayHeight 
  //f1=displayWidth/1024.0/2;
  
  //f2=displayHeight/768.0/2;

  
  
  size(800,600);
  //surface.setResizable(true);
  //surface.setSize(int(800*f1),int(600*f2));
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
     
     add_inputs();
     add_live_panel();



  

hide_controls();
     
     
  

                 




}


void draw() {
  background(0,0,0);


}




//CONTROL EVENTS

void choose_mode(int n) {

  hide_controls();
  if(n==0)
  {cp5.getController("up").show();
cp5.getController("pause").show();
cp5.getController("down").show();}
  else if(n==1)
  {cp5.getController("run").show();
cp5.getController("pause_cycles").show();}


  
}

public void fix_input() {
  lock_all();
}









//HELPER FUNCTIONS
void add_live_panel()
{
  
  //https://forum.processing.org/two/discussion/24244/controlp5-textfield-background-colour
  
     cp5.addTextfield("distance")
     .setPosition(600,350)
     .setSize(50,20)
     .setFont(createFont("arial",15))
     .setAutoClear(false)
     .setCaptionLabel("Distance:")
     .getCaptionLabel()
     .toUpperCase(false)
     .align(ControlP5.LEFT_OUTSIDE, CENTER)
  
     .setFont(createFont("arial",15))
     .getStyle().setPaddingLeft(-10);
     
     
     
     cp5.addTextfield("load")
     .setPosition(725,350)
     .setSize(50,20)
     .setFont(createFont("arial",15))
     .setAutoClear(false)
     .setCaptionLabel("Load:")
     .getCaptionLabel()
     .toUpperCase(false)
     .align(ControlP5.LEFT_OUTSIDE, CENTER)
  
     .setFont(createFont("arial",15))
     .getStyle().setPaddingLeft(-10);
     
     
     
      cp5.addTextfield("strain")
     .setPosition(600,400)
     .setSize(50,20)
     .setFont(createFont("arial",15))
     .setAutoClear(false)
     .setCaptionLabel("Strain:")
     .getCaptionLabel()
     .toUpperCase(false)
     .align(ControlP5.LEFT_OUTSIDE, CENTER)
  
     .setFont(createFont("arial",15))
     .getStyle().setPaddingLeft(-10);
     
     
     
     cp5.addTextfield("stress")
     .setPosition(725,400)
     .setSize(50,20)
     .setFont(createFont("arial",15))
     .setAutoClear(false)
     .setCaptionLabel("Stress:")
     .getCaptionLabel()
     .toUpperCase(false)
     .align(ControlP5.LEFT_OUTSIDE, CENTER)
  
     .setFont(createFont("arial",15))
     .getStyle().setPaddingLeft(-10);
     
     
     
     
     
     cp5.get(Textfield.class,"distance").lock();
cp5.get(Textfield.class,"load").lock();
cp5.get(Textfield.class,"strain").lock();
cp5.get(Textfield.class,"stress").lock();




     cp5.get(Textfield.class,"distance").setColorBackground(0xfffaddff);// 0xff followed by hex value of color
cp5.get(Textfield.class,"load").setColorBackground(0xfffaddff);
cp5.get(Textfield.class,"strain").setColorBackground(0xfffaddff);
cp5.get(Textfield.class,"stress").setColorBackground(0xfffaddff);


  cp5.get(Textfield.class,"distance").setColorValue(0xff000000);// 0xff followed by hex value of color
cp5.get(Textfield.class,"load").setColorValue(0xff000000);
cp5.get(Textfield.class,"strain").setColorValue(0xff000000);
cp5.get(Textfield.class,"stress").setColorValue(0xff000000);


     cp5.get(Textfield.class,"distance").setValue(String.valueOf(0.0));
cp5.get(Textfield.class,"load").setValue(String.valueOf(0.0));
cp5.get(Textfield.class,"strain").setValue(String.valueOf(0.0));
cp5.get(Textfield.class,"stress").setValue(String.valueOf(0.0));


  
}


void hide_controls()

{cp5.getController("up").hide();
cp5.getController("down").hide();
cp5.getController("pause").hide();

cp5.getController("run").hide();
cp5.getController("pause_cycles").hide();}

void add_controls()
{ // Top controls
   cp5.addBang("reset")
     //.setPosition(500*f1,20*f2)
     //.setSize(int(60*f1),int(19*f2))
     .setPosition(500,20)
     .setSize(int(60),int(19))
     .getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER)

     ;
     
     
       List l = Arrays.asList("Manual", "Cycles");

  cp5.addScrollableList("choose_mode")
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
  

  cp5.addBang("pause_cycles")

     .setPosition(500,120)
     .setSize(200,19)
     .setCaptionLabel("Pause")
     .getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER)
     //.toUpperCase(false)
     ;
   
 
 //BOTTOM controls
 
  cp5.addBang("fix_input")
     .setPosition(160,500)
     .setSize(95,20)
     .setCaptionLabel("Fix Input")
     .getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER)

     ;
 
 
 
 }
     
void add_inputs()
{
  
    cp5.addTextfield("width")
     .setPosition(20,350)
     .setSize(75,20)
     .setFont(createFont("arial",15))
     .setAutoClear(false)
     .setCaptionLabel("Width")
     .getCaptionLabel()
     .toUpperCase(false)
     .setFont(createFont("arial",15))
     ;
     
    
     
     cp5.addTextfield("length")
 .setPosition(170,350)
    .setSize(75,20)
     .setFont(createFont("arial",15))
     .setAutoClear(false)
     .setCaptionLabel("Length")
     .getCaptionLabel()
     .toUpperCase(false)
     .setFont(createFont("arial",15))
     ;
    
     
     cp5.addTextfield("thickness")
 .setPosition(320,350)
      .setSize(75,20)
     .setFont(createFont("arial",15))
     .setAutoClear(false)
     .setCaptionLabel("Thickness")
     .getCaptionLabel()
     .toUpperCase(false)
     .setFont(createFont("arial",15))
     ;
     
     
        cp5.addTextfield("speed")
     .setPosition(20,420)
     .setSize(75,20)
     .setFont(createFont("arial",15))
     .setAutoClear(false)
     .setCaptionLabel("Speed")
     .getCaptionLabel()
     .toUpperCase(false)
     .setFont(createFont("arial",15))
     ;
     cp5.addTextfield("no_of_cycles")
 .setPosition(170,420)
    .setSize(75,20)
     .setFont(createFont("arial",15))
     .setAutoClear(false)
     .setCaptionLabel("No. of cycles")
     .getCaptionLabel()
     .toUpperCase(false)
     .setFont(createFont("arial",15))
     ;
     cp5.addTextfield("initial_distance")
 .setPosition(320,420)
      .setSize(75,20)
     .setFont(createFont("arial",15))
     .setAutoClear(false)
     .setCaptionLabel("Initial distance (stretch)")
     .getCaptionLabel()
     .toUpperCase(false)
     .setFont(createFont("arial",15))
     
     ;
       cp5.get(Textfield.class,"width").setInputFilter(ControlP5.FLOAT);
     cp5.get(Textfield.class,"length").setInputFilter(ControlP5.FLOAT);
       cp5.get(Textfield.class,"thickness").setInputFilter(ControlP5.FLOAT);
     cp5.get(Textfield.class,"speed").setInputFilter(ControlP5.FLOAT);
       cp5.get(Textfield.class,"no_of_cycles").setInputFilter(ControlP5.FLOAT);
     cp5.get(Textfield.class,"initial_distance").setInputFilter(ControlP5.FLOAT);
     
     
     
      cp5.get(Textfield.class,"initial_distance").setValue(String.valueOf(0.0));
     
     
     
       
  
}

void lock_all()
{cp5.get(Textfield.class,"width").lock();
cp5.get(Textfield.class,"length").lock();
cp5.get(Textfield.class,"thickness").lock();
cp5.get(Textfield.class,"speed").lock();
cp5.get(Textfield.class,"no_of_cycles").lock();
cp5.get(Textfield.class,"initial_distance").lock();

}

void unlock_all()
{cp5.get(Textfield.class,"width").unlock();
cp5.get(Textfield.class,"length").unlock();
cp5.get(Textfield.class,"thickness").unlock();
cp5.get(Textfield.class,"speed").unlock();
cp5.get(Textfield.class,"no_of_cycles").unlock();
cp5.get(Textfield.class,"initial_distance").unlock();

}