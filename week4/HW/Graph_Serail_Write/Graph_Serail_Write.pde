import processing.serial.*;

float xPos = 0;

Serial myPort;


void setup() {
  size(800,600);  
  //Serial.begin(9600);
  //println(Serial.list());
  
  String portName = Serial.list()[5];
  myPort = new Serial(this,portName,9600);
  
  background(#786BFF);
}
void draw() {
    
  
  //int analogValue = analogRead(A0) /4;      // read the pot value
    //Serial.write(analogValue);        // print the value in the serial monitor as a binary value
}


void serialEvent(Serial myPort)
{

    int inByte = myPort.read();
    float yPos = height - inByte;
    
    stroke(#FF6D31);
    
    line(xPos,height,xPos,yPos);
    
    if(xPos>=width){xPos=0;background(#786BFF);}
    else{xPos++;}
    
    //println(inByte);

  
}


