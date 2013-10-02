

void setup() {
  Serial.begin(9600);
  
  
}
void loop() {
    int analogValue = analogRead(A0) /4;      // read the pot value
    //Serial.println(analogValue);        // print the value in the serial monitor as a binary value
    
    Serial.write(analogValue);     // Print the raw binary value analogValue
   Serial.print('\t');                  // print a tab
   Serial.print(analogValue, BIN);      // print the ASCII encoded binary analogValue
   Serial.print('\t');                  // print a tab
   Serial.print(analogValue, DEC);      // print the ASCII encoded decimal analogValue
   Serial.print('\t');                  // print a tab
   Serial.print(analogValue, HEX);      // print the ASCII encoded hexadecimal analogValue
   Serial.print('\t');                  // print a tab
   Serial.print(analogValue, OCT);      // print the ASCII encoded octal analogValue
   Serial.println();                    // print a linefeed and carriage return
}


