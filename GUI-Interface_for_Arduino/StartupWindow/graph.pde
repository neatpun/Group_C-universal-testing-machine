import processing.serial.*;
Serial myPort;


PFont f;



void createGraph1(){
rect(50,100,650,550);
for(int i=100;i<700;i+=50){
  stroke(220);
  line(50,i,700,i);
  fill(0);
  text(650-i,20,i);
  
}
for(int i=50;i<=700;i+=50){
   stroke(220);
  line(i,100,i,650);
  fill(0);
  text(i-50,i,665);
}

}




void plot(float prev_x,float prev_y,float curr_x,float curr_y){
  stroke(0);
  float x1=map(prev_x,0,1000,50,700);
  float x2=map(curr_x,0,1000,50,700);
  float y1=map(prev_y,0,1000,650,100);
  float y2=map(curr_y,0,1000,650,100);
  
  beginShape();
  vertex(x1,y1);
  vertex(x2,y2);
  endShape();

}


//float data(){
//if(myPort.available()>0){

//}
//}