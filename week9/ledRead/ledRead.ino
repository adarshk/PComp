
int sensorValue1;

int led1 = 2;

int light =240;

void setup(){
  
 Serial.begin(9600); 
 
// pinMode(led1,OUTPUT);
 //digitalWrite(led1,LOW);
  //pinMode();
}


void loop(){
  
  
  
  
  sensorValue1 = analogRead(A0);
  
  Serial.println(sensorValue1,DEC);
  
  //if(sensorValue1 >=light){
  
  //digitalWrite(led1,HIGH);
  //}
  
  
  delay(300);
  
}
