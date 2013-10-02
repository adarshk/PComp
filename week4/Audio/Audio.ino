#include "Pitches.h"

int button3 = 3;
int button4 = 4;
int button5 = 5;
int button6 = 6;
const int threshold = 60;
const int speakerPin = 11;

 // notes in the melody:
 int melody[] = {
   NOTE_C4, NOTE_G3,NOTE_G3, NOTE_GS3, NOTE_G3,0, NOTE_B3, NOTE_C4};
   
  int notePress[] = {NOTE_C3,NOTE_D3,NOTE_F3,NOTE_A3};

  int bigButton1[] ={NOTE_A4,NOTE_C4,NOTE_D4,NOTE_E4,NOTE_G4,NOTE_A4}; 
  int bigButton2[] ={NOTE_E4,NOTE_G4,NOTE_A4,NOTE_C4,NOTE_D4,NOTE_E4};   

 // note durations: 4 = quarter note, 8 = eighth note, etc.:
 int noteDurations[] = {
   4, 8, 8, 4,4,4,4,4 };

 void setup() {
  
   Serial.begin(9600);
   pinMode(button3,INPUT);
   pinMode(button4,INPUT);
   pinMode(button5,INPUT);
   pinMode(button6,INPUT);
   
   //digitalWrite(button3, LOW);
   //digitalWrite(button4, LOW);
   //digitalWrite(button5, LOW);
   //digitalWrite(button6, LOW);
   
   
   
   
   /*
   // iterate over the notes of the melody:
   for (int thisNote = 0; thisNote < 8; thisNote++) {

     // to calculate the note duration, take one second 
     // divided by the note type.
     //e.g. quarter note = 1000 / 4, eighth note = 1000/8, etc.
     int noteDuration = 1000/noteDurations[thisNote];
     tone(11, melody[thisNote],noteDuration);

     //pause for the note's duration plus 30 ms:
     delay(noteDuration +30);
   }*/
 }

 void loop() {
   
   
   
   int  p1 = analogRead(A0);
   //int  p2 analogRead(A1);
   //int  p3 = analogRead(A2);
   //int  p4 = analogRead(A3);
 
 
   float varyPitch = map(p1,200,900,100,1000);
   
   //tone(speakerPin,varyPitch,10);
   
   
   for(int thisSensor=1;thisSensor<4;thisSensor++){
    
      int sensorRead = analogRead(thisSensor);
       //Serial.println(sensorRead);
       float pMap = map(sensorRead,0,1023,0,100);
       
       if(sensorRead > threshold){
       tone(speakerPin,notePress[thisSensor],500);
       
       }
        
   }
   
   
   for(int buttonRead=3;buttonRead<7;buttonRead++){
   
   int buttonR = digitalRead(buttonRead);
   
   
   if(buttonRead==3){
   
 
     
   if(buttonR==HIGH){
 
       Serial.println(buttonRead);
     
     for(int ij=0;ij<6;ij++){
     tone(speakerPin,bigButton1[ij],random(250,1000));
     delay(100);  
 
 }
     }
     
     buttonR=LOW;
     
   }
   
   
   if(buttonRead==4){
   
 
     
   if(buttonR==HIGH){
 
       Serial.println(buttonRead);
     
     for(int ij=0;ij<6;ij++){
     tone(speakerPin,bigButton1[ij],random(250,1000));
     delay(100);  
 
 }
     }
     
     buttonR=LOW;
   }
   
   
   
   if(buttonRead==5){
   
 
     
   if(buttonR==HIGH){
 
       Serial.println(buttonRead);
     
     for(int ij=0;ij<6;ij++){
     tone(speakerPin,bigButton2[ij],random(250,1000));
     delay(100);  
 
 }
     }
     
     buttonR=LOW;
   }
   
       
   /*
   if(buttonRead==6){
   
 
     
   if(buttonR==HIGH){
 
       Serial.println(buttonRead);
     
     for(int ij=0;ij<6;ij++){
     tone(speakerPin,bigButton2[ij],random(250,1000));
     delay(100);  
 
 }
     }
     
     buttonR=LOW;
   }
     */
   }
   
 
 /*
 
 for (int thisNote = 0; thisNote < 8; thisNote++) {

     // to calculate the note duration, take one second 
     // divided by the note type.
     //e.g. quarter note = 1000 / 4, eighth note = 1000/8, etc.
     int noteDuration = 1000/noteDurations[thisNote];
     tone(11, melody[thisNote],noteDuration);

     //pause for the note's duration plus 30 ms:
     delay(noteDuration +30);
   }
 */
 }
