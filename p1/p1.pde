PImage paint;

float r;
float g; 
float b;
float a;
void setup(){
  size(800,400);
  paint = loadImage("p1.png");
  imageMode(CENTER);
  background(50);

}

void draw(){
  
    r = random(255);  
  g = random(255);
  b = random(255);
  a = random(255);
 tint(r, g, b); 
  image(paint, mouseX, mouseY,100,300);
}
