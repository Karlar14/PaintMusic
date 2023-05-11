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
boolean b4 = false;
OscP5 oscP5;
/* a NetAddress contains the ip address and port number of a remote location in the network. */
NetAddress myBroadcastLocation; 

SoundCipher sc = new SoundCipher(this);

//switch the goods
String frame = "Menu";
PImage Title;
PImage Page;
PImage Canvas;
PImage HT;
PImage B3;

void setup(){
  background(255);
  frameRate(100);
  size(1000,850);
  //size(400,400);
  textAlign(CENTER);
  textSize(24);

  Title = loadImage("Big.png");
  Page = loadImage("page2.png");
  Canvas = loadImage("CANVAS.png");
  HT = loadImage("HT.png");
  
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
  else if(frame == "HT"){
    image(HT,0,0,1000,850);
  }
   else if(frame == "Canvas"){
    //image(Canvas,0,0,1000,850);
  
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
        image(Canvas,0,0,1000,850);
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
        else if(b4){
          brush4();
        }
      }
  
  }
  
    

}

void mousePressed(){
  if(frame == "Menu"){
      frame = "Page";
  }else if(frame == "Page"){
      frame = "HT";
      //brush();
  }
  else if(frame == "HT"){
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
    
     //float notes [] = {noteX, noteY};
     //sc.playChords(notes, 100, .25);
      
     //brush();
     
  } 
}

void music(){
      sc.instrument(12);
     int noteX = int(map(oscX, 0, width,12,110));
     //int noteY = int(map(oscY, 0, height,12,110));
     int dynamic = int(map(oscY, 0, height,12,110));
     sc.playNote(noteX, dynamic, 2.0); //
}

void music2(){
    sc.instrument(0);
     int pitch1 = int(map(oscX, 0, width,12,110));
     ////int noteY = int(map(oscY, 0, height,12,110));
     int pitch2 = int(map(oscY, 0, height,12,110));
     //sc.playNote(noteX,dynamic, .5); //
     //sc.playPhrase(noteX,20,4);
     float [] pitches = {pitch1,pitch2};
     
     sc.playChord(pitches,100,1.5);
}
void music3(){
    sc.instrument(50);
     int pitch1 = int(map(oscX, 0, width,12,110));
     int pitch2 = int(map(oscY, 0, height,12,110));
     //int dynamic = int(map(oscY, 0, height,12,110));
     //sc.playNote(noteX,dynamic, .5); //
     //sc.playPhrase(noteX,20,4);
     float [] pitches = {pitch1,pitch2};
     sc.playChord(pitches,100,1.5);
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
  music();
}


void brush2(){
  if(true){
    
    //sc.instrument(117);
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
  music2();
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
void brush4(){
  

    if(true){
       B3 = loadImage("p1.png");
      
      print(oscX);
      print(", ");
      print(oscY);
      print(", ");
      print(pOscX);
      print(", ");
      println(pOscY);
      //fill(r,g,b,a);
      // noStroke();
      r = random(255);  
      g = random(255);
      b = random(255);
      a = random(255);
       tint(r, g, b); 
      if(oscX != 0 || oscY != 0 ){
        //rect(oscX, oscY, pOscX/3, pOscY/3);
        image(B3,oscX, oscY, pOscX/3, pOscY/3);
      }
      if(pOscX != oscX)
      pOscX = oscX;
      if(pOscY != oscY)
      pOscY = oscY;
  }
  music3();
}
//}

void keyPressed(){
         if(key == 'r'){
            reset = true;
        }
        if (key == '1'){
             b1 = true;
             b2 = false;
             b4 = false;
        }
        if(key == '2'){
            b2 = true;
            b1 = false;
            b4 = false;
        }
        if(key == '3'){
            b4 = true;
            b1 = false;
            b2 = false;
        }
}
