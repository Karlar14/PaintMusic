/**
 * oscP5broadcastClient by andreas schlegel
 * an osc broadcast client.
 * an example for broadcast server is located in the oscP5broadcaster exmaple.
 * oscP5 website at http://www.sojamo.de/oscP5
 */

import oscP5.*;
import netP5.*;
import arb.soundcipher.*;


float flow = 0 ;
float weight = 0;

float oscX = 0;
float oscY = 0;

float pOscX = 0;
float pOscY = 0;

int count;

OscP5 oscP5;
/* a NetAddress contains the ip address and port number of a remote location in the network. */
NetAddress myBroadcastLocation; 

SoundCipher sc = new SoundCipher(this);

void setup() {
  size(400,400);
  frameRate(60);
  background(100);
  /* create a new instance of oscP5. 
   * 12000 is the port number you are listening for incoming osc messages.
   */
  oscP5 = new OscP5(this,12000);
  
  /* create a new NetAddress. a NetAddress is used when sending osc messages
   * with the oscP5.send method.
   */
  
  /* the address of the osc broadcast server */
  myBroadcastLocation = new NetAddress("127.0.0.1",32000);
}

void draw() {
  brush();
}


/* incoming osc message are forwarded to the oscEvent method. */
void oscEvent(OscMessage theOscMessage) {
  /* get and print the address pattern and the typetag of the received OscMessage */
  //println("### received an osc message with addrpattern "+theOscMessage.addrPattern()+" and typetag "+theOscMessage.typetag());
  //theOscMessage.print();
  //check
    //println(oscX);
    //println(oscY);
   if(theOscMessage.checkAddrPattern("/multixy/1")==true){
     oscX = map(theOscMessage.get(0).floatValue(), 0, 1 ,0, width);
     oscY = map(theOscMessage.get(1).floatValue(), 0, 1 ,0, height);
     int noteX = int(map(oscX, 0, width,12,110));
     //int noteY = int(map(oscY, 0, height,12,110));
     int dynamic = int(map(oscY, 0, height,12,110));
     sc.playNote(noteX, dynamic, .25);
     //float notes [] = {noteX, noteY};
     //sc.playChords(notes, 100, .25);
     
  } 
}

void brush(){
  if(true){
      print(oscX);
      print(", ");
      print(oscY);
      print(", ");
      print(pOscX);
      print(", ");
      println(pOscY);
      fill(color(15));
      strokeWeight(20);
      line(oscX, oscY, pOscX, pOscY);
      if(pOscX != oscX)pOscX = oscX;
      if(pOscY != oscY)pOscY = oscY;
  }
}
