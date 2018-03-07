


#include <VSync.h>

//  Create a new sender here
//  Put the number of variables you want to sync in the pointy brackets
//  Here we just want to sync one value
ValueSender<1> sender;
int loadcell_value=0;


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



void setup() {
  // initialize serial communication with computer:
  
  Serial.begin(19200);
  
  /////////
  // initialize all the readings to 0:
  for (int thisReading = 0; thisReading < numReadings; thisReading++) {
    readings[thisReading] = 0;
  }
  prev_time=millis();
///////////

  sender.observe(loadcell_value);
}
void loop() {
  
  //////////

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
  
  delay(1);        // delay in between reads for stability

}
