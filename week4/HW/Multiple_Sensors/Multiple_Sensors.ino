//Multiple sensors

int sensorValue1;
int sensorValue2;
int sensorValue3;

boolean selected = false;

const int switchPin = 2;      // digital input 

void setup() {
  Serial.begin(9600);
  
  pinMode(switchPin, INPUT);
  //establishContact();
}


void loop() {
    
  //if (Serial.available() > 0) {
     // read the incoming byte:
    int inByte =Serial.read();
   // read the sensor:
   sensorValue1 =analogRead(A0);
   // print the results:
  Serial.print(sensorValue1, DEC);
  Serial.print(",");

   // read the sensor:
   sensorValue2 =analogRead(A1);
   // print the results:
  Serial.print(sensorValue2, DEC);
  Serial.print(",");

   // read the sensor:
   sensorValue3 =digitalRead(2);
   // print the last sensor value with a println() so that
   // each set of four readings prints on a line by itself:
  Serial.println(sensorValue3, DEC);
   //}
  
  /*
  int sensorValue = analogRead(A0);
   // print the results:
   Serial.print(sensorValue);
   Serial.print(",");

   // read the sensor:
   sensorValue = analogRead(A1);
   // print the results:
   Serial.print(sensorValue);
   Serial.print(",");

   // read the sensor:
   sensorValue = digitalRead(switchPin);
   // print the last reading with a println() so that
   // each set of three readings prints on a line by itself:
   Serial.println(sensorValue);
  /*
  for (int thisSensor = 0; thisSensor < 2; thisSensor++) {
       int sensorValue = analogRead(thisSensor);
       Serial.print(sensorValue, DEC);

       // if this is the last sensor value, end with a println().
       // otherwise, print a comma:
       if (thisSensor == 1) {
          Serial.println();
       } else {
          Serial.print(",");
       }
    }
    
    */
 }
 
 
 void establishContact() {
 while (Serial.available() <= 0) {
      Serial.println("hello");   // send a starting message
      delay(300);
   }
 }
