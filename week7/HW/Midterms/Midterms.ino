#include <Wire.h>
#include <HMC5883L.h>

HMC5883L compass;


//Multiple sensors

int sensorValue1;
int sensorValue2;
int sensorValue3;
int sensorValue4;
int sensorValue5;
int sensorValue6;
int sensorValue7;

boolean selected = false;

const int switchPin = 2;      // digital input 

void setup(){
  Serial.begin(9600);
  Wire.begin();
  
  compass = HMC5883L(); //new instance of HMC5883L library
  setupHMC5883L(); //setup the HMC5883L
  
  pinMode(switchPin, INPUT);
}

// Our main program loop.
void loop(){
  
  float heading = getHeading();
  Serial.print(heading);
  Serial.print(",");
  //delay(100); //only here to slow down the serial print


    //if (Serial.available() > 0) {
     // read the incoming byte:
    //int inByte =Serial.read();
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
   sensorValue3 =analogRead(A2);
   // print the results:
  Serial.print(sensorValue3, DEC);
  Serial.println(",");
  /*
     // read the sensor:
   sensorValue4 =analogRead(A3);
   // print the results:
  Serial.print(sensorValue4, DEC);
  Serial.print(",");
  
     // read the sensor:
   sensorValue5 =analogRead(A4);
   // print the results:
  Serial.print(sensorValue5, DEC);
  Serial.print(",");

   // read the sensor:
   //sensorValue6 =digitalRead(2);
   // print the last sensor value with a println() so that
   // each set of four readings prints on a line by itself:
  //Serial.println(sensorValue6, DEC);
   //}
   
   sensorValue7 =analogRead(A5);
   // print the results:
  Serial.println(sensorValue7, DEC);
   */
  
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
    
   // delay(500);

}

void setupHMC5883L(){
  //Setup the HMC5883L, and check for errors
  int error;  
  error = compass.SetScale(1.3); //Set the scale of the compass.
  if(error != 0) Serial.println(compass.GetErrorText(error)); //check if there is an error, and print if so

  error = compass.SetMeasurementMode(Measurement_Continuous); // Set the measurement mode to Continuous
  if(error != 0) Serial.println(compass.GetErrorText(error)); //check if there is an error, and print if so
}

float getHeading(){
  //Get the reading from the HMC5883L and calculate the heading
  MagnetometerScaled scaled = compass.ReadScaledAxis(); //scaled values from compass.
  float heading = atan2(scaled.YAxis, scaled.XAxis);

  // Correct for when signs are reversed.
  if(heading < 0) heading += 2*PI;
  if(heading > 2*PI) heading -= 2*PI;

  return heading * RAD_TO_DEG; //radians to degrees
}


void establishContact() {
 while (Serial.available() <= 0) {
      Serial.println("hello");   // send a starting message
      delay(300);
   }
 }
