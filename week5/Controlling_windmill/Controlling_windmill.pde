import processing.serial.*;     // import the Processing serial librarySerial myPort;                  // The serial port
boolean firstContact = false;        // Whether we've heard from the microcontroller
float bgcolor = 255;               // Background color
float fgcolor = 0;               // Fill color
float xpos, ypos;            // Starting position of the ball

Serial myPort;                  // The serial port

float rad;
float rad2=20;
float rad3=20;
float rotateRandom=0;
float rotateRandom2=0;
float randomGroups=4;
float randomGroups2=4;
int size=2;
int size2=2;

float r = 0; 
float speed = 0; 
float slowdownSpeed = 0.1;
float dropRotateSpeed=1;
int scoreCount=0;

ArrayList<rainDrop> rds;
PVector pRipple;
boolean som;
int grps=1;

void setup(){
  size(550,550);
  rds = new ArrayList<rainDrop>();
  
  for (int addDrops=0;addDrops<100;addDrops++) {
    rds.add(new rainDrop());
  }
  
  // List all the available serial ports
  println(Serial.list());

  // I know that the first port in the serial list on my mac
  // is always my  Arduino module, so I open Serial.list()[0].
  // Change the 0 to the appropriate number of the serial port
  // that your microcontroller is attached to.
  String portName = Serial.list()[5];
  myPort = new Serial(this, portName, 9600);
  
  
}



void draw(){

  background(255);
 
   fill(205);
  
  //Group of raindrops
  for(int k=0;k<randomGroups2;k++){
  for(int j=0;j<10;j++){
  pushMatrix();  
    translate((10*k)+(j*5)+250,k*20);
    rotate(radians(rotateRandom2));
    rotate(radians(random(j,dropRotateSpeed)));
    //rotate(radians(random(j,10)));
  for(int i=0;i<size2;i++){
    
  ellipse(20*j,rad3-i,size2-i,size2-i);
  
    //if(dropRotateSpeed>10)  
    //score();
  
  
  }
  
  popMatrix();
  }
  
  
  
  }
  
  rad = random(50,width-50);
  
  if(rad3>height){
  rad3=20;
  rotateRandom2=random(-6,-20);
  randomGroups2=random(3,6);
  size2=2;
  }
  else{rad3+=1;}
  
  if(frameCount%30==0 && size2<=8){
  size2++;}
  
  
  
  
  
  
  //Windmill
  pushMatrix();
  translate(100,300); 
  fill(255);
  rect(-5, 0, 9, 180);
  rotate(radians(r+=speed)); 
  //println(r);
  //println(speed);
  triangle(0, 0, 0, -20, -70, - 70); 
  triangle(0, 0, 0, 20, 70, 70);
  popMatrix();
  

  stopWindmill();
  
  
  textSize(20);
  fill(76,220,234);
  text("Speed-> "+speed,300,460);
  
  textSize(20);
  fill(76,220,234);
  text("Score-> +"+scoreCount,300,500);
  
  
  
  for (int i=rds.size()-1;i>=0;i--) {
    rainDrop newRd = rds.get(i);
    
    pRipple = newRd.dropShape(grps,speed);
    som = newRd.finished();
    
  }
  
}


void score(){

  scoreCount++;
  textSize(28);
  fill(76,220,234);
  text("+"+scoreCount,300,300);
}

/*
void mouseMoved() {
  speed = (mouseX-pmouseX);
  speed = map(speed, -100, 100, -50, 50);
  dropRotateSpeed=map(speed,-50,50,0,15);
}
*/

void stopWindmill() {
  if (speed >= slowdownSpeed) {
    speed = speed - slowdownSpeed;
  } 
  else if (speed<=-(slowdownSpeed)) {
    speed = speed + slowdownSpeed;
  }
  else {
    speed = 0;
    if(dropRotateSpeed>0){
    dropRotateSpeed--;
  }
    
  if(dropRotateSpeed>5){
    //score();
    scoreCount++;
  }  
//else if(dropRotateSpeed==0){score();}
}
}


void serialEvent(Serial myPort) { 
  String myString = myPort.readStringUntil('\n');
  // if you got any bytes other than the linefeed:
  if (myString != null) {

    myString = trim(myString);

    /*
    // if you haven't heard from the microncontroller yet, listen:
    if (firstContact == false) {
      if (myString.equals("hello")) { 
        myPort.clear();          // clear the serial port buffer
        firstContact = true;     // you've had first contact from the microcontroller
        myPort.write('A');       // ask for more
      } 
    } 
    */
    
    // if you have heard from the microcontroller, proceed:
    //else {
      // split the string at the commas
      // and convert the sections into integers:
      int sensors[] = int(split(myString, ','));

      // print out the values you got:
      for (int sensorNum = 0; sensorNum < sensors.length; sensorNum++) {
        print("Sensor " + sensorNum + ": " + sensors[sensorNum] + "\t"); 
      }
      // add a linefeed after all the sensor values are printed:
      println();
      if (sensors.length > 1) {
        xpos = map(sensors[0], 0,1023,0,50);
        //println("Xpos - "+xpos);
        speed = xpos;
        dropRotateSpeed=map(speed,0,50,0,15);
        
        ypos = map(sensors[1], 430,580,0,height);
        //print("Ypos - "+ ypos);
        //fgcolor = sensors[2] * 255;
          
    }
    //}
    // when you've parsed the data you have, ask for more:
    myPort.write("A");
  }  
}

