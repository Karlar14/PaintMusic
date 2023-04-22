// Different sketches 

//float  x = random(width); 
//float  y = random(height);
//diam = int(random(300));  // diameter variable
//dis = int(random(300));
float r;
float g; 
float b;
float a;
float point1;
float point2;

int diam;

void setup() {
  size(640, 360);
  background(102);
}

void draw() {
  // Call the variableEllipse() method and send it the
  // parameters for the current mouse position
  // and the previous mouse position
  //colorCircles(mouseX, mouseY, pmouseX, pmouseY);
  colorSquares(mouseX, mouseY, pmouseX, pmouseY);
  //colorTrianlge(mouseX, mouseY, pmouseX, pmouseY);
  r = random(255);  
  g = random(255);
  b = random(255);
  a = random(255);
  diam = int(random(300));
  noStroke();
}



// The simple method variableEllipse() was created specifically 
// for this program. It calculates the speed of the mouse
// and draws a small ellipse if the mouse is moving slowly
// and draws a large ellipse if the mouse is moving quickly 

//void colorCircles(int x, int y, int px, int py) {
//    float speed = abs(x-px) + abs(y-py);
//    noStroke();
//    stroke(speed);
//    fill(r,g,b,a);
//    ellipse(x, y, speed, speed);
//}
void colorSquares(int x, int y, int px, int py) {
    float speed = abs(x-px) + abs(y-py);
    noStroke();
    stroke(speed);
    fill(r,g,b,a);
    rect(x, y, speed, speed);
}
//void colorTrianlge(int x, int y, int px, int py) {
//    float speed = abs(x-px) + abs(y-py);
//    noStroke();
//    stroke(speed);
//    fill(r,g,b,a);
//    triangle(x, y, x,y, speed,speed);
//}
