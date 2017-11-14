class BioScreen extends PApplet{
  
  Object entity;
  ArrayList<BioText> debug;
  int bioW;
  int bioH;
  
  int textStartY;
  
  BioScreen(Object entity, int w, int h){
    this.entity = entity;
    bioW = w;
    bioH = h;
    debug = new ArrayList<BioText>();
    textStartY = 0;
    
    buildDebug();
  }
  
  public void settings(){
    size(bioW, bioH);
  }
  
  void draw(){
    background(95);
    
    fill(0);
    for( BioText t : debug){
      noStroke();
      t.draw();
    }
  }
  
  void buildDebug(){
    if(entity instanceof Flower){
      Flower temp = (Flower)entity;
      textStartY = 24;
      debug.add(new BioText("Name: " + temp.getName(), 50, textStartY, (bioW - 100), 24));
      textStartY += 36;
      debug.add(new BioText("Gender: " + temp.getGender(), 50, textStartY, (bioW - 100), 24));
      textStartY += 36;
      debug.add(new BioText("Size: " + temp.getSize(), 50, textStartY, (bioW - 100), 24));
      textStartY += 36;
      debug.add(new BioText("Max Age: " + temp.getMaxAge(), 50, textStartY, (bioW - 100), 24));
      if(temp.mother != null){
        textStartY += 36;
        debug.add(new BioText("Mother: " + temp.mother.getName(), 50, textStartY, (bioW - 100), 24));
        textStartY += 36;
        debug.add(new BioText("Father: " + temp.father.getName(), 50, textStartY, (bioW - 100), 24));
      }
      textStartY += 36;
      debug.add(new BioText("Children: " + temp.getNumChildren(), 50, textStartY, (bioW - 100), 24));
      textStartY += 36;
      debug.add(new BioText("Last Breed: " + temp.getLastBreed(), 50, textStartY, (bioW - 100), 24));
      textStartY += 36;
      debug.add(new BioText("GENES", 50, textStartY, (bioW - 100), 24));
      textStartY += 36;
      
      /*Color*/
      debug.add(new BioText("Color One: " + Arrays.toString((Integer[])temp.getGenes().get("color").getDomGene().getValue()), 50, textStartY, (bioW - 100), 24));
      textStartY += 24;
      debug.add(new BioText("Weight: " + temp.getGenes().get("color").getDomGene().getWeight(), 50, textStartY, (bioW - 100), 24));
      textStartY += 36;
      debug.add(new BioText("Color Two: " + Arrays.toString((Integer[])temp.getGenes().get("color").getRecGene().getValue()), 50, textStartY, (bioW - 100), 24));
      textStartY += 24;
      debug.add(new BioText("Weight: " + temp.getGenes().get("color").getRecGene().getWeight(), 50, textStartY, (bioW - 100), 24));
      
      /*Size*/
      textStartY += 36;
      debug.add(new BioText("Size One: " + temp.getGenes().get("size").getDomGene().getValue(), 50, textStartY, (bioW - 100), 24));
      textStartY += 24;
      debug.add(new BioText("Weight: " + temp.getGenes().get("size").getDomGene().getWeight(), 50, textStartY, (bioW - 100), 24));
      textStartY += 36;
      debug.add(new BioText("Size Two: " + temp.getGenes().get("size").getRecGene().getValue(), 50, textStartY, (bioW - 100), 24));
      textStartY += 24;
      debug.add(new BioText("Weight: " + temp.getGenes().get("size").getRecGene().getWeight(), 50, textStartY, (bioW - 100), 24));
      
      /*Petals*/
      textStartY += 36;
      debug.add(new BioText("Petal One: " + temp.getGenes().get("petal").getDomGene().getValue(), 50, textStartY, (bioW - 100), 24));
      textStartY += 24;
      debug.add(new BioText("Weight: " + temp.getGenes().get("petal").getDomGene().getWeight(), 50, textStartY, (bioW - 100), 24));
      textStartY += 36;
      debug.add(new BioText("Petal Two: " + temp.getGenes().get("petal").getRecGene().getValue(), 50, textStartY, (bioW - 100), 24));
      textStartY += 24;
      debug.add(new BioText("Weight: " + temp.getGenes().get("petal").getRecGene().getWeight(), 50, textStartY, (bioW - 100), 24));
      
      /*Mutability*/
      textStartY += 36;
      debug.add(new BioText("Mutability One: " + temp.getGenes().get("mutability").getDomGene().getValue(), 50, textStartY, (bioW - 100), 24));
      textStartY += 24;
      debug.add(new BioText("Weight: " + temp.getGenes().get("mutability").getDomGene().getWeight(), 50, textStartY, (bioW - 100), 24));
      textStartY += 36;
      debug.add(new BioText("Mutability Two: " + temp.getGenes().get("mutability").getRecGene().getValue(), 50, textStartY, (bioW - 100), 24));
      textStartY += 24;
      debug.add(new BioText("Weight: " + temp.getGenes().get("mutability").getRecGene().getWeight(), 50, textStartY, (bioW - 100), 24));
    }
  }
  
  void exit(){
    this.dispose();
  }
  
  class BioText{
    String text;
    int x;
    int y;
    int w;
    int h;
    
    int fontSize;
    String fontAlign;
    int[] fontColor;
    int[] backGroundColor;
    
    BioText(String text, int x, int y, int w, int h){
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
    
    BioText(int text, int x, int y, int w, int h){
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
      textAlign(CENTER);
      fill(fontColor[0], fontColor[1], fontColor[2]);
      text(text, x + (w/2), (y + (h/2) + (9))); 
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
  
}