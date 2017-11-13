class Camera{
  PVector pos;
  
  Camera(){
    pos = new PVector(0,0);  
  }
  
  void draw(){
    if(keyPressed){
      switch(key){
        case 'w':
          pos.y -= 5;
          break;
        case 'd':
          pos.x += 5;
          break;
        case 's':
          pos.y += 5;
          break;
        case 'a':
          pos.x -= 5;
          break;
        default:
          println("failed");
          break;
      }
    }
  }
}