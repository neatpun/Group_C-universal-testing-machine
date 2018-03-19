// file for defining control events
import java.util.Date;
import java.text.SimpleDateFormat;
import static javax.swing.JOptionPane.*;

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

public void tut(){
showMessageDialog(null,  "Please input speed and number of cycles. Then choose a mode. Either (1.) Manual or (2.) CYCLE : Automatic cycle control"
    +"\n"+" Inputs: (Length , width , thickness)  and Outputs: (stress , load , strain)  are not yet implemented. Please ignore them.", 
    "Info", INFORMATION_MESSAGE);

}