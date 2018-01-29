
int vol_motor = 10; // voltage used to rotate motor
// pins 9 and 10 are used to set voltage across motor
int in1 = 9;
int in2 = 8;  
int i=0; // variable to increase or decrease the speed of motor

void setup() {
// set all the motor control pins to outputs
pinMode(vol_motor, OUTPUT);
pinMode(in1, OUTPUT);
pinMode(in2, OUTPUT);

}

void loop(){
// set the voltage across motor in one direction
digitalWrite(in1,HIGH);
digitalWrite(in2,LOW);
// increasing the speed
for(i=0;i<=255;i++){
  analogWrite(vol_motor,i); 
  delay(20); // motor increases its speed every 0.02 seconds
}
// decreasing the speed
for(i=255;i>=0;i++){
  analogWrite(vol_motor,i); 
  delay(20); // motor decreases its speed every 0.02 seconds
}

}

