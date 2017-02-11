/**
**/

import controlP5.*;
import oscP5.*;
import netP5.*;

OscP5 oscP5;
NetAddress dest;
ControlP5 cp5;

float[] oscValuesArray;

PFont f, f2;

int currentClass = 1;
String currentMessage = "Waiting...";

String sendHost = "127.0.0.1";
int sendPort = 6499; // 6448;
int listenPort = 6448; //12000; 

void setup() {
 // colorMode(HSB);
  size(640, 480, P2D);
  noStroke();

  /* start oscP5, listening for incoming messages  */
  oscP5 = new OscP5(this, listenPort);
  dest = new NetAddress(sendHost, sendPort);
  
  //Create the font
  f = createFont("Courier", 14);
  textFont(f);
  f2 = createFont("Courier", 40);
  textAlign(LEFT, TOP);
  
  createControls();
  sendNames();
  
  oscValuesArray = new float[25]; // Create
}

void sendNames() {
  // TODO: Send param names
  //OscMessage msg = new OscMessage("/wekinator/control/setInputNames");
  //msg.add("mouseX"); 
  //msg.add("mouseY");
  //oscP5.send(msg, dest);
}

void createControls() {
}

void drawText() {
  fill(255);
  textFont(f);
  text("Listening on port " + listenPort, 100, 20);
  text("Sending to " + sendHost + " on port " + sendPort + ".", 100, 35);
  text ("This is an osc router", 100, 50);
  text(currentMessage, 20, 180);
}

void draw() {
  background(0);
   smooth();
   drawText();
}

void sendOsc() {
  OscMessage msg = new OscMessage("/wek/inputs");
  msg.add((float)mouseX); 
  msg.add((float)mouseY);
  oscP5.send(msg, dest);
}

//This is called automatically when OSC message is received
void oscEvent(OscMessage theOscMessage) {
  //println("received message");
  //currentMessage = "Got something\n" + theOscMessage.toString();
  if (theOscMessage.checkAddrPattern("/wek/inputs") == true) {
    int argCount = theOscMessage.arguments().length;
    float value0 = theOscMessage.get(0).floatValue();
    currentMessage = "" + argCount + " arguments. 0 is " + value0;

    // Do averaging here
    for (int i=0; i < argCount; i++) 
    {
      // TODO: Average the values or whatever
      //oscValuesArray = 
    }
  }
 theOscMessage.print();
 
}