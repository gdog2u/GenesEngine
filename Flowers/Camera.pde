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
    pos.y += vertMove;
    pos.x -= horiMove;
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