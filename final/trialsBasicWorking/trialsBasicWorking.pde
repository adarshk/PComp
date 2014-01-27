import ddf.minim.spi.*;
import ddf.minim.signals.*;
import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.ugens.*;
import ddf.minim.effects.*;
import processing.serial.*;



//Sensors

Serial myPort;

StringList inventory;
ArrayList <String> soundEffects;
Minim minim;
ArrayList<AudioPlayer>players;
AudioPlayer onePlayer;
String soundTemp;
String soundTemp2 = "rocket.wav";
boolean start =false;
boolean clicked = false;
int sensor1=1,sensor2=2,sensor3=3,sensor4=4,sensor5=5;
//int[] sensorValues = {sensor1,sensor2,sensor3,sensor4,sensor5};
int lastMillis =0;
int m=0;
int posx,posy;
int randomStore=0;

int flexSensorValue=0,firstPressureSensor=0,secondPressureSensor=0,Button=0,piezo=0;

void setup(){
  size(400,400);
  
  println(Serial.list());
  String portName = Serial.list()[5];
  myPort = new Serial(this, portName, 9600);
  
  
 // m=millis();
 inventory = new StringList();
 players = new ArrayList<AudioPlayer>();
 minim = new Minim(this);
File folder = new File("/Users/test/Documents/Arduino/PComp/final/soundSketch/data");
listFilesForFolder(folder);

for(int i=0;i<inventory.size();i++){
  soundTemp = inventory.get(i);
 players.add(minim.loadFile(soundTemp));
// minim.loadFile(soundTemp);

println(soundTemp);
}
onePlayer = minim.loadFile(soundTemp2);
//onePlayer.play();

  
}

void draw(){
  background(0);
 
 /*
  //println("playing");
  onePlayer.play();
  for (int i = players.size()-1; i >= 0; i--) {
    AudioPlayer player = players.get(i);
    //player.play();
  }
  
 */
  
  if(start==false){
  fill(255);
  text("Press Start",100,100);
  lastMillis = millis();
  }
  
  if(start == true){
    //lastMillis=millis();
  
    if(millis() - lastMillis <=3000){
      
      if(clicked){
      posx = (int)random(0,width);
      posy = (int)random(0,height);
      clicked = !clicked;
      lastMillis = millis();
      //randomStore = random();
      }
      ellipse(posx,posy,50,50);
      //lastMillis = m;
      //println("lastMillis - "+lastMillis);
    }
  
  else if(millis()-lastMillis > 3100){
    start = false;
  }
    
  
  }
  
}
void listFilesForFolder(final File folder) {
    for (File fileEntry : folder.listFiles()) {
        if (fileEntry.isDirectory()) {
            listFilesForFolder(fileEntry);
        } else {
            println(fileEntry.getName());
            //soundEffects.add(fileEntry.getName());
            //String someThing = fileEntry.getName();
            inventory.append(fileEntry.getName());
        }
    }
}



void mousePressed(){
 
  
 clicked = !clicked;
  
}

void keyPressed(){
  start = !start; 
  
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
        
        firstPressureSensor = (int)map(sensors[0],0,1023,0,100);
        secondPressureSensor = (int)map(sensors[1],0,1023,0,100);
        flexSensorValue = (int)map(sensors[2],750,500,0,100);
        //sensor1 = sensors[0];
        //xpos = map(sensors[0], 430,580,0,width);
        //ypos = map(sensors[1], 430,580,0,height);
        //fgcolor = sensors[2] * 255;
      }
      //sensor1 = sensors[0];
      

      println("1st Pressure - "+firstPressureSensor);
      println("2nd Pressure - "+secondPressureSensor);
      println("Flexsensor - "+flexSensorValue);
      
      if(sensors[3]==1){
      clicked = !clicked;
//      println("1st Pressure - "+sensors[0]);
      }
      
      /*
      if(sensors[0]>800 || sensors[1]>800 || sensors[2]>50 || sensors[3]==1 || sensors[4]>140){
      clicked = !clicked;
      }
    
      clicked = false;    
      */
      
    //}
    // when you've parsed the data you have, ask for more:
    myPort.write("A");
  }  
}

