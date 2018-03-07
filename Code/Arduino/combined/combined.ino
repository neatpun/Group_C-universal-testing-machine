


#include <VSync.h>

//  Create a new sender here
//  Put the number of variables you want to sync in the pointy brackets
//  Here we just want to sync one value

//  Create a new sender here
//  Put the number of variables you want to sync in the pointy brackets
ValueSender<1> sender;

//  Create a new receiver here
//  It can receive one value
ValueReceiver<1> receiver;

int loadcell_value=0;//send
int motor_speed=0;//receive //signed: +255 means max up, 0 means stationary, -255 means max down


//////////

const int numReadings = 10;
unsigned long current_time,prev_time;

int readings[numReadings];      // the readings from the analog input
int readIndex = 0;              // the index of the current reading
int total = 0;                  // the running total
int average = 0;                // the average

//int inputPin = A0;
int inputPin = 0;


///////////






int vol_motor = 10; // voltage used to rotate motor
// pins 9 and 10 are used to set voltage across motor
int in1 = 9;
int in2 = 8;




void setup() {
  // initialize serial communication with computer:
  
  Serial.begin(19200);
  
  /////////
  // initialize all the readings to 0:
  for (int thisReading = 0; thisReading < numReadings; thisReading++) {
    readings[thisReading] = 0;
  }
  prev_time=millis();





  pinMode(vol_motor, OUTPUT);
pinMode(in1, OUTPUT);
pinMode(in2, OUTPUT);
///////////

//  Tell the sender what variables to observe and keep in sync.
  //  Be sure to keep the order of variables the same on the receiving and the sending end!
  sender.observe(loadcell_value);

  //  Tell the receiver what values to sync
  //  Here you need to take care of the order as well!
  receiver.observe(motor_speed);

  

  
}
void read_from_loadcell()

{


  
  // subtract the last reading:
  total = total - readings[readIndex];
  // read from the sensor:
  readings[readIndex] = analogRead(inputPin);
  // add the reading to the total:
  total = total + readings[readIndex];
  // advance to the next position in the array:
  readIndex = readIndex + 1;

  // if we're at the end of the array...
  if (readIndex >= numReadings) {
    // ...wrap around to the beginning:
    readIndex = 0;
  }

  // calculate the average:
  average = total / numReadings;

  
  ///////////

  
  loadcell_value=average;



  
  // send it to the computer as ASCII digits
  current_time=millis();
  if((current_time-prev_time)>100)
  {
      sender.sync();
    prev_time=millis();
  }
  
  }


  
void loop() {
    //  for the receiver and for the sender you must call sync() once in every loop.
  //  It does not matter where in the loop you call it, 
  //  but receiving at the start and sending at the end makes most sense.

read_from_loadcell();

  receiver.sync();

  

if(motor_speed>=0)

{
digitalWrite(in1, HIGH);
digitalWrite(in2, LOW);

analogWrite(vol_motor, motor_speed);
}
else 
{digitalWrite(in1, LOW);
digitalWrite(in2, HIGH);
analogWrite(vol_motor, -motor_speed);
}

  

  
  delay(1);        // delay in between reads for stability

}


