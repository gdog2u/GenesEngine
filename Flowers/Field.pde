
class Field{
   ArrayList<Flower> field;
   int maxSize;
   int totalLived;
   //translation variables
   int speedMove, horiMove, vertMove;
   //cycle variables
   int currentCycle, centerX, centerY, distX, distY;
   
   Field(int ms){
      field = new ArrayList<Flower>();
      maxSize = ms;
      totalLived = 0;
      speedMove = 16;
      currentCycle = -1;
      centerX = width/2;
      centerY = height/2;
   }
   
   void addFlower(Flower f){
      if(getFieldSize() + 1 < maxSize){
         field.add(f);
         totalLived++;
      }else{
         return;
      }
   }
   
   void drawFlowers(){
     
     if(field.size() == 0){
       println("Your flowers have all died.");
       println("Click anywhere to begin again.");
     }
     
     if(field.size() > 1){
        int parentOne;
        int parentTwo;
        
        parentOne = floor(random(getFieldSize()));
        parentTwo = floor(random(getFieldSize()));
        
        if(field.get(parentOne).getGender() != field.get(parentTwo).getGender() 
            && (field.get(parentOne).canBreed() && field.get(parentTwo).canBreed())
            && (dist(field.get(parentOne).x, field.get(parentOne).y, field.get(parentTwo).x, field.get(parentTwo).y) < 500)
        ){
           birthChild(field.get(parentOne), field.get(parentTwo));
        }
      }
      for(int i = 0; i < getFieldSize(); i++){
         if(toKill(field.get(i))){
            killFlower(field.get(i));
         }else{
            if(horiMove != 0 || vertMove != 0){
              field.get(i).x += ceil(horiMove/speed);
              field.get(i).y += ceil(vertMove/speed);
            }
            field.get(i).draw();
         }
      } 
   }
   
   void birthChild(Flower m, Flower f){
      addFlower(new Flower(m, f, "child" + (getTotalLived()-19)));
      m.setLastBreed();
      f.setLastBreed();
   }
   
   void killFlower(Flower f){
      field.remove(f);
   }
   
   boolean toKill(Flower f){
      if(f.getAge() >= f.getMaxAge()){
         return true;
      }else{
         return false;
      }
   }
   
   int getFieldSize(){
      return field.size(); 
   }
   
   int getTotalLived(){
     return totalLived; 
   }
   
   boolean checkFlowerDebugs(){
     for(Flower f : field){
       if(f.mouseIn()){
         f.debug();
         return true;
       }
     }
     return false;
   }
   
  void left(){
    horiMove = speedMove;
  }
  void up(){
    vertMove = speedMove;
  }
  void right(){
    horiMove = -speedMove;
  }
  void down(){
    vertMove = -speedMove;
  }
  void resetHori(){
    horiMove = 0;
  }
  void resetVert(){
    vertMove = 0;
  }
  
  void cycleNext(){
    currentCycle++;
    if(currentCycle >= field.size()){
      currentCycle = 0;
    }
      println("cycled to " + currentCycle + "/" + field.size());
    Flower temp = field.get(currentCycle);
    distX = temp.x-centerX;
    distY = temp.y-centerY;
    temp.x = centerX;
    temp.y = centerY;
    shiftWorld();
  }
  
  void cyclePrev(){
    currentCycle--;
    if(currentCycle < 0){
      currentCycle = field.size()-1;
    }
      println("cycled to " + currentCycle + "/" + field.size());
    Flower temp = field.get(currentCycle);
    distX = temp.x-centerX;
    distY = temp.y-centerY;
    temp.x = centerX;
    temp.y = centerY;
    shiftWorld();
  }
  
  void shiftWorld(){
    for(int i = 0; i < field.size(); i++){
      if(i != currentCycle){
        field.get(i).x-=distX;
        field.get(i).y-=distY;
      }
    }
  }
}