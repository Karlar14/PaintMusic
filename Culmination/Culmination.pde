import processing.serial.*; 

final int baudRate = 57600;
Serial myPort; // the serial port 
String inString; // input string from the sp
String[] splitString;

int deviceNumber = 10;





void setup() {
  size(200, 200);
  noStroke();
  noLoop();  // Run once and stop
  // i think this is the string of the ports 
  myPort = new Serial(this,Serial.list()[deviceNumber],baudRate);
  myPort.bufferUntil('\n');
}
void draw (){
  background(100);
  if(myPort.available()> 0){
    String buffer = myPort.readString();
      if (buffer == "TABLE"){
          println("tableFound");
      
      }
  }
  
  
}
//void sMain(){
  

//}
