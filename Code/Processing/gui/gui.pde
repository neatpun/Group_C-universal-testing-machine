
int counter=0;

//graph variables start
PGraphics pg;
int max_val=200;    // divisible by 10
int max_dist=1500;   // divisible by 20
//graph variable ends


import processing.serial.*;

import java.text.DecimalFormat;
import cc.arduino.*;

Arduino arduino;
//--VARIABLES
//ASSUMPTION: speed between 0 to 255    ; You start from the bottom with distance =0 ; DISTANCE scaling remaining
//------------------------------
//graph plotting variables
//--------------------------
import java.util.Random;
Random r=new Random();
float prev_x=0;
float prev_y=0;
float curr_y;


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

String name_of_folder;


int starting_time=0;



 


float[] readings = new float[10]; // For loadcell value smoothing
int readIndex=0;
float total=0;




//float distance_calibration=1.42;

double velocity_calibration=1.0;
//VARIABLES--


// INPUT DATA 
String wid;
double breadth;
String thick;
double thickness;
String len ;
double vertical_length ;
//double stress = (fake_distance-MIN_DOWN)/vertical_length;
double area;

double stress;//needs to updated in draw
double strain;//needs to updated in draw
//INPUT DATA DONE

import controlP5.*;
import java.util.*;

ControlP5 cp5;

int myColor = color(255);

int c1, c2;

float n, n1;
//float f1,f2;

int i=25;
int j=90;

void setup() {
  //displayWidth  displayHeight
  //f1=displayWidth/1024.0/2;

  //f2=displayHeight/768.0/2;


  surface.setSize( (int) (0.585651537 * displayWidth), (int) (0.78125*displayHeight) );

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

    //println(Arduino.list());
    arduino = new Arduino(this, Arduino.list()[0], 57600); //ENABLE
    arduino_enable = true;
    //cp5.get(Textfield.class, "enable_arduino").lock();
    cp5.getController("enable_arduino").hide();
  } 
  catch(Exception e) {
    println("Arduino is not connected");
    cp5.getController("enable_arduino").setColorForeground(color(246, 29, 29));
  }



  if (arduino_enable) {
    for (int i = 0; i <= 13; i++)//ENABLE
      arduino.pinMode(i, Arduino.OUTPUT);//ENABLE
  }



  table = createTable();
  

}


void draw() {
  background(0, 0, 0);

  if (mode=="manual" || mode=="MAIN_CYCLE_RUNNING") {

    if (mode=="MAIN_CYCLE_RUNNING" && fake_distance>0)
    {
      if (arduino_enable) {
        curr_y=loadcell_data(prev_y);
        println(curr_y);
      } else
        curr_y=(100 + r.nextInt(max_val-100))*(float)((Math.log(fake_distance+1)/Math.log(MAX_UP))*(fake_distance/MAX_UP));
      loadcell_value=curr_y;
    } else if (mode=="MAIN_CYCLE_RUNNING") {
      if (arduino_enable) {
        curr_y=loadcell_data(prev_y);
        println(curr_y);
      } else

        curr_y=(r.nextInt(50))*(float)(Math.pow(fake_distance/MIN_DOWN, 2));
      loadcell_value=curr_y;
    } else if (mode=="manual" && fake_distance>0)
    {	
      if (arduino_enable) {
        curr_y=loadcell_data(prev_y);
        println(curr_y);
      } else
        curr_y=(190 + r.nextInt(max_val-190))*(float)((Math.log(fake_distance)/Math.log(1500))*(fake_distance/1500));
      loadcell_value=curr_y;
    } else if (mode=="manual")
    {	
      if (arduino_enable) {
        curr_y=loadcell_data(prev_y);
        println(curr_y);
      } else
        curr_y=(40+r.nextInt(50-40))*(float)(Math.pow(fake_distance/-1500, 2));
      loadcell_value=curr_y;
    }

    draw_graph(prev_x, prev_y, (float)fake_distance, curr_y);

    prev_x=(float)fake_distance;
    prev_y=curr_y;
  }

  if (fake_distance<=-1500 || fake_distance>=1500)reset();   // reset for now (will add diff func later

  // show_graph();
  image(pg, 10, 30);         // this will show the graph

  if (mode=="MAIN_CYCLE_RUNNING")
  {
    cycle_control();


    //loadread
    //loadcell_value=random(10);
    //transferred to graph , see above

    fake_distance=real_distance + velocity*(millis()-event_time)/1000;

    cp5.get(Slider.class, "motor_simulate").setValue((float)fake_distance);
    cp5.get(Textfield.class, "distance").setValue(df.format(fake_distance));
    cp5.get(Textfield.class, "PANEL_cycle").setValue(df.format(current_cycle/2.0));


    if (fake_distance>0)
      strain = (fake_distance)/vertical_length;
    else
      strain = 0;

    stress=loadcell_value/area;
    stress=stress/1000;

    cp5.get(Textfield.class, "strain").setValue(df.format(strain));
    cp5.get(Textfield.class, "load").setValue(df.format(loadcell_value));
    cp5.get(Textfield.class, "stress").setValue(df.format(stress));
    newRow = addRow(table);
    setRowData(newRow);


    delay(100);
  } else if (mode=="MAIN_CYCLE_DONE")
  {
    println("donezo");

    mode="initial";
    reset();
  } else if (mode=="manual")
  {
    //loadread
    //loadcell_value=random(10);//set in graph instead




    fake_distance=real_distance + velocity*(millis()-event_time)/1000;
    //println(fake_distance);

    cp5.get(Slider.class, "motor_simulate").setValue((float)fake_distance);
    cp5.get(Textfield.class, "distance").setValue(df.format(fake_distance));
    cp5.get(Textfield.class, "PANEL_cycle").setValue(df.format(current_cycle/2.0));


    if (fake_distance>0)
      strain = (fake_distance)/vertical_length;
    else
      strain = 0;

    stress=loadcell_value/area;
    stress=stress/1000;

    cp5.get(Textfield.class, "strain").setValue(df.format(strain));
    cp5.get(Textfield.class, "load").setValue(df.format(loadcell_value));
    cp5.get(Textfield.class, "stress").setValue(df.format(stress));
    newRow = addRow(table);
    setRowData(newRow);
  } else
  {
    // println("real_dist : " + real_distance + "  vel: " + velocity + "  eventT: " + event_time+"  fak: " + fake_distance);
    fake_distance=real_distance + velocity*(millis()-event_time)/1000;
    cp5.get(Slider.class, "motor_simulate").setValue((float)fake_distance);
    cp5.get(Textfield.class, "distance").setValue(df.format(fake_distance));

    //println("mode is + " + mode.contains("PAUSE") + "     " + mode);

    if ( !(mode.contains("pause") || mode.contains("PAUSE")) ) {
      cp5.get(Textfield.class, "PANEL_cycle").setValue(df.format(0));
    }
  }
}




//CONTROL EVENTS

void choose_mode(int n) {


  cp5.getController("enable_arduino").hide();

  fix_input();
  hide_controls();
  real_distance=0;
  cp5.get(ScrollableList.class, "choose_mode").hide(); // LOCK NOT WORKING , why??
  cp5.get(ScrollableList.class, "choose_mode").setColorBackground(0xff1381d6);
  cp5.get(ScrollableList.class, "choose_mode").setColorValue(0xff000000);
  if (n==0)
  {
    name_of_folder="MANUAL " + new SimpleDateFormat("yyyy-MM-dd HH-mm-ss").format(new Date());
    cp5.getController("up").show();
    cp5.getController("pause").show();
    cp5.getController("down").show();
    mode="manual_begin";


    cp5.get(Textarea.class, "tutorial").setText("In manual mode , when you click 'UP' the motor moves in one direction , when you click 'PAUSE' it stops and when you click 'DOWN' it moves in opposite direction"
      );
  } else if (n==1)
    //  {cp5.getController("run").show();
    //cp5.getController("pause_cycles").show();
    //cp5.getController("cycle_length").show();
    //mode="cycle_begin";

    //} else if (n==1)//2
  {
    name_of_folder="CYCLE "+ new SimpleDateFormat("yyyy-MM-dd HH-mm-ss").format(new Date());
    cp5.getController("up3").show();
    cp5.getController("pause3").show();
    cp5.getController("down3").show();
    cp5.getController("set_natural").show();

    //cp5.getController("uppermost_point").show();
    //cp5.getController("lowermost_point").show();
    //cp5.getController("natural_point").show();

    cp5.getController("natural_point").hide();
    cp5.getController("uppermost_point").hide();
    cp5.getController("lowermost_point").hide();

    //cp5.getController("export_table").hide();

    //cp5.getController("lowermost_point").lock();
    //cp5.getController("natural_point").unlock();
    //cp5.getController("uppermost_point").lock();

    mode="3pointcycle_begin";



    cp5.get(Textarea.class, "tutorial").setText("Use the controls and when you arrive at natural point of material (0 compression and 0 streching ) click 'SET NATURAL POINT'. Then that point will act as origin (distance 0)."
      );
  }
}

public void fix_input() {
  lock_all();

  cycles_needed=2*Integer.parseInt(cp5.get(Textfield.class, "no_of_cycles").getText());


  wid=cp5.get(Textfield.class, "width").getText();
  breadth=Double.parseDouble(wid);
  thick =cp5.get(Textfield.class, "thickness").getText();
  thickness =Double.parseDouble(thick);
  len =cp5.get(Textfield.class, "length").getText();
  vertical_length =Double.parseDouble(len);
  area= breadth*thickness*0.00001;//converting into metre square
  
  
  
  
    readings = new float[10]; // For loadcell value smoothing
readIndex=0;
 total=0;
 
}
public void reset()
{
  name_of_folder="UNDEFINED "+new SimpleDateFormat("yyyy-MM-dd HH-mm-ss").format(new Date());

  createTable();

  prev_x=0;
  prev_y=0;
  mode = "initial";
  unlock_all();
  hide_controls();

  //cp5.getController("export_table").show();

  cp5.get(ScrollableList.class, "choose_mode").show();
  cp5.get(ScrollableList.class, "choose_mode").open();
  cp5.get(ScrollableList.class, "choose_mode").setCaptionLabel("choose_mode");

  cp5.get(Textfield.class, "width").setColorBackground(0xff002D5A);
  cp5.get(Textfield.class, "width").setColorValue(0xffffffff);


  cp5.get(Textarea.class, "tutorial").setText("Please input speed and number of cycles. Then choose a mode. Either (1.) Manual or (2.) CYCLE : Automatic cycle control"
    +"\n"+"                                                                  Inputs: (Length , width , thickness)  and Outputs: (stress , load , strain)  are not yet implemented. Please ignore them."
    );

  fake_distance = 0;

  event_time = 0;

  velocity = 0;

  real_distance = 0;

  current_cycle = 0;

  cp5.getController("motor_simulate").setValue(0);


  if (arduino_enable) {
    arduino.digitalWrite(8, 0);//ENABLE
    arduino.digitalWrite(7, 0);//ENABLE
  }

  cp5.get(Textfield.class, "uppermost_point").setValue(String.valueOf(0));
  cp5.get(Textfield.class, "lowermost_point").setValue(String.valueOf(0));
  cp5.get(Textfield.class, "load").setValue(String.valueOf(0.0));
  cp5.get(Textfield.class, "strain").setValue(String.valueOf(0.0));
  cp5.get(Textfield.class, "stress").setValue(String.valueOf(0.0));

  pg = createGraphics(round(width*0.75), round(height*2/3));//pg = createGraphics(600, 400); //graph

  pg.beginDraw();
  pg.background(255);
  create_graph_outline();
  pg.stroke(30);
  pg.endDraw();    // end graph



  if (arduino_enable != true) {
    cp5.getController("enable_arduino").show();
    try {

      println(Arduino.list());
      arduino = new Arduino(this, Arduino.list()[0], 57600); //ENABLE
      arduino_enable = true;
      //cp5.get(Textfield.class, "enable_arduino").lock();
      cp5.getController("enable_arduino").hide();
    } 
    catch(Exception e) {
      println("Arduino is not connected");
      cp5.getController("enable_arduino").setColorForeground(color(246, 29, 29));
    }
  }
}


//FUNCTIONALITY

public void up()
{
  if (mode.equals("manual_begin")  ) {
    event_time=millis(); 
    mode="manual";
    starting_time=event_time;

    if (arduino_enable) {
      arduino.analogWrite(10, speed_slider);//ENABLE
    }
  } else if ( mode.equals("cycle_begin")  ) {
    event_time=millis(); 
    mode="cycle";

    if (arduino_enable) {
      arduino.analogWrite(10, speed_slider);//ENABLE
    }
  } else {
    real_distance+=velocity*(millis()-event_time)/1000;
  }

  //motor control
  if (mode.equals("manual_pause")) {

    if (arduino_enable) {
      arduino.analogWrite(10, speed_slider); // NOT NECCESARRY
    }

    mode="manual";
  }

  if (arduino_enable) {
    arduino.digitalWrite(8, 1);//ENABLE
    arduino.digitalWrite(7, 0);//ENABLE
  }

  event_time=millis();




  current_direction="up";


  velocity=speed_slider*velocity_calibration;
  cp5.get(Textlabel.class, "debug").setText("dist:"+Double.toString(real_distance )+ " mode:" + mode
    + " dir:"+ current_direction + " vel:"+ Double.toString(velocity) + " event_time:" + event_time);
}

public void pause ()
{

  real_distance+=velocity*(millis()-event_time)/1000;




  if (arduino_enable) {
    arduino.digitalWrite(8, 0);//ENABLE
    arduino.digitalWrite(7, 0);//ENABLE
  }


  mode="manual_pause";

  event_time=millis();

  //When_resumed=current_direction //probs unneccesary

  velocity=0;
  cp5.get(Textlabel.class, "debug").setText("dist:"+Double.toString(real_distance )+ " mode:" + mode
    + " dir:"+ current_direction + " vel:"+ Double.toString(velocity) + " event_time:" + event_time);
}



public void down()
{
  if (mode.equals("manual_begin")  ) {
    event_time=millis(); 
    mode="manual";
    starting_time=event_time;

    if (arduino_enable) {
      arduino.analogWrite(10, speed_slider);//ENABLE
    }
  } else if ( mode.equals("cycle_begin")  ) {
    event_time=millis(); 
    mode="cycle";

    if (arduino_enable) {
      arduino.analogWrite(10, speed_slider);//ENABLE
    }
  } else {
    real_distance+=velocity*(millis()-event_time)/1000;
  }

  //motor control
  if (mode.equals("manual_pause")) {

    if (arduino_enable) {
      arduino.analogWrite(10, speed_slider); // NOT NECCESARRY
    }

    mode="manual";
  }

  if (arduino_enable) {
    arduino.digitalWrite(8, 0);//ENABLE
    arduino.digitalWrite(7, 1);//ENABLE
  }

  event_time=millis();




  current_direction="down";


  velocity=-speed_slider*velocity_calibration;
  cp5.get(Textlabel.class, "debug").setText("dist:"+Double.toString(real_distance )+ " mode:" + mode
    + " dir:"+ current_direction + " vel:"+ Double.toString(velocity) + " event_time:" + event_time);
}







//3POINTCYCLE


public void up3()
{
  if (mode.equals("3pointcycle_begin")  ) {
    event_time=millis(); 
    mode="3pointcycle";
    if (arduino_enable) {
      arduino.analogWrite(10, speed_slider);//ENABLE
    }
  } else {
    real_distance+=velocity*(millis()-event_time)/1000;
  }


  if (arduino_enable) {
    arduino.digitalWrite(8, 1);//ENABLE
    arduino.digitalWrite(7, 0);//ENABLE
  }

  event_time=millis();




  current_direction="up";


  velocity=speed_slider*velocity_calibration;
  cp5.get(Textlabel.class, "debug").setText("dist:"+Double.toString(real_distance )+ " mode:" + mode
    + " dir:"+ current_direction + " vel:"+ Double.toString(velocity) + " event_time:" + event_time);
}

public void pause3 ()
{

  real_distance+=velocity*(millis()-event_time)/1000;




  if (arduino_enable) {
    arduino.digitalWrite(8, 0);//ENABLE
    arduino.digitalWrite(7, 0);//ENABLE
  }


  mode="3pointcycle_pause";

  event_time=millis();

  //When_resumed=current_direction //probs unneccesary

  velocity=0;
  cp5.get(Textlabel.class, "debug").setText("dist:"+Double.toString(real_distance )+ " mode:" + mode
    + " dir:"+ current_direction + " vel:"+ Double.toString(velocity) + " event_time:" + event_time);
}



public void down3()
{
  if (mode.equals("3pointcycle_begin")  ) {
    event_time=millis(); 
    mode="3pointcycle";
    if (arduino_enable) {
      arduino.analogWrite(10, speed_slider);
    }
  } else {
    real_distance+=velocity*(millis()-event_time)/1000;
  }

  //motor control

  if (arduino_enable) {
    arduino.digitalWrite(8, 0);//ENABLE
    arduino.digitalWrite(7, 1);//ENABLE
  }

  event_time=millis();




  current_direction="down";


  velocity=-speed_slider*velocity_calibration;
  cp5.get(Textlabel.class, "debug").setText("dist:"+Double.toString(real_distance )+ " mode:" + mode
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

  //cp5.getController("lowermost_point").lock();
  //cp5.getController("natural_point").lock();
  //cp5.getController("uppermost_point").unlock();
  cp5.getController("uppermost_point").unlock();
  cp5.getController("lowermost_point").lock();

  cp5.getController("uppermost_point").show();
  cp5.getController("lowermost_point").hide();

  cp5.get(Textarea.class, "tutorial").setText("Use the controls and when you arrive at uppermost point of your desired cycle (maximum compression  ) click 'SET UPPERMOST POINT'. Then that point will be the topmost point of cycle."
    );
}
public void set_up()
{
  pause3 ();
  fake_distance=real_distance + velocity*(millis()-event_time)/1000;

  String uppermost_point=cp5.get(Textfield.class, "uppermost_point").getText();
  //println(uppermost_point);
  MAX_UP=Double.parseDouble(uppermost_point);
  if (MAX_UP==0) {
    MAX_UP=fake_distance;
    cp5.get(Textfield.class, "uppermost_point").setValue(df.format(fake_distance));
  }

  //cp5.getController("uppermost_point").lock();
  //cp5.getController("lowermost_point").unlock();
  //cp5.getController("natural_point").lock();
  cp5.getController("uppermost_point").lock();
  cp5.getController("lowermost_point").unlock();

  cp5.getController("uppermost_point").hide();
  cp5.getController("lowermost_point").show();

  cp5.getController("set_up").hide();
  cp5.getController("set_down").show();
  cp5.getController("down3").show();
  cp5.getController("up3").hide();


  cp5.get(Textarea.class, "tutorial").setText("Use the controls and when you arrive at lowermost point of your desired cycle (maximum streching  ) click 'SET LOWERMOST POINT'. Then that point will be the lowest point of cycle."
    );
}
public void set_down()
{
  pause3 ();
  fake_distance=real_distance + velocity*(millis()-event_time)/1000;

  String lowermost_point=cp5.get(Textfield.class, "lowermost_point").getText();
  //println(lowermost_point);
  MIN_DOWN=Double.parseDouble(lowermost_point);
  if (MIN_DOWN==0) {
    MIN_DOWN=fake_distance;
    cp5.get(Textfield.class, "lowermost_point").setValue(df.format(fake_distance));
  }
  cp5.getController("uppermost_point").show();
  cp5.getController("lowermost_point").show();

  cp5.getController("uppermost_point").lock();
  cp5.getController("lowermost_point").lock();
  //cp5.getController("natural_point").lock();


  cp5.getController("set_down").hide();
  cp5.getController("up3").hide();
  cp5.getController("down3").hide();
  cp5.getController("pause3").hide();

  mode="MAIN_CYCLE_BEGIN";
  cp5.getController("run3").show();
  cp5.getController("pause_cycles3").show();


  cp5.get(Textarea.class, "tutorial").setText("Click 'RUN' to start automatic cycle control. You can 'PAUSE' whenever you wantand then 'RUN' again. After the cycles are finished the motor will stop and a new file will be ed to the data folder with all collected data."
    );
}




public void cycle_control()
{
  if (mode=="MAIN_CYCLE_RUNNING")
  {

    // println(counter++);

    fake_distance=real_distance + velocity*(millis()-event_time)/1000;

    if (current_cycle >= cycles_needed)
    {
      velocity=0;
      //speed_slider=0; NO

      mode="MAIN_CYCLE_DONE";
      if (arduino_enable) {
        arduino.analogWrite(10, 0);//ENABLE
        arduino.digitalWrite(8, 0);//ENABLE
        arduino.digitalWrite(7, 0);//ENABLE
      }


      //String name = new SimpleDateFormat("yyyy-MM-dd HH:mm").format(new Date());
      //String name = new SimpleDateFormat("yyyy-MM-dd HH-mm-ss").format(new Date());

      saveTable(table, "data/"+name_of_folder+"/final_cycle_data"+".csv");

      cp5.get(Textlabel.class, "debug").setText("Cycles are finished. File 'new.csv' has been exported to 'data/new.csv'"
        );
    } else if ((fake_distance< 0.95*MIN_DOWN ) && (current_direction=="down"))
    {
      real_distance+=velocity*(millis()-event_time)/1000;

      if (arduino_enable) {
        //up
        arduino.digitalWrite(8, 1);//ENABLE
        arduino.digitalWrite(7, 0);//ENABLE
      }

      event_time=millis();
      current_direction="up";
      
      pause_cycles3();//becasue graph saving is slow


      velocity=speed_slider*velocity_calibration;
      current_cycle++;
      save_reset(current_cycle);
      println(current_cycle);
      cp5.get(Textlabel.class, "debug").setText("dist:"+Double.toString(real_distance )+ " mode:" + mode
        + " dir:"+ current_direction + " vel:"+ Double.toString(velocity) + " event_time:" + event_time + " current_cycle:"+ Double.toString(current_cycle/2) );
        
      run3(); //becasue graph saving is slow
    } else if ((fake_distance> 0.95*MAX_UP)  && (current_direction=="up"))
    {

      real_distance+=velocity*(millis()-event_time)/1000;

      if (arduino_enable) {
        // down
        arduino.digitalWrite(8, 0);//ENABLE
        arduino.digitalWrite(7, 1);//ENABLE
      }

      event_time=millis();
      current_direction="down";
      
      
      pause_cycles3();//becasue graph saving is slow


      velocity=-speed_slider*velocity_calibration;
      current_cycle++;
      save_reset(current_cycle);
      cp5.get(Textlabel.class, "debug").setText("dist:"+Double.toString(real_distance )+ " mode:" + mode
        + " dir:"+ current_direction + " vel:"+ Double.toString(velocity) + " event_time:" + event_time + " current_cycle:"+ Double.toString(current_cycle/2) );
        
     run3(); //becasue graph saving is slow
    }
  }
}

public void run3()
{

  if (mode=="MAIN_CYCLE_BEGIN")
  {




    //distance right now is MIN_DOWN

    real_distance+=velocity*(millis()-event_time)/1000;

    if (arduino_enable) {
      //up
      arduino.digitalWrite(8, 1);//ENABLE
      arduino.digitalWrite(7, 0);//ENABLE
    }

    event_time=millis();
    current_direction="up";
    current_cycle=0;

    velocity=speed_slider*velocity_calibration;



    mode="MAIN_CYCLE_RUNNING";
    cp5.get(Textlabel.class, "debug").setText("dist:"+Double.toString(real_distance )+ " mode:" + mode
      + " dir:"+ current_direction + " vel:"+ Double.toString(velocity) + " event_time:" + event_time);

    starting_time=event_time;
  } else if (mode=="MAIN_CYCLE_PAUSE")
  {

    if (current_direction=="up")
    {

      real_distance+=velocity*(millis()-event_time)/1000;

      if (arduino_enable) {
        //up
        arduino.digitalWrite(8, 1);//ENABLE
        arduino.digitalWrite(7, 0);//ENABLE
      }

      event_time=millis();
      current_direction="up";


      velocity=speed_slider*velocity_calibration;



      mode="MAIN_CYCLE_RUNNING";
      cp5.get(Textlabel.class, "debug").setText("dist:"+Double.toString(real_distance )+ " mode:" + mode
        + " dir:"+ current_direction + " vel:"+ Double.toString(velocity) + " event_time:" + event_time);
    } else if (current_direction=="down")
    {


      real_distance+=velocity*(millis()-event_time)/1000;

      if (arduino_enable) {
        //down
        arduino.digitalWrite(8, 0);//ENABLE
        arduino.digitalWrite(7, 1);//ENABLE
      }

      event_time=millis();
      current_direction="down";


      velocity=-speed_slider*velocity_calibration;


      mode="MAIN_CYCLE_RUNNING";
      cp5.get(Textlabel.class, "debug").setText("dist:"+Double.toString(real_distance )+ " mode:" + mode
        + " dir:"+ current_direction + " vel:"+ Double.toString(velocity) + " event_time:" + event_time);
    }
  }
}
public void pause_cycles3()
{
  real_distance+=velocity*(millis()-event_time)/1000;


  if (arduino_enable) {
    arduino.digitalWrite(8, 0);//ENABLE
    arduino.digitalWrite(7, 0);//ENABLE
  }


  mode="MAIN_CYCLE_PAUSE";

  event_time=millis();



  velocity=0;
  cp5.get(Textlabel.class, "debug").setText("dist:"+Double.toString(real_distance )+ " mode:" + mode
    + " dir:"+ current_direction + " vel:"+ Double.toString(velocity) + " event_time:" + event_time);
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
      text((250-i)/5, 85, i+30);
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



//-----------------------------------------------------------------
//                  creating outline of the graph  using pGraphics
//-----------------------------------------------------------------
void create_graph_outline() {
  pg.strokeWeight(1);
  pg.line(round(width*0.025), 0, round(width*0.025), round(height*2/3));//pg.line(20, 0, 20, 400);
  pg.line(0, round(height*19/30), round(width*0.75), round(height*19/30));//pg.line(0, 380, 600, 380);
  int j=max_val/10;
  for (int i=round(height*19/30)-round(height*19/30)/10; i>=0; i-=0.1*round(height*19/30)) //for (int i=380-38; i>=0; i-=0.1*380)
  {
    pg.stroke(200);
    pg.line(round(width*0.025), i, round(width*0.75), i);//pg.line(20, i, 600, i);
    pg.stroke(0);
    pg.fill(0);
    pg.text(j, 0, i);
    j+=max_val/10;
  }
  int k=max_dist/10;
  for (int i=round(height/12); i<=round(width); i+=0.05*round(height*29/30))//for (int i=49; i<=600; i+=0.05*580)
  {
    pg.stroke(200);
    pg.line(i, 0, i, round(height*19/30));//pg.line(i, 0, i, 380);
    pg.stroke(0);
    pg.fill(0);
    pg.text(k-max_dist, i, round(height*0.65));//pg.text(k, i, 390);
    k+=max_dist/10;
  }

  pg.fill(200, 20, 200);
  pg.text("displacement", round(width*0.225), round(height*2/3));//pg.text("displacement", 180, 400);
  pg.text("stress", round(width/80), round(height/60));//pg.text("stress", 10, 10);
  // pg.save(day()+"_"+month()+"_"+year()+"__"+hour()+":"+minute()+":"+second()+".png");
}

void draw_graph(float prev_x, float prev_y, float curr_x, float curr_y) {
  float x=map(prev_x, -max_dist, max_dist, width*0.025, width*0.75);
  float y=map(prev_y, 0, max_val, height*19/30, 0);
  float u=map(curr_x, -max_dist, max_dist, width*0.025, width*0.75);
  float v=map(curr_y, 0, max_val, height*19/30, 0);

  pg.beginDraw();
  pg.line(x, y, u, v);
  pg.endDraw();
}


// save and reset graph

void save_reset(int cycle) {
  //String name = new SimpleDateFormat("yyyy-MM-dd HH-mm").format(new Date());
  pg.save("data/"+name_of_folder+"/cycle_"+(float)cycle/2+".png");
  pg = createGraphics(round(width*0.75), round(height*2/3));//pg = createGraphics(600, 400); //graph

  pg.beginDraw();
  pg.background(255);
  create_graph_outline();
  pg.stroke(30);
  pg.endDraw();    // end graph
}

float loadcell_data(float prev) {
  float x;

  
  try {
   //x=arduino.analogRead(0);//single reading
    
    
    
    
      // subtract the last reading:
  total = total - readings[readIndex];
  // read from the sensor:
  readings[readIndex] = arduino.analogRead(0);
  // add the reading to the total:
  total = total + readings[readIndex];
  // advance to the next position in the array:
  readIndex = readIndex + 1;

  // if we're at the end of the array...
  if (readIndex >= 10) {
    // ...wrap around to the beginning:
    readIndex = 0;
  }

  // calculate the average:
  x = total / 10;
  
  
  
  
  
  
  
    x=map(x, 0, 900, 0, 200);
    println(x);
  }
  catch(Exception e) {
    x=prev;
  }
  return x;
}