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
AudioPlayer onePlayer,tempPlayer;
AudioSnippet twoPlayer;
String soundTemp;
String soundTemp2 = "rocket.wav";
String soundTemp3 = "bubbles.wav";
boolean start =false;
boolean clicked = false;
int sensor1=1,sensor2=2,sensor3=3,sensor4=4,sensor5=5;
//int[] sensorValues = {sensor1,sensor2,sensor3,sensor4,sensor5};
int lastMillis =0;
int m=0;
int posx,posy;
int randomStore=0;
int chosenSensor=0;
int selectedSensor =0;

int flexSensorValue=0,firstPressureSensor=0,secondPressureSensor=0,Button=0,piezo=0;
boolean flex=false,firstP=false,secondP=false,Bu=false,pie=false;

void setup(){
  size(400,400);
  
  println(Serial.list());
  //String portName = Serial.list()[5];
  String portName = Serial.list()[0];
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
twoPlayer = minim.loadSnippet(soundTemp3);
//onePlayer.play();

onePlayer.loop();
twoPlayer.loop();
  
}

void draw(){
  background(0);
 
 
  //println("playing");
 // onePlayer.play();
  for (int i = players.size()-1; i >= 0; i--) {
    AudioPlayer player = players.get(i);
    //player.play();
  }
  
     textSize(32);
      fill(255);
      text(chosenSensor, 300, 30);
  
  if(start==false){
  fill(255);
  text("Press any key to start",100,100);
  lastMillis = millis();
  }
  
  if(start == true){
    //lastMillis=millis();
  
    if(millis() - lastMillis <=3000){
  
      if(clicked){
        
        println("chosenSensor - "+chosenSensor);
        println("selectedSensor - "+selectedSensor);   
        if(chosenSensor==selectedSensor){
        
        int r = (int)random(0,1);
        //onePlayer.play();
        //twoPlayer.play();
        if(r==1){
        println("playing 1");
         onePlayer.play();
        }
         else{
         println("playing 2");
         twoPlayer.play();
         }
         
         
         
//        AudioPlayer tempPlay = players.get[r];
//        tempPlay.play();
      posx = (int)random(0,width);
      posy = (int)random(0,height);
      //clicked = !clicked;
      println("clicked - "+clicked);
      lastMillis = millis();
      
      chosenSensor = (int)random(0,4.9);
      println("chosenSensor - "+chosenSensor);
  
      //randomStore = random();
      }
  
  else{
      println("You have selected the wrong sensor");
      start=false;
      clicked = false;
      }    
    
  }
     else{
      //onePlayer.pause();
      //twoPlayer.pause();
     } 
      
      ellipse(posx,posy,50,50); 
      clicked = false;
      //lastMillis = m;
      //println("lastMillis - "+lastMillis);
    }
  
  else if(millis()-lastMillis > 3100){
    text("You lost",width/2,height/2);
    start = false;
    clicked = false;
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
 start = true;
 chosenSensor = (int)random(0,4.9);
  println("chosenSensor - "+chosenSensor);
  
 //clicked = !clicked;
 
 
 /*
 if(start==false)
 clicked=false;
 
 else{
 clicked=true;
 chosenSensor = (int)random(0,4.9);
  //println("chosenSensor - "+chosenSensor);
  
  switch(chosenSensor){
   
   case 0:
   
   break;
   
   case 1:
   
   break;
   
   case 2:
   
   break;
   
   case 3:
   
   break;
   
   case 4:
   
   break;
   
    
  }
  

  
 }    
    */
// println("clicked Mouse Pressed - "+clicked);
// onePlayer.rewind();
// twoPlayer.rewind();
  
}

void keyPressed(){
  //start = !start; 
  
  if(start==false)
 clicked=false;
  
  if(key=='q'){
    start=false;
    clicked=false;
  }
  
  if(start==true){
  
  if(key=='a'){
    clicked=true;
    selectedSensor=0;
  }
  
  if(key=='s'){
    clicked=true;
    selectedSensor=1;
  }
  
  if(key=='d'){
    clicked=true;
    selectedSensor=2;
  }
  
  if(key=='f'){
    clicked=true;
    selectedSensor=3;
  }
  
  if(key=='g'){
    clicked=true;
    selectedSensor=4;
  }
  
  }
  
   println("clicked Mouse Pressed - "+clicked);
 onePlayer.rewind();
 twoPlayer.rewind();
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
      
//      if(sensors[3]==1){
//      clicked = !clicked;
////      println("1st Pressure - "+sensors[0]);
//      }
      
      if(firstPressureSensor>50){
        clicked = !clicked;
        firstP = true;
        
      }
      else if(secondPressureSensor>50){
              clicked = !clicked; 
               secondP = true;       
      }
      
      //else if(flexSensorValue>50){
        //clicked = !clicked;
      //}
      
      else if(sensors[3]==1){
      clicked = !clicked;
      Bu = true;
      //twoPlayer.play();
      }
      
      else if(sensors[4]>=40){
      clicked = !clicked;
      pie = true;
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

void stop()
{
  // always close audio I/O classes
  onePlayer.close();
  twoPlayer.close();
  // always stop your Minim object
  minim.stop();
 
  super.stop();
}

