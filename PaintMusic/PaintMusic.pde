//Paint Music intro

// touch osc
import oscP5.*;
import netP5.*;
import arb.soundcipher.*;

float flow = 0 ;
float weight = 0;

float oscX;
float oscY ;

float pOscX ;
float pOscY ;

int count;
// paintbrush
float r;
float g; 
float b;
float a;


boolean first = true ;
boolean f = true;
boolean reset = true; 

boolean b1 = true;
boolean b2 = false;
OscP5 oscP5;
/* a NetAddress contains the ip address and port number of a remote location in the network. */
NetAddress myBroadcastLocation; 

SoundCipher sc = new SoundCipher(this);

//switch the goods
String frame = "Menu";
PImage Title;
PImage Page;
PImage Canvas;

void setup(){
  background(255);
  frameRate(100);
  size(1000,850);
  textAlign(CENTER);
  textSize(24);

  Title = loadImage("Big.png");
  Page = loadImage("page2.png");
  Canvas = loadImage("CANVAS.png");
  
  //touch osc 
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

void draw(){
  if(frame == "Menu"){
     image(Title,0,0,1000,850);
  }
  else if(frame == "Page"){
   image(Page,0,0,1000,850);
  }
  else if(frame == "Canvas"){
    if(first){
      image(Canvas,0,0,1000,850);
      first = false;
      r = random(255);  
      g = random(255);
      b = random(255);
      a = random(255);
    }
    if(reset){
        reset = false; // it can't loop  // reset does it once
        image(Canvas,0,0,1000,800);
        oscX = 0;
        oscY = 0;
      }
      else{ // bc its false you draw only when you're not resetting.

        if (b1){
          brush();
        }
        else if(b2){
          brush2();
        }
      }
   
     
   
    
  }
  
    

}

void mousePressed(){
  if(frame == "Menu"){
      frame = "Page";
  }else if(frame == "Canvas"){
      frame = "Canvas";
      brush();
  }
}


// touch osc 
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
     if (f){
       f = false;
       pOscX = oscX;
       pOscY = oscY;
       
     }
     int noteX = int(map(oscX, 0, width,12,110));
     //int noteY = int(map(oscY, 0, height,12,110));
     int dynamic = int(map(oscY, 0, height,12,110));
     sc.playNote(noteX, dynamic, .25);
     //float notes [] = {noteX, noteY};
     //sc.playChords(notes, 100, .25);
      
     //brush();
     
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
      stroke(20);
      if(oscX != 0 || oscY != 0 ){ // cant draw if pos is at 0,0
        line(oscX, oscY, pOscX, pOscY);
      }
      
      if(pOscX != oscX)
      pOscX = oscX;
      if(pOscY != oscY)
      pOscY = oscY;
  }
}
void keyPressed(){
         if(key == 'r'){
            reset = true;
        }
        if (key == 'b'){
             b1 = true;
             b2 = false;
        }
        if(key == 'c'){
            b2 = true;
            b1 = false;
        }
}

void brush2(){
  if(true){
    
    
      print(oscX);
      print(", ");
      print(oscY);
      print(", ");
      print(pOscX);
      print(", ");
      println(pOscY);
      fill(r,g,b,a);
      //strokeWeight(10);
     noStroke();
      if(oscX != 0 || oscY != 0 ){
        ellipse(oscX, oscY, pOscX/3, pOscY/3);
       }
      if(pOscX != oscX)pOscX = oscX;
      if(pOscY != oscY)pOscY = oscY;
  }
}
void brush3(){
  if(true){
    
    
      print(oscX);
      print(", ");
      print(oscY);
      print(", ");
      print(pOscX);
      print(", ");
      println(pOscY);
      fill(r,g,b,a);
       noStroke();
      if(oscX != 0 || oscY != 0 ){
        rect(oscX, oscY, pOscX/3, pOscY/3);
      }
      if(pOscX != oscX)
      pOscX = oscX;
      if(pOscY != oscY)
      pOscY = oscY;
  }
}
