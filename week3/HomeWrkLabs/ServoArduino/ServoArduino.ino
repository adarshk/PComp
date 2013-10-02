#include <Servo.h>


int servoMotorPin =2;
Servo servoMotor;

void setup(){

Serial.begin(9600);
servoMotor.attach(servoMotorPin);
}



void loop(){
  
  
  int reader = analogRead(A0);
  
  Serial.println(reader);
  
  int mappedServo= map(reader,0,1023,0,179);
  
 servoMotor.write(mappedServo);

//servoMotor.write(60); 
  
}
