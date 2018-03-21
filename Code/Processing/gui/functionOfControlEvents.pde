// file for defining control events
import java.util.Date;
import java.text.SimpleDateFormat;

void export_table() {
  String path = sketchPath();
  //println(path);
  String[] filenames = listFileNames(path+"/data");
   //printArray(filenames);
  
  String name = new SimpleDateFormat("yyyy-MM-dd HH-mm-ss").format(new Date());

  
  
  println("THIS IS THE NAME OF THE FILE BEING EXPORTED "+name);
  saveTable(table, "data/new "+name+".csv");
  
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

  try {

    println(Arduino.list());
    arduino = new Arduino(this, Arduino.list()[0], 57600); //ENABLE
    arduino_enable = true; 
    cp5.get(Textfield.class, "enable_arduino").lock();
    
    if(arduino_enable) {
      for (int i = 0; i <= 13; i++)//ENABLE
      arduino.pinMode(i, Arduino.OUTPUT);//ENABLE
    }

  } catch(Exception e) {
    println("Arduino is not connected");
  }

}
