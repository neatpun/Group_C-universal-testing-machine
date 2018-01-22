
float analogValueAverage = 0;

// How often do we do readings?
long time = 0; //
int timeBetweenReadings = 200; // We want a reading every 200 ms;

void setup() {
  Serial.begin(9600);
}

void loop() {
  int analogValue = analogRead(0);

  // running average - We smooth the readings a little bit
  analogValueAverage = 0.99*analogValueAverage + 0.01*analogValue;

  // Is it time to print?
  if(millis() > time + timeBetweenReadings){
    

    Serial.print("analogValueAVG: ");Serial.println(analogValueAverage);
    Serial.print("analogValue: ");Serial.println(analogValue);
    time = millis();
  }
}
