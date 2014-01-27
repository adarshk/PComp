import processing.serial.*;     // import the Processing serial library
import ddf.minim.*;
Serial myPort;                  // The serial port
boolean firstContact = false;        // Whether we've heard from the microcontroller
float bgcolor = 255;               // Background color
float fgcolor = 0;               // Fill color
float xpos, ypos;            // Starting position of the ball

Minim minim;
AudioPlayer player;

void setup() {
  
  size(800,600);
  // List all the available serial ports
  println(Serial.list());
  minim = new Minim(this);

  // I know that the first port in the serial list on my mac
  // is always my  Arduino module, so I open Serial.list()[0].
  // Change the 0 to the appropriate number of the serial port
  // that your microcontroller is attached to.
  String portName = Serial.list()[5];
  myPort = new Serial(this, portName, 9600);
  
  //myPort.bufferUntil('\n');
  
  
  //player = minim.loadFile("");
}


void draw() {
  background(bgcolor);
  //fill(fgcolor);
  // Draw the shape
  //ellipse(xpos, ypos, 20, 20);
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
        //xpos = map(sensors[0], 430,580,0,width);
        //ypos = map(sensors[1], 430,580,0,height);
        //fgcolor = sensors[2] * 255;
      }
    //}
    // when you've parsed the data you have, ask for more:
    myPort.write("A");
  }  
}


