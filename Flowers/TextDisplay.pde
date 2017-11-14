class TextDisplay{
  String text;
  int x;
  int y;
  int w;
  int h;
  
  int fontSize;
  String fontAlign;
  int[] fontColor;
  int[] backGroundColor;
  
  TextDisplay(String text, int x, int y, int w, int h){
    this.text = text;
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    
    fontSize = 24;
    fontAlign = "CENTER";
    fontColor = new int[]{0,0,0};
    backGroundColor = new int[]{255,255,255};
  }
  
  TextDisplay(int text, int x, int y, int w, int h){
    this.text = new Integer(text).toString();
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    
    fontSize = 24;
    fontAlign = "CENTER";
    fontColor = new int[]{0,0,0};
    backGroundColor = new int[]{255,255,255};
  }
  
  void draw(){
    fill(backGroundColor[0], backGroundColor[1], backGroundColor[2]);
    rect(x,y,w,h);
    textSize(fontSize);
    fill(fontColor[0], fontColor[1], fontColor[2]);
    text(text, (x + (w/2)), (y + (h/2) + (9))); 
  }
  
  void setText(String newText){
    text = newText;
  }
  
  void setText(int newText){
    text = new Integer(newText).toString();
  }
  
  String getText(){
    return text;
  }
}