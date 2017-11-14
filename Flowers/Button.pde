  class Button{
  int x;
  int y;
  int w;
  int h;
  String text; 
  
  Button(int start, int wid, int hei, String display){
    x = start;
    y = start;
    w = wid;
    h = hei;
    text = display;
  }
  
  Button(int startX, int startY, int width, int height, String display){
    x = startX;
    y = startY;
    w = width;
    h = height;
    text = display;
  }
  
  String getText(){
    return text;
  }
  
  void setText(String s){
    text = s;
  }
  
  void draw(){
    fill(120,220,120);
    rect(x, y, w, h);
    fill(0);
    textAlign(CENTER);
    textSize(24);
    text(text, (x + (w/2)), (y + (h/2)+9));
  }
  
  boolean mouseIn(){
    if(mouseX >= x && mouseX <= (x+w)){
      if(mouseY >= y && mouseY <= (y+h)){
        return true;
      }else{
        return false;
      }
    }else{
      return false;
    }
  }
}