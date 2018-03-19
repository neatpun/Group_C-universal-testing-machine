// file for defining control events
import java.util.Date;

void export_table() {
  String path = sketchPath();
  //println(path);
  String[] filenames = listFileNames(path+"/data");
   //printArray(filenames);
  
  String name = "new";

  // GENERATE A NEW FILE NAME
  for(int i = 0; i < filenames.length; i++) {
    
    //println("PRINTING FILENAMES[ I ] "+filenames[i]);
    
    String temp = "", temp1 = filenames[ i ];
    
    for(int j = 0; j < filenames[i].length(); j++) {
      if( temp1.charAt(j) == '.' ) break;
      temp += temp1.charAt(j);
    }
    
    println("TEMP IS "+temp);

    if( name.equals( temp ) ) {
      //println("IN THE LOOP");
      name += i+1;
    }

  }
  
  println("THIS IS THE NAME OF THE FILE BEING EXPORTED "+name);
  saveTable(table, "data/"+name+".csv");
  
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