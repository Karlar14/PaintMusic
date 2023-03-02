float flow = 0 ;
float weight = 0;

void setup(){
  size(500,500); // width and the length of the canvas
  strokeWeight(4);
  stroke(255);
  background(100);

  
}
void draw() {
 
  for(int y = 0; y < 400; y = y + 30){
      line(0,y,width,y);
  }
  brush();
}

void brush(){
     if (mousePressed) {
    fill(color(10));
    flow = sqrt(pow(pmouseX - mouseX, 2));
    weight = constrain(weight + flow * 0.01, 0, 50);
    strokeWeight(flow);
    line(mouseX, mouseY, pmouseX, pmouseY);
  } else {
    weight = 0;
    flow = 0;
  }
  
}

//+ pow(pmouseY - mouseY, 2))
