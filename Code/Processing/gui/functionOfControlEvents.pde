// file for defining control events
import java.util.Date;
import java.text.SimpleDateFormat;
import static javax.swing.JOptionPane.*;

void export_table() {
  String path = sketchPath();
  //println(path);
  String[] filenames = listFileNames(path+"/data");
   //printArray(filenames);

  String name = new SimpleDateFormat("yyyy-MM-dd HH:mm").format(new Date());
  pg.save("data/"+name+"_manual/"+name+".png");


  println("THIS IS THE NAME OF THE FILE BEING EXPORTED "+name);
  saveTable(table, "data/"+name+"_manual/"+name+".csv");

}

String[] listFileNames(String dir) {
  File file = new File(dir);
  if (file.isDirectory()) {
    String names[] = file.list();
    return names;
  } else {
    // If it's not a directory
    return null;
  }
}

void enable_arduino() {

  reset();

  try {

    println(Arduino.list());
    arduino = new Arduino(this, Arduino.list()[0], 57600); //ENABLE
    arduino_enable = true;
    //cp5.get(Textfield.class, "enable_arduino").lock();
    cp5.getController("enable_arduino").hide();

    if(arduino_enable) {
      for (int i = 0; i <= 13; i++)//ENABLE
      arduino.pinMode(i, Arduino.OUTPUT);//ENABLE
    }

  } catch(Exception e) {
    println("Arduino is not connected");
    cp5.getController("enable_arduino").setColorForeground(color(246,29,29));
  }

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


// to lock and unlock Controls

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
