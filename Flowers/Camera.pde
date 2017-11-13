class Camera{
  PVector pos;
  int vertMove;
  int horiMove;
  int speedMove;
  
  Camera(){
    pos = new PVector(0,0);  
    speedMove = 16;
  }
  
  void draw(){
    pos.y += ceil(vertMove/speed);
    pos.x -= ceil(horiMove/speed);
  }
  
  void left(){
    horiMove = speedMove;
  }
  void up(){
    vertMove = -speedMove;
  }
  void right(){
    horiMove = -speedMove;
  }
  void down(){
    vertMove = speedMove;
  }
  void resetHori(){
    horiMove = 0;
  }
  void resetVert(){
    vertMove = 0;
  }
}