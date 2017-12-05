float squareX;
float squareY;
import java.util.Arrays;
import java.util.Map;

int speed;
Button startButton;
Button pausePlayButton;
Button speedUpButton;
Button speedDownButton;
TextDisplay speedDisplay;
Field field;

boolean start;
boolean isDrawing;

void settings(){
   size(1600, 900);
}

void setup(){
   speed = 1;
   frameRate(30 * speed);
   noStroke();
   
   field = new Field(25);
   
   //Params                   Name  Gender MaxAge   Size                            ColorOne                                    ColorTwo                          PetalOne                      PetalTwo                  MutabilityOne              MutabilityTwo
   //field.addFlower(new Flower("Adam", 'M', 60, new Genotype(60, 1.0), new Genotype(new int[] {187, 187, 0}, 1.0), new Genotype(new int[] {187, 187, 0}, 1.0), new Genotype("square", 1.0), new Genotype("square", 1.0), new Genotype(0.002, 1.0), new Genotype(0.01, 0.5)));
   //field.addFlower(new Flower("Eve", 'F', 120, new Genotype(45, 0.5), new Genotype(new int[] {255, 187, 187}, 0.5), new Genotype(new int[] {255, 187, 187}, 0.5), new Genotype("round", 0.66), new Genotype("triangle", 0.33), new Genotype(0.0025, 1.0), new Genotype(0.01, 0.5)));
   //field.addFlower(new Flower("Lillith", 'F', 70, new Genotype(51, 1.0), new Genotype(new int[] {20, 217, 197}, 1.0), new Genotype(new int[] {0, 50, 187}, 0.5), new Genotype("square", 1.0), new Genotype("triangle", 0.33), new Genotype(0.0022, 1.0), new Genotype(0.015, 0.5)));
   for(int i = 0; i < 10; i++){
     field.addFlower(new Flower((int)random(width), (int)random(height)));
   }
   //Params               startX, startY, Width, Height, Text
   startButton = new Button(50, 10, 130, 30, "Start");
   pausePlayButton = new Button(230, 10, 130, 30, "Pause");
   speedDownButton = new Button(width-275, 10, 50, 30, "<<");
   speedUpButton = new Button(width-125, 10, 50, 30, ">>");
   speedDisplay = new TextDisplay(speed, width-200, 10, 50, 30);
   
   isDrawing = true;
}

void draw(){
   background(99, 209, 62);
   
   if(start){
      field.drawFlowers(); 
   }
   
   fill(125,125,125);
   rect(0, 0, width, 50);
   
   startButton.draw();
   pausePlayButton.draw();
   
   fill(35,35,35);
   rect(width-300, 5, 250, 40);
   speedDownButton.draw();
   speedDisplay.draw();
   speedUpButton.draw();
}

void mouseClicked(){
   if(startButton.mouseIn()){
     if(!start){
       start = true;
     }else{
       setup();
     }
   }
   if(speedUpButton.mouseIn()){
     speedUp();
   }
   if(speedDownButton.mouseIn()){
     speedDown();
   }
   if(pausePlayButton.mouseIn()){
     pausePlay();
     redraw();
   }
   
   if(!field.checkFlowerDebugs() && mouseY > 50){
      field.addFlower(new Flower(mouseX, mouseY));
   }
}

void keyPressed(){
  if(key == ','){
    speedDown();
  }
  if(key == '.'){
    speedUp();
  }
  if(key == ' '){
    println("Before " + pausePlayButton.getText());
    pausePlay();
    redraw();
    println("After " + pausePlayButton.getText());
  }
  if(key == 'x'){
    setSpeed(1);
  }
  if(key == 'v'){
    setSpeed(16);
  }
  if(key == 'c'){
    dispFPS();
  }
  
  //Translate field
  if(key == 'a'){
    field.left();
  }
  if(key == 'w'){
    field.up();
  }
  if(key == 'd'){
    field.right();
  }
  if(key == 's'){
    field.down();
  }
  
  //Shift whole field to specific flower
  if(key == ']'){
    field.cycleNext();
  }
  if(key == '['){
    field.cyclePrev();
  }
}

void keyReleased(){
  if(key == 'a' || key == 'd'){
    field.resetHori();
  }
  if(key == 'w' || key == 's'){
    field.resetVert();
  }
}

void pausePlay(){
  if(start){
     pausePlayButton.setText("Play");
     start = false;
   }else{
     pausePlayButton.setText("Pause");
     start = true;
   }
}

void speedUp(){
  if(speed < 16){
    speed*=2;
    speedDisplay.setText(speed);
    frameRate(30*speed);
  }
}

void setSpeed(int x){
  speed = x;
  speedDisplay.setText(speed);
  frameRate(30*speed);
}

void speedDown(){
  if(speed > 1){
    speed/=2;
    speedDisplay.setText(speed);
    frameRate(30*speed);
  }
}

void dispFPS(){
  println("FPS: " + round(frameRate));
}