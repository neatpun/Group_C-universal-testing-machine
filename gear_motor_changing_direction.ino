
int vol_motor = 10; // voltage used to rotate motor
// pins 9 and 10 are used to set voltage across motor
int in1 = 9;
int in2 = 8;

void setup() {
// set all the motor control pins to outputs
pinMode(vol_motor, OUTPUT);
pinMode(in1, OUTPUT);
pinMode(in2, OUTPUT);
}

void loop() {

// set the voltage across motor in one direction
digitalWrite(in1, HIGH);
digitalWrite(in2, LOW);
// set speed to 200 out of possible range 0~255
analogWrite(vol_motor, 200);
// motor rotates for 2 seconds
delay(2000);

// changing the direction of rotation of motor
digitalWrite(in1, LOW);
digitalWrite(in2, HIGH);
// set speed to 200 out of possible range 0~255
analogWrite(vol_motor, 200);
// motor rotates for 2 seconds
delay(2000);

// turning of the motor
// applying 0 voltage across motor
digitalWrite(in1, LOW);
digitalWrite(in2, HIGH);
// motor stopd rotating for 2 seconds
delay(2000);

}
