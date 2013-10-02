
//int piezoOut=12;

void setup(){

Serial.begin(9600);

//Since we are using tone() below where we are setting pin 12, we dont need to 
//use pinmode here.
//pinMode(12,OUTPUT);


}
void loop(){

  int lightReading = analogRead(A0);
  
  Serial.println(lightReadin);
  
  float frequency = map(lightReading,200,900,100,1000);
  
  tone(12,frequency,10);


}
