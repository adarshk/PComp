import ddf.minim.spi.*;
import ddf.minim.signals.*;
import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.ugens.*;
import ddf.minim.effects.*;


Minim minim;
ArrayList<AudioPlayer>players;
AudioPlayer onePlayer;
String soundTemp = "tuning.mp3";

void setup(){
  minim = new Minim(this);
  
  onePlayer= minim.loadFile(soundTemp);
  
  onePlayer.play();
  
}
