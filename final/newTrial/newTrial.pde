import ddf.minim.spi.*;
import ddf.minim.signals.*;
import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.ugens.*;
import ddf.minim.effects.*;
import processing.serial.*;


Serial myPort;

StringList inventory,inventory2,inventory3;
ArrayList <String> soundEffects;
Minim minim;
ArrayList<AudioPlayer>players;
ArrayList<AudioPlayer>players2;
ArrayList<PImage>images;
PImage img;
AudioPlayer onePlayer, tempPlayer,pl,pl2;
AudioSnippet twoPlayer;
String soundTemp,soundTemp2,imageTemp;
//String soundTemp2 = "rocket.wav";
//String soundTemp3 = "bubbles.wav";
boolean start =false;
boolean clicked = false;
int lastMillis =0;
int m=0;
int posx, posy;
int randomStore=0;
int chosenSensor=0;
int chosenSensorChoice=1;
int selectedSensor =0;
int flag=0,flag2=0,flag3=0;
int lost = 0,lost2=0;
int score=0;

int leg = 0, stomach =0, tongue =0, ear =0, finger =0;
boolean flex=false, firstP=false, secondP=false, Bu=false, pie=false;

void setup(){
 
 
 size(1024, 768);
  
    println(Serial.list());
    String portName = Serial.list()[4];
    //String portName = Serial.list()[0];
    myPort = new Serial(this, portName, 9600);
   
   inventory = new StringList();
   inventory2 = new StringList();
   inventory3 = new StringList();
   
   minim = new Minim(this);
   
   players = new ArrayList<AudioPlayer>();
   players2 = new ArrayList<AudioPlayer>();
   images = new ArrayList<PImage>();
   
    File folder = new File("/Users/test/Documents/Arduino/PComp/final/Voices/bopit/");
    listFilesForFolder(folder);
    
   for (int i=0;i<inventory.size();i++) {
      println("inventory - "+inventory.get(i));
      soundTemp = inventory.get(i);
      println("SoundTemp - "+soundTemp);
      pl = minim.loadFile(soundTemp);
      players.add(pl);
      // minim.loadFile(soundTemp);
      println("Crossed"); 

      //println("i - "+i);
      
    }
    
      //println("Players size - "+players.size());
    
    File folder2 = new File("/Users/test/Documents/Arduino/PComp/final/Voices/sounds/");
    listFilesForFolder2(folder2);
    
    for (int i=0;i<inventory2.size();i++) {
      println("inventory - "+inventory2.get(i));
      soundTemp2 = inventory2.get(i);
      println("SoundTemp - "+soundTemp2);
      pl2 = minim.loadFile(soundTemp2);
      players2.add(pl2);
      // minim.loadFile(soundTemp);
      println("Crossed");        
      
    }
    
    println("Players size - "+players2.size());
    
    File folder3 = new File("/Users/test/Documents/Arduino/PComp/final/Voices/images");
    listFilesForFolder3(folder3);

println("inventory3 - "+inventory3.size());
    
    for (int i=0;i<inventory3.size();i++) {
      println("inventory - "+inventory3.get(i));
      imageTemp = inventory3.get(i);
      println("ImageTemp - "+imageTemp);
      img = loadImage(imageTemp);
      images.add(img);
      // minim.loadFile(soundTemp);
      println("Crossed");        
      
    }
    
    println("images size - "+images.size());
    
}

void draw(){
  background(0);
  
  textSize(32);
  fill(255);
  //text(chosenSensor, 300, 30);
  
    if (start == true) {
    //lastMillis=millis();
    
    if (millis() - lastMillis <=6000) {

      if (clicked) {

        println("chosenSensor - "+chosenSensor);
        println("selectedSensor - "+selectedSensor);   
        if (chosenSensor==selectedSensor) {

          //players2.get(selectedSensor).play();
          
          
//          int r = (int)random(0, 1);
//          //onePlayer.play();
//          //twoPlayer.play();
//          if (r==1) {
//            println("playing 1");
//            //onePlayer.play();
//          }
//          else {
//            println("playing 2");
//            //twoPlayer.play();
//          }



          players2.get(selectedSensor).rewind();
          players.get(chosenSensor).rewind();
          chosenSensorChoice = (int)random(0, 4.9);
          if(chosenSensorChoice == 1 || chosenSensorChoice == 2 ||chosenSensorChoice == 0|| chosenSensorChoice == 4){chosenSensor = chosenSensorChoice;}
          else {chosenSensor = 1;}
          println("chosenSensor - "+chosenSensor);
          score+=1;
          
          //if (millis() - lastMillis >3500 && millis() - lastMillis < 4000)
          delay(600);
          players.get(chosenSensor).play();
          

          //        AudioPlayer tempPlay = players.get[r];
          //        tempPlay.play();
          posx = (int)random(0, width);
          posy = (int)random(0, height);
          //clicked = !clicked;
          println("clicked - "+clicked);
          lastMillis = millis();
          
          

          //randomStore = random();
        }

        else {
          println("You selected the wrong sensor");
          start=false;
          clicked = false;
          score=0;
          lost2=1;
        }
        
        players.get(chosenSensor).play();
      }
      else {
        //onePlayer.pause();
        //twoPlayer.pause();
      } 

      image(images.get(chosenSensor),10,10);
      //ellipse(posx, posy, 50, 50);
     //players.get(chosenSensor).play(); 
      clicked = false;
      //lastMillis = m;
      //println("lastMillis - "+lastMillis);
    }

    else if (millis()-lastMillis > 6100) {
      text("You lost", width/2, height/2);
      start = false;
      clicked = false;
      lost=1;
      score=0;
    }
    
    
    textSize(45); 
    fill(255,0,0);
    text("Score:"+score, width/2+100, height/2);
    
  }

  else if (start==false) {
    textSize(45); 
    fill(255,0,0);
    text("Press any key to start", width/2, height/2);
    
    if(lost==1)
    text("Timeout. You lost :( Try again", width/2-85, height-100);
    if(lost2==1)
    text("You lost, Try again", width/2-140, height-100);
    
//    if(lost==1 || lost2==1){
//    
//    for (int i=0;i<inventory.size();i++) {
//     players.get(i).rewind();  
//    }
//    
//    for (int i=0;i<inventory2.size();i++) {
//     players2.get(i).rewind();  
//    }
    
    lastMillis = millis();
 // }
  
  }
  //players2.get(selectedSensor).rewind();
  
}




void mousePressed() {
  start = true;lost=0;lost2=0;
  chosenSensor = 1;
  //chosenSensor = (int)random(0, 4.9);
  players.get(chosenSensor).play();
  println("chosenSensor - "+chosenSensor);
  
  
}


void keyPressed() {
  //start = !start; 

  if (start==false)
    clicked=false;

  if (key=='q') {
    start=false;
    clicked=false;
  }

  if (start==true) {

    if (key=='a') {
      clicked=true;
      selectedSensor=0;
    }

    if (key=='s') {
      clicked=true;
      selectedSensor=1;
    }

    if (key=='d') {
      clicked=true;
      selectedSensor=2;
    }

    if (key=='f') {
      clicked=true;
      selectedSensor=3;
    }

    if (key=='g') {
      clicked=true;
      selectedSensor=4;
    }
    
    
    if(clicked==true){
     players2.get(selectedSensor).play(); 
    }
    
  }

  println("clicked Mouse Pressed - "+clicked);
  //onePlayer.rewind();
  //twoPlayer.rewind();
}



//Load files from folders

void listFilesForFolder(final File folder) {
  for (File fileEntry : folder.listFiles()) {
    if (fileEntry.isDirectory()) {
      listFilesForFolder(fileEntry);
    } 
    else {
      println(fileEntry.getName());
      ++flag;
      println("flag - "+flag);
      //soundEffects.add(fileEntry.getName());
      //String someThing = fileEntry.getName();
      String ds = fileEntry.getName();
      if(flag==1)
      {println("DS Store detected");}
      else
      inventory.append(fileEntry.getName());
    }
  }
}



void listFilesForFolder2(final File folder) {
  for (File fileEntry : folder.listFiles()) {
    if (fileEntry.isDirectory()) {
      listFilesForFolder2(fileEntry);
    } 
    else {
      println(fileEntry.getName());
      ++flag2;
      println("flag2 - "+flag2);
      //soundEffects.add(fileEntry.getName());
      //String someThing = fileEntry.getName();
      String ds = fileEntry.getName();
      if(flag2==1)
      {println("DS Store detected");}
      else
      inventory2.append(fileEntry.getName());
    }
  }
}


void listFilesForFolder3(final File folder) {
  println("Here in flag3");
  for (File fileEntry : folder.listFiles()) {
    if (fileEntry.isDirectory()) {
      listFilesForFolder3(fileEntry);
    } 
    else {
      println(fileEntry.getName());
      ++flag3;
      
      println("flag3 - "+flag3);
      //soundEffects.add(fileEntry.getName());
      //String someThing = fileEntry.getName();
      String ds = fileEntry.getName();
      //if(flag3==1)
      //{println("DS Store detected");}
      //else
      inventory3.append(fileEntry.getName());
    }
  }
}



//Serial event


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

      leg = (int)map(sensors[2], 0, 1023, 0, 100);
      stomach = (int)map(sensors[0], 0, 1023, 0, 100);
      tongue = (int)map(sensors[1], 0, 1023, 0, 100);
      ear = sensors[3];
      finger = sensors[4];
    }
    
//    println("leg - "+leg);
//    println("stomach - "+stomach);
//    println("tongue - "+tongue);
//    println("ear - "+ear);
//    println("finger - "+finger);
    
    
    
    if(start==true){
    
    if(leg>50){
      clicked=true;
      selectedSensor=0;
      
      
    }
    
    if(stomach>50){
      clicked=true;
      selectedSensor=1;
      
      
    }
    
    if(tongue>50){
      clicked=true;
      selectedSensor=2;
      
      
    }
    
    if(ear>200){
      clicked=true;
      selectedSensor=3;
      
      
    }
    
    if(finger<950){
      clicked=true;
      selectedSensor=4;
      
      
    }
    
    
    if(clicked==true){
     players2.get(selectedSensor).play(); 
    }
    
    }

    // when you've parsed the data you have, ask for more:
    myPort.write("A");
  }
}

//Stop minim

void stop()
{
  // always close audio I/O classes
  onePlayer.close();
  twoPlayer.close();
  // always stop your Minim object
  minim.stop();

  super.stop();
}
