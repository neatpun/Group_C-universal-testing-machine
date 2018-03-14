
 
 
 import processing.serial.*;

import cc.arduino.*;

Arduino arduino;
//--VARIABLES
//ASSUMPTION: speed between 0 to 255    ; You start from the bottom with distance =0 ; DISTANCE scaling remaining

int speed_slider;
String mode="initial";
int event_time;
double distance=0;
double velocity;
String current_direction;
double MAX_UP;
double MIN_DOWN;


//VARIABLES--
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
  //arduino = new Arduino(this, Arduino.list()[0], 57600);
  // arduino.analogWrite(9, constrain(mouseX / 2, 0, 255));
  //arduino.pinMode(i, Arduino.OUTPUT);
  //    arduino.pinMode(i, Arduino.INPUT);
  //arduino.analogRead(i)
  // arduino.digitalWrite(pin, Arduino.HIGH);
  
   //for (int i = 0; i <= 13; i++)
 //arduino.pinMode(i, Arduino.OUTPUT);
 
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
  distance=0;
    cp5.get(ScrollableList.class,"choose_mode").hide(); // LOCK NOT WORKING , why??
      cp5.get(ScrollableList.class,"choose_mode").setColorBackground(0xff1381d6);
  cp5.get(ScrollableList.class,"choose_mode").setColorValue(0xff000000);
  if(n==0)
  {cp5.getController("up").show();
cp5.getController("pause").show();
cp5.getController("down").show();
mode="manual_begin";

}
  else if(n==1)
  {cp5.getController("run").show();
cp5.getController("pause_cycles").show();
cp5.getController("cycle_length").show();
mode="cycle_begin";

}

else if(n==2)
  {cp5.getController("up3").show();
cp5.getController("pause3").show();
cp5.getController("down3").show();
cp5.getController("set_natural").show();
mode="3pointcycle_begin";

}


  
}

public void fix_input() {
  lock_all();
  
  //cp5.get(Textfield.class,"speed").getText();


}
public void reset()
{unlock_all();
  cp5.get(ScrollableList.class,"choose_mode").show();
  
  cp5.get(Textfield.class,"width").setColorBackground(0xff002D5A);
  cp5.get(Textfield.class,"width").setColorValue(0xffffffff);
}


//FUNCTIONALITY

public void up()
{
if (mode.equals("manual_begin")  ) {event_time=millis(); mode="manual"; //arduino.analogWrite(10, speed_slider);
}
else if ( mode.equals("cycle_begin")  ) {event_time=millis(); mode="cycle"; //arduino.analogWrite(10, speed_slider);
}
else {distance+=velocity*(millis()-event_time);}

//motor control
 if(mode.equals("manual_pause")) {//arduino.analogWrite(10, speed_slider); MAY NOT BE NECCESARRY
 mode="manual";}
 
 //arduino.digitalWrite(8, 1);
 //arduino.digitalWrite(7, 0);
 
event_time=millis();




current_direction="up";


velocity=speed_slider;
cp5.get(Textlabel.class,"debug").setText("dist:"+Double.toString(distance )+ " mode:" + mode 
+ " dir:"+ current_direction + " vel:"+ Double.toString(velocity) + " event_time:" + event_time);
}

public void pause ()
{
  
distance+=velocity*(millis()-event_time);


//arduino.analogWrite(10, 0); //motor pause control
//better yet
//arduino.digitalWrite(8, 0);
 //arduino.digitalWrite(7, 0);
 

mode="manual_pause";

event_time=millis();

//When_resumed=current_direction //probs unneccesary 

velocity=0;
cp5.get(Textlabel.class,"debug").setText("dist:"+Double.toString(distance )+ " mode:" + mode 
+ " dir:"+ current_direction + " vel:"+ Double.toString(velocity) + " event_time:" + event_time);
}



public void down()
{
if (mode.equals("manual_begin")  ) {event_time=millis(); mode="manual"; //arduino.analogWrite(10, speed_slider);
}
else if ( mode.equals("cycle_begin")  ) {event_time=millis(); mode="cycle"; //arduino.analogWrite(10, speed_slider);
}
else {distance+=velocity*(millis()-event_time);}

//motor control
 if(mode.equals("manual_pause")) {//arduino.analogWrite(10, speed_slider); MAY NOT BE NECCESARRY
 mode="manual";}
 
 //arduino.digitalWrite(8, 0);
 //arduino.digitalWrite(7, 1);
 
event_time=millis();




current_direction="down";


velocity=-speed_slider;
cp5.get(Textlabel.class,"debug").setText("dist:"+Double.toString(distance )+ " mode:" + mode 
+ " dir:"+ current_direction + " vel:"+ Double.toString(velocity) + " event_time:" + event_time);
}







//3POINTCYCLE


public void up3()
{
if (mode.equals("3pointcycle_begin")  ) {event_time=millis(); mode="3pointcycle"; //arduino.analogWrite(10, speed_slider);
}

else {distance+=velocity*(millis()-event_time)/1000;}


 
 //arduino.digitalWrite(8, 1);
 //arduino.digitalWrite(7, 0);
 
event_time=millis();




current_direction="up";


velocity=speed_slider;
cp5.get(Textlabel.class,"debug").setText("dist:"+Double.toString(distance )+ " mode:" + mode 
+ " dir:"+ current_direction + " vel:"+ Double.toString(velocity) + " event_time:" + event_time);
}

public void pause3 ()
{
  
distance+=velocity*(millis()-event_time)/1000;


//arduino.analogWrite(10, 0); //motor pause control
//better yet
//arduino.digitalWrite(8, 0);
 //arduino.digitalWrite(7, 0);
 

mode="manual_pause";

event_time=millis();

//When_resumed=current_direction //probs unneccesary 

velocity=0;
cp5.get(Textlabel.class,"debug").setText("dist:"+Double.toString(distance )+ " mode:" + mode 
+ " dir:"+ current_direction + " vel:"+ Double.toString(velocity) + " event_time:" + event_time);
}



public void down3()
{
if (mode.equals("3pointcycle_begin")  ) {event_time=millis(); mode="manual"; //arduino.analogWrite(10, speed_slider);
}
else if ( mode.equals("cycle_begin")  ) {event_time=millis(); mode="cycle"; //arduino.analogWrite(10, speed_slider);
}
else {distance+=velocity*(millis()-event_time)/1000;}

//motor control
 if(mode.equals("manual_pause")) {//arduino.analogWrite(10, speed_slider); MAY NOT BE NECCESARRY
 mode="manual";}
 
 //arduino.digitalWrite(8, 0);
 //arduino.digitalWrite(7, 1);
 
event_time=millis();




current_direction="down";


velocity=-speed_slider;
cp5.get(Textlabel.class,"debug").setText("dist:"+Double.toString(distance )+ " mode:" + mode 
+ " dir:"+ current_direction + " vel:"+ Double.toString(velocity) + " event_time:" + event_time);
}


public void set_natural()
{
distance=0;

cp5.getController("set_natural").hide();
cp5.getController("set_up").show();
}
public void set_up()
{
MAX_UP=distance;

cp5.getController("set_up").hide();
cp5.getController("set_down").show();
}
public void set_down()
{
MIN_DOWN=distance;


cp5.getController("set_down").hide();
cp5.getController("up3").hide();
cp5.getController("down3").hide();
cp5.getController("pause3").hide();

mode="MAIN_CYCLE_BEGIN";
cp5.getController("run3").show();
cp5.getController("pause_cycles3").show();

}




//HELPER FUNCTIONS
void add_live_panel()
{
  
  //https://forum.processing.org/two/discussion/24244/controlp5-textfield-background-colour
  
  cp5.addTextlabel("debug")
                    .setText("This will show stuff")
                    .setPosition(20,300)
                    .setColorValue(0xffffff00)
                    .setFont(createFont("Georgia",15))
                    ;
  
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
cp5.getController("pause_cycles").hide();
cp5.getController("cycle_length").hide();

cp5.getController("up3").hide();
cp5.getController("down3").hide();
cp5.getController("pause3").hide();
cp5.getController("set_up").hide();
cp5.getController("set_natural").hide();
cp5.getController("set_down").hide();
cp5.getController("run3").hide();
cp5.getController("pause_cycles3").hide();


}

void add_controls()
{ // Top controls
   cp5.addBang("reset")
     //.setPosition(500*f1,20*f2)
     //.setSize(int(60*f1),int(19*f2))
     .setPosition(500,20)
     .setSize(int(60),int(19))
     .getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER)

     ;
     
     
       List l = Arrays.asList("Manual", "Cycles","3pointcycle");

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
     
     cp5.addTextfield("cycle_length")
     .setPosition(600,80)
     .setSize(50,20)
     .setFont(createFont("arial",15))
     .setAutoClear(false)
     .setCaptionLabel("Cycle length:")
     .getCaptionLabel()
     .toUpperCase(false)
     .align(ControlP5.LEFT_OUTSIDE, CENTER)
  
     .setFont(createFont("arial",15))
     .getStyle().setPaddingLeft(-10);
     
       cp5.addBang("run")

     .setPosition(500,120)
     .setSize(200,19)
     .getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER)
     ;
     
     cp5.get(Textfield.class,"cycle_length").setInputFilter(ControlP5.FLOAT);
  

  cp5.addBang("pause_cycles")

     .setPosition(500,140)
     .setSize(200,19)
     .setCaptionLabel("Pause")
     .getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER)
     //.toUpperCase(false)
     ;
   //3POINTCYCLE
   
    cp5.addBang("up3")

     .setPosition(500,100)
     .setSize(200,19)
     .setCaptionLabel("UP")
     .getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER)
     ;
  
  cp5.addBang("pause3")

     .setPosition(500,120)
     .setSize(200,19)
     .setCaptionLabel("PAUSE")
     .getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER)
     ;
     
  cp5.addBang("down3")
     .setPosition(500,140)
     .setSize(200,19)
     .setCaptionLabel("DOWN")
     .getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER)

     ;
     
     cp5.addBang("set_natural")

     .setPosition(500,60)
     .setSize(200,19)
     .setCaptionLabel("Set natural point")
     .getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER)
     ;
     
     cp5.addBang("set_up")

     .setPosition(500,60)
     .setSize(200,19)
     .setCaptionLabel("Set uppermost point")
     .getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER)
     ;
 
 
 cp5.addBang("set_down")

     .setPosition(500,60)
     .setSize(200,19)
     .setCaptionLabel("Set lowermost point")
     .getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER)
     ;
 
 
 cp5.addBang("run3")

     .setPosition(500,120)
     .setSize(200,19)
     .setCaptionLabel("run")
     .getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER)
     ;

  

  cp5.addBang("pause_cycles3")

     .setPosition(500,140)
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
     
     
     //   cp5.addTextfield("speed")
     //.setPosition(20,420)
     //.setSize(75,20)
     //.setFont(createFont("arial",15))
     //.setAutoClear(false)
     //.setCaptionLabel("Speed")
     //.getCaptionLabel()
     //.toUpperCase(false)
     //.setFont(createFont("arial",15))
     //;
     
      cp5.addSlider("speed_slider")
       .setPosition(20,421)
     .setRange(0,255)
     .setSize(100,20)
      .getCaptionLabel()
      .toUpperCase(false)
      .setFont(createFont("arial",15))
      .align(ControlP5.LEFT, ControlP5.BOTTOM_OUTSIDE);
      
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
     //cp5.get(Textfield.class,"speed").setInputFilter(ControlP5.FLOAT);
       cp5.get(Textfield.class,"no_of_cycles").setInputFilter(ControlP5.FLOAT);
     cp5.get(Textfield.class,"initial_distance").setInputFilter(ControlP5.FLOAT);
     
     
     
      cp5.get(Textfield.class,"initial_distance").setValue(String.valueOf(0.0));
     
     
     
       
  
}

void lock_all()
{  
  cp5.get(Textfield.class,"width").lock();
cp5.get(Textfield.class,"length").lock();
cp5.get(Textfield.class,"thickness").lock();
cp5.get(Slider.class,"speed_slider").lock();
cp5.get(Textfield.class,"no_of_cycles").lock();
cp5.get(Textfield.class,"initial_distance").lock();


  cp5.get(Textfield.class,"width").setColorBackground(0xff1381d6);
cp5.get(Textfield.class,"length").setColorBackground(0xff1381d6);
cp5.get(Textfield.class,"thickness").setColorBackground(0xff1381d6);
cp5.get(Slider.class,"speed_slider").setColorBackground(0xff1381d6);
cp5.get(Textfield.class,"no_of_cycles").setColorBackground(0xff1381d6);
cp5.get(Textfield.class,"initial_distance").setColorBackground(0xff1381d6);



  cp5.get(Textfield.class,"width").setColorValue(0xff000000);
cp5.get(Textfield.class,"length").setColorValue(0xff000000);
cp5.get(Textfield.class,"thickness").setColorValue(0xff000000);
cp5.get(Slider.class,"speed_slider").setColorValue(0xff000000);
cp5.get(Textfield.class,"no_of_cycles").setColorValue(0xff000000);
cp5.get(Textfield.class,"initial_distance").setColorValue(0xff000000);

}

void unlock_all()
{
  cp5.get(Textfield.class,"width").unlock();
cp5.get(Textfield.class,"length").unlock();
cp5.get(Textfield.class,"thickness").unlock();
cp5.get(Slider.class,"speed_slider").unlock();
cp5.get(Textfield.class,"no_of_cycles").unlock();
cp5.get(Textfield.class,"initial_distance").unlock();

  cp5.get(Textfield.class,"width").setColorBackground(0xff002D5A);
cp5.get(Textfield.class,"length").setColorBackground(0xff002D5A);
cp5.get(Textfield.class,"thickness").setColorBackground(0xff002D5A);
cp5.get(Slider.class,"speed_slider").setColorBackground(0xff002D5A);
cp5.get(Textfield.class,"no_of_cycles").setColorBackground(0xff002D5A);
cp5.get(Textfield.class,"initial_distance").setColorBackground(0xff002D5A);



  cp5.get(Textfield.class,"width").setColorValue(0xffffffff);
cp5.get(Textfield.class,"length").setColorValue(0xffffffff);
cp5.get(Textfield.class,"thickness").setColorValue(0xffffffff);
cp5.get(Slider.class,"speed_slider").setColorValue(0xffffffff);
cp5.get(Textfield.class,"no_of_cycles").setColorValue(0xffffffff);
cp5.get(Textfield.class,"initial_distance").setColorValue(0xffffffff);

}