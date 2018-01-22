

// How often do we do readings?
long time = 0; //
int timeBetweenReadings = 200; // We want a reading every 200 ms;

void setup() {
  Serial.begin(9600);
  
}

void loop() {
  int analogValue = analogRead(0);

    Serial.println(analogValue);
    delay(100);

}
