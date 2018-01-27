import processing.serial.*;
Serial myPort;

String val="000";
PFont f;
float x;


void createGraph1() {
  rect(50, 100, 650, 550);
  for (int i=100; i<700; i+=50) {
    stroke(220);
    line(50, i, 700, i);
    fill(0);
    text(650-i, 20, i);
  }
  for (int i=50; i<=700; i+=50) {
    stroke(220);
    line(i, 100, i, 650);
    fill(0);
    text(i-50, i, 665);
  }
}




void plot(float prev_x, float prev_y, float curr_x, float curr_y) {
  stroke(0);
  float x1=map(prev_x, 0, 1000, 50, 700);
  float x2=map(curr_x, 0, 1000, 50, 700);
  float y1=map(prev_y, 0, 1000, 650, 100);
  float y2=map(curr_y, 0, 1000, 650, 100);

  beginShape();
  vertex(x1, y1);
  vertex(x2, y2);
  endShape();
}


float data(float prev_d) {      // to retrieve data from the arduino
  if (myPort.available()>0) {
    val=myPort.readStringUntil('\n');
    try {
      x=Float.parseFloat(val);
    }
    catch(NumberFormatException e) {
      x=prev_d;
    }
  } 

  return x;
}

float p1=0,p2=0,q1=0,q2=0;  // q1 and q2 are data corresponding to x axis $$ p1 and p2 to y axis



void plot_graph(){              // function to plot the graph
p2=data(p1);
println(p2);                      // print catched data
q2+=2;
if(q2>=1000) noLoop();
else loop();

plot(q1,p1,q2,p2);
  q1=q2;
  p1=p2;
  
 delay(300);
}