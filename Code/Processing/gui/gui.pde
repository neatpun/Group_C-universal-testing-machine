
int counter=0;

//graph variables start
PGraphics pg;
int max_val=200;    // divisible by 10
int max_dist=100;   // divisible by 20
//graph variable ends


 import processing.serial.*;

import java.text.DecimalFormat;
import cc.arduino.*;

Arduino arduino;
//--VARIABLES
//ASSUMPTION: speed between 0 to 255    ; You start from the bottom with distance =0 ; DISTANCE scaling remaining

int speed_slider;
String mode="initial";
int event_time;
double real_distance=0;
double fake_distance=0;
double velocity;
String current_direction;
double MAX_UP;
double MIN_DOWN;
int current_cycle;
int cycles_needed;
double loadcell_value;
String next_turn="undefined";
DecimalFormat df = new DecimalFormat(".##");
boolean arduino_enable = false;

Table table;
TableRow newRow;
//VARIABLES--
import controlP5.*;
import java.util.*;

ControlP5 cp5;

int myColor = color(255);

int c1,c2;

float n,n1;
//float f1,f2;

int i=25;
int j=90;


void setup() {
  //displayWidth  displayHeight
  //f1=displayWidth/1024.0/2;

  //f2=displayHeight/768.0/2;



  size(800,600);

  pg = createGraphics(round(width*0.75), round(height*2/3));//pg = createGraphics(600, 400); //graph

  pg.beginDraw();
  pg.background(255);
  create_graph_outline();
  pg.stroke(30);
  pg.endDraw();    // end graph

  //surface.setResizable(true);
  //surface.setSize(int(800*f1),int(600*f2));
  noStroke();
  cp5 = new ControlP5(this);

 add_controls();

     add_inputs();
     add_live_panel();


hide_controls();

  try {

    println(Arduino.list());
    arduino = new Arduino(this, Arduino.list()[0], 57600); //ENABLE
    arduino_enable = true;
    //cp5.get(Textfield.class, "enable_arduino").lock();
    cp5.getController("enable_arduino").hide();

  } catch(Exception e) {
    println("Arduino is not connected");
    cp5.getController("enable_arduino").setColorForeground(color(246,29,29));

  }



  if(arduino_enable) {
    for (int i = 0; i <= 13; i++)//ENABLE
    arduino.pinMode(i, Arduino.OUTPUT);//ENABLE
  }



      table = createTable();

}


void draw() {
  background(0,0,0);

  // show_graph();
  image(pg, 10, 30);         // this will show the graph

  if(mode=="MAIN_CYCLE_RUNNING")
  {
  cycle_control();


  //loadread
  loadcell_value=random(10);
  fake_distance=real_distance + velocity*(millis()-event_time)/1000;

  cp5.get(Slider.class,"motor_simulate").setValue((float)fake_distance);
  cp5.get(Textfield.class,"distance").setValue(df.format(fake_distance));
  cp5.get(Textfield.class,"PANEL_cycle").setValue(df.format(current_cycle/2.0));
  
  String wid=cp5.get(Textfield.class,"width").getText();
  double breadth=Double.parseDouble(wid);
  String thick =cp5.get(Textfield.class,"thickness").getText();
  double thickness =Double.parseDouble(thick);
  String len =cp5.get(Textfield.class,"length").getText();
  double vertical_length =Double.parseDouble(len);
  double stress = (fake_distance-MIN_DOWN)/vertical_length;
  double area= breadth*thickness*0.00001;//converting into metre square
  double strain=loadcell_value/area;
  cp5.get(Textfield.class,"strain").setValue(df.format(strain));
  cp5.get(Textfield.class,"load").setValue(df.format(loadcell_value));
  cp5.get(Textfield.class,"stress").setValue(df.format(stress));
    newRow = addRow(table);
    setRowData(newRow);


  delay(100);
  }

  else if(mode=="MAIN_CYCLE_DONE")
  {
  println("donezo");
  saveTable(table, "data/new.csv");
  mode="initial";
  reset();
  }
  else
  {
    // println("real_dist : " + real_distance + "  vel: " + velocity + "  eventT: " + event_time+"  fak: " + fake_distance);
    fake_distance=real_distance + velocity*(millis()-event_time)/1000;
     cp5.get(Slider.class,"motor_simulate").setValue((float)fake_distance);
   cp5.get(Textfield.class,"distance").setValue(df.format(fake_distance));
   cp5.get(Textfield.class,"PANEL_cycle").setValue(df.format(0));
  }
}




//CONTROL EVENTS

void choose_mode(int n) {
fix_input();
  hide_controls();
  real_distance=0;
    cp5.get(ScrollableList.class,"choose_mode").hide(); // LOCK NOT WORKING , why??
      cp5.get(ScrollableList.class,"choose_mode").setColorBackground(0xff1381d6);
  cp5.get(ScrollableList.class,"choose_mode").setColorValue(0xff000000);
  if(n==0)
  {cp5.getController("up").show();
cp5.getController("pause").show();
cp5.getController("down").show();
mode="manual_begin";


cp5.get(Textarea.class,"tutorial").setText("In manual mode , when you click 'UP' the motor moves in one direction , when you click 'PAUSE' it stops and when you click 'DOWN' it moves in opposite direction"
                    );

}
//  else if(n==1)
//  {cp5.getController("run").show();
//cp5.getController("pause_cycles").show();
//cp5.getController("cycle_length").show();
//mode="cycle_begin";

//}

else if(n==1)//2
  {cp5.getController("up3").show();
cp5.getController("pause3").show();
cp5.getController("down3").show();
cp5.getController("set_natural").show();

    cp5.getController("uppermost_point").show();
    cp5.getController("lowermost_point").show();
    cp5.getController("natural_point").show();
    
    cp5.getController("lowermost_point").lock();
    cp5.getController("natural_point").unlock();
    cp5.getController("uppermost_point").lock();
    
mode="3pointcycle_begin";



cp5.get(Textarea.class,"tutorial").setText("Use the controls and when you arrive at natural point of material (0 compression and 0 streching ) click 'SET NATURAL POINT'. Then that point will act as origin (distance 0)."
                    );

}



}

public void fix_input() {
  lock_all();

  cycles_needed=2*Integer.parseInt(cp5.get(Textfield.class,"no_of_cycles").getText());



}
public void reset()
{
  mode = "initial";
  unlock_all();
hide_controls();
  cp5.get(ScrollableList.class,"choose_mode").show();
  cp5.get(ScrollableList.class,"choose_mode").open();
  cp5.get(ScrollableList.class,"choose_mode").setCaptionLabel("choose_mode");

  cp5.get(Textfield.class,"width").setColorBackground(0xff002D5A);
  cp5.get(Textfield.class,"width").setColorValue(0xffffffff);


  cp5.get(Textarea.class,"tutorial").setText("Please input speed and number of cycles. Then choose a mode. Either (1.) Manual or (2.) CYCLE : Automatic cycle control"
                      +"\n"+"                                                                  Inputs: (Length , width , thickness)  and Outputs: (stress , load , strain)  are not yet implemented. Please ignore them."
                    );

  fake_distance = 0;

  event_time = 0;

  velocity = 0;

  real_distance = 0;

  cp5.getController("motor_simulate").setValue(0);
  
    if(arduino_enable) {
    arduino.digitalWrite(8, 0);//ENABLE
    arduino.digitalWrite(7, 0);//ENABLE
  }

}


//FUNCTIONALITY

public void up()
{
if (mode.equals("manual_begin")  ) {event_time=millis(); mode="manual";

  if(arduino_enable) {
    arduino.analogWrite(10, speed_slider);//ENABLE
  }

}
else if ( mode.equals("cycle_begin")  ) {event_time=millis(); mode="cycle";

  if(arduino_enable) {
    arduino.analogWrite(10, speed_slider);//ENABLE
  }

}
else {real_distance+=velocity*(millis()-event_time)/1000;}

//motor control
 if(mode.equals("manual_pause")) {

 if(arduino_enable) {
    arduino.analogWrite(10, speed_slider); // NOT NECCESARRY
  }

 mode="manual";

}

 if(arduino_enable) {
    arduino.digitalWrite(8, 1);//ENABLE
    arduino.digitalWrite(7, 0);//ENABLE
 }

event_time=millis();




current_direction="up";


velocity=speed_slider;
cp5.get(Textlabel.class,"debug").setText("dist:"+Double.toString(real_distance )+ " mode:" + mode
+ " dir:"+ current_direction + " vel:"+ Double.toString(velocity) + " event_time:" + event_time);
}

public void pause ()
{

real_distance+=velocity*(millis()-event_time)/1000;




  if(arduino_enable) {
    arduino.digitalWrite(8, 0);//ENABLE
    arduino.digitalWrite(7, 0);//ENABLE
  }


mode="manual_pause";

event_time=millis();

//When_resumed=current_direction //probs unneccesary

velocity=0;
cp5.get(Textlabel.class,"debug").setText("dist:"+Double.toString(real_distance )+ " mode:" + mode
+ " dir:"+ current_direction + " vel:"+ Double.toString(velocity) + " event_time:" + event_time);
}



public void down()
{
if (mode.equals("manual_begin")  ) {event_time=millis(); mode="manual";

  if(arduino_enable) {
    arduino.analogWrite(10, speed_slider);//ENABLE
  }

}
else if ( mode.equals("cycle_begin")  ) {event_time=millis(); mode="cycle";

  if(arduino_enable) {
    arduino.analogWrite(10, speed_slider);//ENABLE
  }

}
else {real_distance+=velocity*(millis()-event_time)/1000;}

//motor control
 if(mode.equals("manual_pause")) {

  if(arduino_enable) {
    arduino.analogWrite(10, speed_slider); // NOT NECCESARRY
  }

  mode="manual";
 }

  if(arduino_enable) {
   arduino.digitalWrite(8, 0);//ENABLE
   arduino.digitalWrite(7, 1);//ENABLE
  }

event_time=millis();




current_direction="down";


velocity=-speed_slider;
cp5.get(Textlabel.class,"debug").setText("dist:"+Double.toString(real_distance )+ " mode:" + mode
+ " dir:"+ current_direction + " vel:"+ Double.toString(velocity) + " event_time:" + event_time);
}







//3POINTCYCLE


public void up3()
{
if (mode.equals("3pointcycle_begin")  ) {event_time=millis(); mode="3pointcycle";
  if(arduino_enable) {
    arduino.analogWrite(10, speed_slider);//ENABLE
  }

}

else {real_distance+=velocity*(millis()-event_time)/1000;}


 if(arduino_enable) {
  arduino.digitalWrite(8, 1);//ENABLE
  arduino.digitalWrite(7, 0);//ENABLE
 }

event_time=millis();




current_direction="up";


velocity=speed_slider;
cp5.get(Textlabel.class,"debug").setText("dist:"+Double.toString(real_distance )+ " mode:" + mode
+ " dir:"+ current_direction + " vel:"+ Double.toString(velocity) + " event_time:" + event_time);
}

public void pause3 ()
{

real_distance+=velocity*(millis()-event_time)/1000;




if(arduino_enable) {
  arduino.digitalWrite(8, 0);//ENABLE
  arduino.digitalWrite(7, 0);//ENABLE
}


mode="3pointcycle_pause";

event_time=millis();

//When_resumed=current_direction //probs unneccesary

velocity=0;
cp5.get(Textlabel.class,"debug").setText("dist:"+Double.toString(real_distance )+ " mode:" + mode
+ " dir:"+ current_direction + " vel:"+ Double.toString(velocity) + " event_time:" + event_time);
}



public void down3()
{
if (mode.equals("3pointcycle_begin")  ) {event_time=millis(); mode="3pointcycle";
  if(arduino_enable) {
    arduino.analogWrite(10, speed_slider);
  }

}

else {real_distance+=velocity*(millis()-event_time)/1000;}

//motor control

  if(arduino_enable) {
     arduino.digitalWrite(8, 0);//ENABLE
     arduino.digitalWrite(7, 1);//ENABLE
  }

event_time=millis();




current_direction="down";


velocity=-speed_slider;
cp5.get(Textlabel.class,"debug").setText("dist:"+Double.toString(real_distance )+ " mode:" + mode
+ " dir:"+ current_direction + " vel:"+ Double.toString(velocity) + " event_time:" + event_time);
}


public void set_natural()
{
  pause3 ();
  real_distance=0;
  event_time=millis();
  
cp5.getController("set_natural").hide();
cp5.getController("set_up").show();
cp5.getController("down3").hide();

  cp5.getController("lowermost_point").lock();
  cp5.getController("natural_point").lock();
  cp5.getController("uppermost_point").unlock();

cp5.get(Textarea.class,"tutorial").setText("Use the controls and when you arrive at uppermost point of your desired cycle (maximum compression  ) click 'SET UPPERMOST POINT'. Then that point will be the topmost point of cycle."
                    );
}
public void set_up()
{
  pause3 ();
  fake_distance=real_distance + velocity*(millis()-event_time)/1000;
  
  String uppermost_point=cp5.get(Textfield.class,"uppermost_point").getText();
  //println(uppermost_point);
  MAX_UP=Double.parseDouble(uppermost_point);

  cp5.getController("uppermost_point").lock();
  cp5.getController("lowermost_point").unlock();
  cp5.getController("natural_point").lock();

cp5.getController("set_up").hide();
cp5.getController("set_down").show();
cp5.getController("down3").show();
cp5.getController("up3").hide();


cp5.get(Textarea.class,"tutorial").setText("Use the controls and when you arrive at lowermost point of your desired cycle (maximum streching  ) click 'SET LOWERMOST POINT'. Then that point will be the lowest point of cycle."
                    );
}
public void set_down()
{
  pause3 ();
  fake_distance=real_distance + velocity*(millis()-event_time)/1000;
  
String lowermost_point=cp5.get(Textfield.class,"lowermost_point").getText();
  //println(lowermost_point);
  MIN_DOWN=Double.parseDouble(lowermost_point);

cp5.getController("uppermost_point").lock();
cp5.getController("lowermost_point").unlock();
cp5.getController("natural_point").lock();


cp5.getController("set_down").hide();
cp5.getController("up3").hide();
cp5.getController("down3").hide();
cp5.getController("pause3").hide();

mode="MAIN_CYCLE_BEGIN";
cp5.getController("run3").show();
cp5.getController("pause_cycles3").show();


cp5.get(Textarea.class,"tutorial").setText("Click 'RUN' to start automatic cycle control. You can 'PAUSE' whenever you wantand then 'RUN' again. After the cycles are finished the motor will stop and a new file will be ed to the data folder with all collected data."
                    );

}




public void cycle_control()
{
  if(mode=="MAIN_CYCLE_RUNNING")
  {

    println(counter++);

   fake_distance=real_distance + velocity*(millis()-event_time)/1000;

    if(current_cycle > cycles_needed)
    {
      velocity=0;
      //speed_slider=0; NO

      mode="MAIN_CYCLE_DONE";
      if(arduino_enable) {
        arduino.analogWrite(10, 0);//ENABLE
        arduino.digitalWrite(8, 0);//ENABLE
        arduino.digitalWrite(7, 0);//ENABLE
      }



cp5.get(Textlabel.class,"debug").setText("Cycles are finished. File 'new.csv' has been exported to 'data/new.csv'"
                    );



    }

  else if((fake_distance< 0.95*MIN_DOWN ) && (current_direction=="down"))
  {
  real_distance+=velocity*(millis()-event_time)/1000;

    if(arduino_enable) {
      //up
      arduino.digitalWrite(8, 1);//ENABLE
      arduino.digitalWrite(7, 0);//ENABLE
    }

event_time=millis();
current_direction="up";


velocity=speed_slider;

current_cycle++;


cp5.get(Textlabel.class,"debug").setText("dist:"+Double.toString(real_distance )+ " mode:" + mode
+ " dir:"+ current_direction + " vel:"+ Double.toString(velocity) + " event_time:" + event_time + " current_cycle:"+ Double.toString(current_cycle/2) );



  }
  else if((fake_distance> 0.95*MAX_UP)  && (current_direction=="up"))
  {

    real_distance+=velocity*(millis()-event_time)/1000;

    if(arduino_enable) {
      // down
      arduino.digitalWrite(8, 0);//ENABLE
      arduino.digitalWrite(7, 1);//ENABLE
    }

event_time=millis();
current_direction="down";


velocity=-speed_slider;
current_cycle++;
cp5.get(Textlabel.class,"debug").setText("dist:"+Double.toString(real_distance )+ " mode:" + mode
+ " dir:"+ current_direction + " vel:"+ Double.toString(velocity) + " event_time:" + event_time + " current_cycle:"+ Double.toString(current_cycle/2) );



  }


  }
}

public void run3()
{

  if(mode=="MAIN_CYCLE_BEGIN")
  {


      //distance right now is MIN_DOWN

real_distance+=velocity*(millis()-event_time)/1000;

if(arduino_enable) {
  //up
  arduino.digitalWrite(8, 1);//ENABLE
  arduino.digitalWrite(7, 0);//ENABLE
}

event_time=millis();
current_direction="up";
current_cycle=0;

velocity=speed_slider;



  mode="MAIN_CYCLE_RUNNING";
cp5.get(Textlabel.class,"debug").setText("dist:"+Double.toString(real_distance )+ " mode:" + mode
+ " dir:"+ current_direction + " vel:"+ Double.toString(velocity) + " event_time:" + event_time);


  }

  else if(mode=="MAIN_CYCLE_PAUSE")
  {

    if(current_direction=="up")
    {

    real_distance+=velocity*(millis()-event_time)/1000;

    if(arduino_enable) {
      //up
      arduino.digitalWrite(8, 1);//ENABLE
      arduino.digitalWrite(7, 0);//ENABLE
    }

event_time=millis();
current_direction="up";


velocity=speed_slider;



  mode="MAIN_CYCLE_RUNNING";
cp5.get(Textlabel.class,"debug").setText("dist:"+Double.toString(real_distance )+ " mode:" + mode
+ " dir:"+ current_direction + " vel:"+ Double.toString(velocity) + " event_time:" + event_time);


    }

    else if(current_direction=="down")
    {


        real_distance+=velocity*(millis()-event_time)/1000;

      if(arduino_enable) {
        //down
        arduino.digitalWrite(8, 0);//ENABLE
        arduino.digitalWrite(7, 1);//ENABLE
      }

event_time=millis();
current_direction="down";


velocity=-speed_slider;


  mode="MAIN_CYCLE_RUNNING";
cp5.get(Textlabel.class,"debug").setText("dist:"+Double.toString(real_distance )+ " mode:" + mode
+ " dir:"+ current_direction + " vel:"+ Double.toString(velocity) + " event_time:" + event_time);


    }


  }



}
public void pause_cycles3()
{
 real_distance+=velocity*(millis()-event_time)/1000;


 if(arduino_enable) {
  arduino.digitalWrite(8, 0);//ENABLE
  arduino.digitalWrite(7, 0);//ENABLE
  }


mode="MAIN_CYCLE_PAUSE";

event_time=millis();



velocity=0;
cp5.get(Textlabel.class,"debug").setText("dist:"+Double.toString(real_distance )+ " mode:" + mode
+ " dir:"+ current_direction + " vel:"+ Double.toString(velocity) + " event_time:" + event_time);


}


void add_live_panel()
{

  //https://forum.processing.org/two/discussion/24244/controlp5-textfield-background-colour

  cp5.addTextlabel("debug")
    .setText("This will show stuff")
    .setPosition(width*0.025, height*0.5)//.setPosition(20, 300)
    .setColorValue(0xffffff00)
    .setFont(createFont("Georgia", 15))
    ;

  cp5.addTextfield("distance")
    .setPosition(width*0.6875, height*5/6)//.setPosition(550,500)
    .setSize(round(width*0.125), round(height/30))//.setSize(100,20)
    .setFont(createFont("arial", 15))
    .setAutoClear(false)
    .setCaptionLabel("Distance:")
    .getCaptionLabel()
    .toUpperCase(false)
    .align(ControlP5.LEFT_OUTSIDE, CENTER)

    .setFont(createFont("arial", 15))
    .getStyle().setPaddingLeft(-10);

  cp5.addTextfield("PANEL_cycle")
    .setPosition(width*0.6875,height*0.875)//.setPosition(550, 525)
    .setSize(round(width*0.125), round(height/30))//.setSize(100, 20)
    .setFont(createFont("arial", 15))
    .setAutoClear(false)
    .setCaptionLabel("Current cycle:")
    .getCaptionLabel()
    .toUpperCase(false)
    .align(ControlP5.LEFT_OUTSIDE, CENTER)

    .setFont(createFont("arial", 15))
    .getStyle().setPaddingLeft(-10);


  cp5.addTextfield("load")
    .setPosition(width*0.906,height*5/6)//.setPosition(725, 500)
    .setSize(round(width*0.0625),round(height/30))//.setSize(50, 20)
    .setFont(createFont("arial", 15))
    .setAutoClear(false)
    .setCaptionLabel("Load:")
    .getCaptionLabel()
    .toUpperCase(false)
    .align(ControlP5.LEFT_OUTSIDE, CENTER)

    .setFont(createFont("arial", 15))
    .getStyle().setPaddingLeft(-10);



  cp5.addTextfield("strain")
    .setPosition(width*0.6875,height*11/12)//.setPosition(550, 550)
    .setSize(round(width*0.125),round(height/30))//.setSize(100, 20)
    .setFont(createFont("arial", 15))
    .setAutoClear(false)
    .setCaptionLabel("Strain:")
    .getCaptionLabel()
    .toUpperCase(false)
    .align(ControlP5.LEFT_OUTSIDE, CENTER)

    .setFont(createFont("arial", 15))
    .getStyle().setPaddingLeft(-10);



  cp5.addTextfield("stress")
    .setPosition(width*0.906,height*11/12)//.setPosition(725, 550)
    .setSize(round(width*0.125),round( height/30))//.setSize(50, 20)
    .setFont(createFont("arial", 15))
    .setAutoClear(false)
    .setCaptionLabel("Stress:")
    .getCaptionLabel()
    .toUpperCase(false)
    .align(ControlP5.LEFT_OUTSIDE, CENTER)

    .setFont(createFont("arial", 15))
    .getStyle().setPaddingLeft(-10);

cp5.addTextfield("natural_point")
       .setPosition(width*0.90625,height/3)//.setPosition(725,200)
       .setSize(round(width*0.05),round( height/30))//.setSize(40,20)
       .setFont(createFont("arial",15))
       .setAutoClear(false)
       .setCaptionLabel("N.P:")
       .getCaptionLabel()
       .toUpperCase(false)
       .align(ControlP5.LEFT_OUTSIDE, CENTER)
    
       .setFont(createFont("arial",15))
       .getStyle().setPaddingLeft(-10);
       
       cp5.addTextfield("uppermost_point")
       .setPosition(width*0.90625,height*0.368333)//.setPosition(725,221)
       .setSize(round(width*0.05),round( height/30))//.setSize(40,20)
       .setFont(createFont("arial",15))
       .setAutoClear(false)
       .setCaptionLabel("U.P:")
       .getCaptionLabel()
       .toUpperCase(false)
       .align(ControlP5.LEFT_OUTSIDE, CENTER)
    
       .setFont(createFont("arial",15))
       .getStyle().setPaddingLeft(-10);
       
       cp5.addTextfield("lowermost_point")
       .setPosition(width*0.90625,height*0.403333)//.setPosition(725,242)
       .setSize(round(width*0.05),round( height/30))//.setSize(40,20)
       .setFont(createFont("arial",15))
       .setAutoClear(false)
       .setCaptionLabel("L.P:")
       .getCaptionLabel()
       .toUpperCase(false)
       .align(ControlP5.LEFT_OUTSIDE, CENTER)
    
       .setFont(createFont("arial",15))
       .getStyle().setPaddingLeft(-10);



  cp5.get(Textfield.class, "distance").lock();
  cp5.get(Textfield.class, "load").lock();
  cp5.get(Textfield.class, "strain").lock();
  cp5.get(Textfield.class, "stress").lock();
  cp5.get(Textfield.class, "PANEL_cycle").lock();



  cp5.get(Textfield.class, "distance").setColorBackground(0xfffaddff);// 0xff followed by hex value of color
  cp5.get(Textfield.class, "load").setColorBackground(0xfffaddff);
  cp5.get(Textfield.class, "strain").setColorBackground(0xfffaddff);
  cp5.get(Textfield.class, "stress").setColorBackground(0xfffaddff);
  cp5.get(Textfield.class, "PANEL_cycle").setColorBackground(0xfffaddff);

  cp5.get(Textfield.class, "distance").setColorValue(0xff000000);// 0xff followed by hex value of color
  cp5.get(Textfield.class, "load").setColorValue(0xff000000);
  cp5.get(Textfield.class, "strain").setColorValue(0xff000000);
  cp5.get(Textfield.class, "stress").setColorValue(0xff000000);
  cp5.get(Textfield.class, "PANEL_cycle").setColorValue(0xff000000);


  cp5.get(Textfield.class, "distance").setValue(String.valueOf(0.0));
  cp5.get(Textfield.class, "load").setValue(String.valueOf(0.0));
  cp5.get(Textfield.class, "strain").setValue(String.valueOf(0.0));
  cp5.get(Textfield.class, "stress").setValue(String.valueOf(0.0));
  cp5.get(Textfield.class, "PANEL_cycle").setValue(String.valueOf(0.0));
}

void hide_controls()

{
  cp5.getController("up").hide();
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
  
  cp5.getController("natural_point").hide();
  cp5.getController("uppermost_point").hide();
  cp5.getController("lowermost_point").hide();
}

void add_controls()
{ // Top controls
  cp5.addBang("reset")
    //.setPosition(500*f1,20*f2)
    //.setSize(int(60*f1),int(19*f2))
    .setPosition(width*0.90625,height/2)//.setPosition(725, 300)
    .setSize(round(width*0.075),round(height*0.03166667))//.setSize(int(60), int(19))
    .getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER)

    ;



  List l = Arrays.asList("Manual", " CYCLE ");//removed cycle from middle

   cp5.addScrollableList("choose_mode")
    .setPosition(width*0.775,height/30)//.setPosition(620, 20)
    .setSize(round(width*0.2),round(height/6))//.setSize(160, 100)
    .setBarHeight(round(height/30))//.setBarHeight(20)
    .setItemHeight(round(height/30))//.setItemHeight(20)
    .addItems(l)
    // .setType(ScrollableList.LIST) // currently supported DROPDOWN and LIST
    ;



  //Manual controls
  cp5.addBang("up")

    .setPosition(width*0.775,height/6)//.setPosition(620, 100)
    .setSize(round(width*0.2),round(height*0.03166667))//.setSize(160, 19)
    .getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER)
    ;

  cp5.addBang("pause")

    .setPosition(width*0.775,height*0.2)//.setPosition(620, 120)
    .setSize(round(width*0.2),round(height*0.03166667))//.setSize(160, 19)
    .getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER)
    ;

  cp5.addBang("down")
    .setPosition(width*0.775,height*7/30)//.setPosition(620, 140)
    .setSize(round(width*0.2),round(height*0.03166667))//.setSize(160, 19)
    .getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER)

    ;

  //Cycle Controls

  cp5.addTextfield("cycle_length")
    .setPosition(width*0.9,height*2/15)//.setPosition(720, 80)
    .setSize(round(width*0.0625),round(height/30))//.setSize(50, 20)
    .setFont(createFont("arial", 15))
    .setAutoClear(false)
    .setCaptionLabel("Cycle length:")
    .getCaptionLabel()
    .toUpperCase(false)
    .align(ControlP5.LEFT_OUTSIDE, CENTER)

    .setFont(createFont("arial", 15))
    .getStyle().setPaddingLeft(-10);

  cp5.addBang("run")

    .setPosition(width*0.775,height*0.2)//.setPosition(620, 120)
    .setSize(round(width*0.2),round(height*0.03166667))//.setSize(160, 19)
    .getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER)
    ;

  cp5.get(Textfield.class, "cycle_length").setInputFilter(ControlP5.FLOAT);


  cp5.addBang("pause_cycles")

    .setPosition(width*0.775,height*7/30)//.setPosition(620, 140)
    .setSize(round(width*0.2),round(height*0.03166667))//.setSize(160, 19)
    .setCaptionLabel("Pause")
    .getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER)
    //.toUpperCase(false)
    ;
  //3POINTCYCLE

  cp5.addBang("up3")

    .setPosition(width*0.775,height/6)//.setPosition(620, 100)
    .setSize(round(width*0.2),round(height*0.03166667))//.setSize(160, 19)
    .setCaptionLabel("UP")
    .getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER)
    ;

  cp5.addBang("pause3")

    .setPosition(width*0.775,height*0.2)//.setPosition(620, 120)
    .setSize(round(width*0.2),round(height*0.03166667))//.setSize(160, 19)
    .setCaptionLabel("PAUSE")
    .getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER)
    ;

  cp5.addBang("down3")
    .setPosition(width*0.775,height*2/15)//.setPosition(620, 140)
    .setSize(round(width*0.2),round(height*0.03166667))//.setSize(160, 19)
    .setCaptionLabel("DOWN")
    .getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER)

    ;

  cp5.addBang("set_natural")

    .setPosition(width*0.775,height*0.1)//.setPosition(620, 60)
    .setSize(round(width*0.2),round(height*0.03166667))//.setSize(160, 19)
    .setCaptionLabel("Set natural point")
    .getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER)
    ;

  cp5.addBang("set_up")

    .setPosition(width*0.775,height*0.1)//.setPosition(620, 60)
    .setSize(round(width*0.2),round(height*0.03166667))//.setSize(160, 19)
    .setCaptionLabel("Set uppermost point")
    .getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER)
    ;


  cp5.addBang("set_down")

    .setPosition(width*0.775,height*0.1)//.setPosition(620, 60)
    .setSize(round(width*0.2),round(height*0.03166667))//.setSize(160, 19)
    .setCaptionLabel("Set lowermost point")
    .getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER)
    ;


  cp5.addBang("run3")

    .setPosition(width*0.775,height*0.2)//.setPosition(620, 120)
    .setSize(round(width*0.2),round(height*0.03166667))//.setSize(160, 19)
    .setCaptionLabel("run")
    .getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER)
    ;



  cp5.addBang("pause_cycles3")

    .setPosition(width*0.775,height*2/15)//.setPosition(620, 140)
    .setSize(round(width*0.2),round(height*0.03166667))//.setSize(160, 19)
    .setCaptionLabel("Pause")
    .getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER)
    //.toUpperCase(false)
    ;



  //BOTTOM controls

 cp5.addBang("fix_input")
    .setPosition(width*0.2,height*0.95)//.setPosition(160, 570)
    .setSize(round(width*0.11875),round(height/30))//.setSize(95, 20)
    .setCaptionLabel("Fix Input")
    .getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER)

    ;

  cp5.addBang("export_table")
    .setPosition(width*0.8625,height*8/15)//.setPosition(690, 320)
    .setSize(round(width*0.11875),round(height*0.03166667))//.setSize(95, 19)
    .setCaptionLabel("Export Table")
    .getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER);

  cp5.addBang("enable_arduino")
     .setPosition(width*0.8625,height*0.568333)//.setPosition(690, 341)
     .setSize(round(width*0.11875),round(height/30))//.setSize(95, 20)

     .setCaptionLabel("Reconnect Arduino")
     .getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER);


  //MOTOR SIMULATE

  cp5.addSlider("motor_simulate")
    .setPosition(width*0.775,height/3)//.setPosition(620, 200)
    .setSize(round(width*0.025),round(height*5/12))//.setSize(20, 250)
    .setRange(-1500,1500)
    .lock()

    ;

  // TUTORIAL



  cp5.addTextarea("tutorial")
    .setPosition(width*0.25,height/6)//.setPosition(200, 100)
    .setSize(round(width*3/8),round(height/3))//.setSize(300, 200)
    .setFont(createFont("arial", 15))
    .setLineHeight(14)
    .setColor(color(255))
    .setColorBackground(color(255, 0))
    .setColorForeground(color(0, 100));
  ;
  cp5.get(Textarea.class, "tutorial").setText("Please input speed and number of cycles. Then choose a mode. Either (1.) Manual or (2.) CYCLE : Automatic cycle control"
    +"\n"+"                                                                  Inputs: (Length , width , thickness)  and Outputs: (stress , load , strain)  are not yet implemented. Please ignore them."
    );






  cp5.get(Textarea.class, "tutorial").hide();//REMOVE IF YOU WANT TUTORIAL
}

void show_graph()
{
  rect(90, 25, 400, 250);
  for (i=25; i<275; i=i+25)
  {
    line(90, i, 490, i);
    stroke(230);
    if (250-i!=0)
    {
      text((250-i)/5,85, i+30);
    }
  }
  for (j=90; j<490; j=j+25)
  {
    line(j, 25, j, 275);
    stroke(230);
    if (j-90!=0)
    {
      text((j-90)/5, j+5, 290);
    }
  }
  textAlign(CENTER);
  text("STRESS", 290, 20);
}


void add_inputs()
{

  cp5.addTextfield("width")
    .setPosition(width*0.025,height*0.75)//.setPosition(20, 450)
    .setSize(round(width*0.09375),round(height/30))//.setSize(75, 20)
    .setFont(createFont("arial", 15))
    .setAutoClear(false)
    .setCaptionLabel("Width (in cm)")
    .getCaptionLabel()
    .toUpperCase(false)
    .setFont(createFont("arial", 15))
    ;



  cp5.addTextfield("length")
    .setPosition(width*0.2125,height*0.75)//.setPosition(170, 450)
    .setSize(round(width*0.09375),round(height/30))//.setSize(75, 20)
    .setFont(createFont("arial", 15))
    .setAutoClear(false)
    .setCaptionLabel("Length (in cm)")
    .getCaptionLabel()
    .toUpperCase(false)
    .setFont(createFont("arial", 15))
    ;


  cp5.addTextfield("thickness")
    .setPosition(width*0.4,height*0.75)//.setPosition(320, 450)
    .setSize(round(width*0.09375),round(height/30))//.setSize(75, 20)
    .setFont(createFont("arial", 15))
    .setAutoClear(false)
    .setCaptionLabel("Thickness (in mm)")
    .getCaptionLabel()
    .toUpperCase(false)
    .setFont(createFont("arial", 15))
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
    .setPosition(width*0.025,height*0.868333)//.setPosition(20, 521)
    .setRange(0, 255)
    .setValue(120)
    .setSize(round(width/8),round(height/30))//.setSize(100, 20)
    .getCaptionLabel()
    .toUpperCase(false)
    .setFont(createFont("arial", 15))
    .align(ControlP5.LEFT, ControlP5.BOTTOM_OUTSIDE);

  cp5.addTextfield("no_of_cycles")
    .setPosition(width*0.2125,height*0.868333)//.setPosition(170, 520)
    .setSize(round(width*0.09375),round(height/30))//.setSize(75, 20)
    .setFont(createFont("arial", 15))
    .setAutoClear(false)
    .setCaptionLabel("No. of cycles")
    .getCaptionLabel()
    .toUpperCase(false)
    .setFont(createFont("arial", 15))
    ;
  cp5.addTextfield("initial_distance")
    .setPosition(width*0.4,height*0.86833)//.setPosition(320, 520)
    .setSize(round(width*0.09375),round(height/30))//.setSize(75, 20)
    .setFont(createFont("arial", 15))
    .setAutoClear(false)
    .setCaptionLabel("Initial distance (stretch)")
    .getCaptionLabel()
    .toUpperCase(false)
    .setFont(createFont("arial", 15))

    ;
  cp5.get(Textfield.class, "width").setInputFilter(ControlP5.FLOAT);
  cp5.get(Textfield.class, "length").setInputFilter(ControlP5.FLOAT);
  cp5.get(Textfield.class, "thickness").setInputFilter(ControlP5.FLOAT);
  //cp5.get(Textfield.class,"speed").setInputFilter(ControlP5.FLOAT);
  cp5.get(Textfield.class, "no_of_cycles").setInputFilter(ControlP5.INTEGER);
  cp5.get(Textfield.class, "initial_distance").setInputFilter(ControlP5.FLOAT);



  cp5.get(Textfield.class, "initial_distance").setValue(String.valueOf(0.0));
  cp5.get(Textfield.class, "no_of_cycles").setValue(String.valueOf(10));
}

void lock_all()
{
  cp5.get(Textfield.class, "width").lock();
  cp5.get(Textfield.class, "length").lock();
  cp5.get(Textfield.class, "thickness").lock();
  cp5.get(Slider.class, "speed_slider").lock();
  cp5.get(Textfield.class, "no_of_cycles").lock();
  cp5.get(Textfield.class, "initial_distance").lock();
  cp5.getController("uppermost_point").lock();
  cp5.getController("lowermost_point").lock();
  cp5.getController("natural_point").lock();



  cp5.get(Textfield.class, "width").setColorBackground(0xff1381d6);
  cp5.get(Textfield.class, "length").setColorBackground(0xff1381d6);
  cp5.get(Textfield.class, "thickness").setColorBackground(0xff1381d6);
  cp5.get(Slider.class, "speed_slider").setColorBackground(0xff1381d6);
  cp5.get(Textfield.class, "no_of_cycles").setColorBackground(0xff1381d6);
  cp5.get(Textfield.class, "initial_distance").setColorBackground(0xff1381d6);
  cp5.getController("uppermost_point").setColorBackground(0xff1381d6);
  cp5.getController("lowermost_point").setColorBackground(0xff1381d6);
  cp5.getController("natural_point").setColorBackground(0xff1381d6);



  cp5.get(Textfield.class, "width").setColorValue(0xff000000);
  cp5.get(Textfield.class, "length").setColorValue(0xff000000);
  cp5.get(Textfield.class, "thickness").setColorValue(0xff000000);
  cp5.get(Slider.class, "speed_slider").setColorValue(0xff000000);
  cp5.get(Textfield.class, "no_of_cycles").setColorValue(0xff000000);
  cp5.get(Textfield.class, "initial_distance").setColorValue(0xff000000);
  cp5.getController("uppermost_point").setColorBackground(0xff000000);
  cp5.getController("lowermost_point").setColorBackground(0xff000000);
  cp5.getController("natural_point").setColorBackground(0xff000000);
}

void unlock_all()
{
  cp5.get(Textfield.class, "width").unlock();
  cp5.get(Textfield.class, "length").unlock();
  cp5.get(Textfield.class, "thickness").unlock();
  cp5.get(Slider.class, "speed_slider").unlock();
  cp5.get(Textfield.class, "no_of_cycles").unlock();
  cp5.get(Textfield.class, "initial_distance").unlock();
  cp5.getController("uppermost_point").unlock();
  cp5.getController("lowermost_point").unlock();
  cp5.getController("natural_point").unlock();

  cp5.get(Textfield.class, "width").setColorBackground(0xff002D5A);
  cp5.get(Textfield.class, "length").setColorBackground(0xff002D5A);
  cp5.get(Textfield.class, "thickness").setColorBackground(0xff002D5A);
  cp5.get(Slider.class, "speed_slider").setColorBackground(0xff002D5A);
  cp5.get(Textfield.class, "no_of_cycles").setColorBackground(0xff002D5A);
  cp5.get(Textfield.class, "initial_distance").setColorBackground(0xff002D5A);
  cp5.getController("uppermost_point").setColorBackground(0xff002D5A);
  cp5.getController("lowermost_point").setColorBackground(0xff002D5A);
  cp5.getController("natural_point").setColorBackground(0xff002D5A);



  cp5.get(Textfield.class, "width").setColorValue(0xffffffff);
  cp5.get(Textfield.class, "length").setColorValue(0xffffffff);
  cp5.get(Textfield.class, "thickness").setColorValue(0xffffffff);
  cp5.get(Slider.class, "speed_slider").setColorValue(0xffffffff);
  cp5.get(Textfield.class, "no_of_cycles").setColorValue(0xffffffff);
  cp5.get(Textfield.class, "initial_distance").setColorValue(0xffffffff);
  cp5.getController("uppermost_point").setColorValue(0xffffffff);
  cp5.getController("lowermost_point").setColorValue(0xffffffff);
  cp5.getController("natural_point").setColorValue(0xffffffff);
}





//-----------------------------------------------------------------
//                  creating outline of the graph  using pGraphics
//-----------------------------------------------------------------
void create_graph_outline() {
  pg.strokeWeight(1);
  pg.line(round(width*0.025), 0, round(width*0.025),round(height*2/3));//pg.line(20, 0, 20, 400);
  pg.line(0, round(height*19/30), round(width*0.75), round(height*19/30));//pg.line(0, 380, 600, 380);
  int j=max_val/10;
    for (int i=round(height*19/30)-round(height*19/30)/10; i>=0; i-=0.1*round(height*19/30)) //for (int i=380-38; i>=0; i-=0.1*380) 
    {
    pg.stroke(200);
    pg.line(round(width*0.025), i,  round(width*0.75), i);//pg.line(20, i, 600, i);
    pg.stroke(0);
    pg.fill(0);
    pg.text(j, 0, i);
    j+=max_val/10;
  }
  int k=max_dist/20;
  for (int i=round(height/12); i<=round(width); i+=0.05*round(height*29/30))//for (int i=49; i<=600; i+=0.05*580) 
  {
    pg.stroke(200);
    pg.line(i, 0, i, round(height*19/30));//pg.line(i, 0, i, 380);
    pg.stroke(0);
    pg.fill(0);
    pg.text(k, i, round(height*0.65));//pg.text(k, i, 390);
    k+=max_dist/20;
  }

  pg.fill(200, 20, 200);
  pg.text("displacement", round(width*0.225), round(height*2/3));//pg.text("displacement", 180, 400);
  pg.text("stress", round(width/80),round(height/60));//pg.text("stress", 10, 10);
  // pg.save(day()+"_"+month()+"_"+year()+"__"+hour()+":"+minute()+":"+second()+".png");
}