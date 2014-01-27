int sensorValue1;
int sensorValue2;
int sensorValue3;
int sensorValue4;
int sensorValue5;
int sensorValue6;
int sensorValue7;

int knockSensor = 3;               

byte val = 0;

int statePin = LOW;

int THRESHOLD = 100;

boolean selected = false;

const int switchPin = 2;      // digital input 

void setup() {
  Serial.begin(9600);
  
  pinMode(switchPin, OUTPUT);
  //establishContact();
}

void loop(){
  
  //A0, A2, A4 - pressure
  
  //A4 - yellow grnd, red - +ve
  //A3  - piezo
  //A1 - stretch



  sensorValue1 = analogRead(A0);
  Serial.print(sensorValue1, DEC);
  Serial.print(",");
  
  sensorValue2 = analogRead(A3);
  Serial.print(sensorValue2, DEC);
  Serial.print(",");
  
  
  sensorValue3 =analogRead(A6);
   // print the results:
  Serial.print(sensorValue3, DEC);
  Serial.print(",");
  
   sensorValue4 =analogRead(A9);
   // print the results:
  Serial.print(sensorValue4, DEC);
  Serial.print(",");
  
  
  sensorValue5 =analogRead(A12);
  Serial.println(sensorValue5, DEC);
  //Serial.print(",");
  /*
  sensorValue3 =analogRead(A3);
  Serial.print(sensorValue3, DEC);
  Serial.print(",");


  sensorValue1 =analogRead(A1);
  //print the results:
   Serial.println(sensorValue1, DEC);
  //Serial.print(",");
  
//  sensorValue1 =analogRead(A1);
//   // print the results:
//  Serial.print(sensorValue1, DEC);
//  Serial.print(",");
  

 
  /*
  sensorValue4 =digitalRead(2);
  Serial.print(sensorValue4, DEC);
  Serial.print(",");
  
  sensorValue5 =analogRead(A3);
  Serial.println(sensorValue5, DEC);
  //Serial.print(",");
  */
  
//  
//  sensorValue5 =analogRead(A4);
//  Serial.println(sensorValue5, DEC);
  
  delay(250);
  
}

void establishContact() {
 while (Serial.available() <= 0) {
      Serial.println("hello");   // send a starting message
      delay(300);
   }
 }

