class Flower{
   Map<String, Chromosome> genes;
   
   int size;
   int pSize;
   String name;
   char gender;
   int age;
   int maxAge;
   int children;
   int lastBreed;
   float mutability;
   
   Flower father;
   Flower mother;
   
   int x;
   int y;
   
   int[] visualColor;
   
   /**
   *  Params:
   *    String Name
   *    char Gender
   *    int maxAge
   *    Genotype Size - homozygous when hard-coded
   *    Genotype ColorOne
   *    Genotype ColorTwo
   *    Genotype PetalOne
   *    Genotype PetalTwo
   *    Genotype MutabilityOne
   *    Genotype MutabilityTwo
   */
   Flower(String n, char gen, int ma, Genotype s, Genotype c1, Genotype c2, Genotype p1, Genotype p2, Genotype m1, Genotype m2){
     genes = new HashMap<String, Chromosome>();
     
     genes.put("color", new Chromosome(c1, c2));
     genes.put("size", new Chromosome(s, s));
     genes.put("petal", new Chromosome(p1, p2));
     genes.put("mutability", new Chromosome(m1, m2));
     
     size = ( (Integer) getPhenotype(genes.get("size"), 2) )/2;
     pSize = ceil((Integer)s.getValue()/3);
     
     name = n;
     
     if(match(str(gen), "M|F") == null){
       if(random(1) < .51){
         gender = 'F';
       }else{
         gender = 'M'; 
       }
     }else{
         gender = gen; 
     }
     
     age = 0;
     maxAge = ma;
     children = 0;
     lastBreed = 0;
     mutability = (Float)getPhenotype(genes.get("mutability"),2);
     
     x = (int)random(width - 100) + 50;
     y = (int)random(height - 100) + 50;
     
     visualColor = getVisualColor();
   }
   
   Flower(Flower m, Flower f, String n){
     genes = new HashMap<String, Chromosome>();
     Map<String, Chromosome> mGenes = m.getGenes();
     Map<String, Chromosome> fGenes = f.getGenes();
     
     //Mono-hybrid for Mutability
     /*Must be at the top, for usability sake*/
     Genotype[] mutMono = getMonoHybrid(mGenes.get("mutability"), fGenes.get("mutability"));
     genes.put("mutability", new Chromosome(mutMono[0], mutMono[1]));
     mutability = (Float)getPhenotype(genes.get("mutability"),2);
     
     //Mono-hybrid for Size
     Genotype[] sizeMono = getMonoHybrid(mGenes.get("size"),fGenes.get("size"));
     genes.put("size", new Chromosome(sizeMono[0], sizeMono[1]));
     
     //Mutation for Size
     float sizeMut = random(1);
     if(sizeMut < mutability){
         if(sizeMut < (mutability/2) ){
           int temp = (Integer)genes.get("size").getDomGene().getValue();
           do{
             temp += mutator("size");
           }while(temp < 3);
           genes.get("size").getDomGene().setValue(temp);
           
           if(random(1) < .25){
             genes.get("size").getDomGene().setWeight(1.0);
           }else{
             genes.get("size").getDomGene().setWeight(0.5);
           }
         }else{
           int temp = (Integer)genes.get("size").getRecGene().getValue();
           do{
             temp += mutator("size"); 
           }while(temp < 3);
           genes.get("size").getRecGene().setValue(temp);
           
           if(random(1) < .25){
             genes.get("size").getRecGene().setWeight(1.0);
           }else{
             genes.get("size").getRecGene().setWeight(0.5);
           }
         }
     }
     
     size = ( (Integer)getPhenotype(genes.get("size"), 2) )/2;
     
     pSize = ceil(size/3);
     
     name = n;
     
     age = 0;
     maxAge = getSizeAge(size*2);
     
     if(random(1) < mutability){
       maxAge += mutator("maxAge"); 
     }
     
     children = 0;
     lastBreed = 0;
     
     if(random(1) < .51){
       gender = 'F';
     }else{
       gender = 'M'; 
     }
     
     int centerX = (m.x + f.x)/2;
     int centerY = (m.y + f.y)/2;
     
     do{
       x = (int) random(width);
       y = (int) random(height);
     }while((pow(x - centerX,2) + pow(y - centerY, 2) <= pow(150,2)) || (pow(x - centerX,2) + pow(y - centerY, 2) >= pow(500,2)));
     
     //Mono-hybrid for Color
     Genotype[] colorMono = getMonoHybrid(mGenes.get("color"),fGenes.get("color"));
     genes.put("color", new Chromosome(colorMono[0], colorMono[1]));
     
     //Mutation for Color
     float colorMutator = random(1);
     if(colorMutator < mutability){
       int randIndex = round(random(0,2));
       Integer[] temp = (Integer[])genes.get("color").getDomGene().getValue();
       do{
         temp[randIndex] += mutator("color");
       }while(temp[randIndex] > 255 || temp[randIndex] < 0);
       genes.get("color").getDomGene().setValue(toIntArr(temp));
       
       
       if(random(1) > .25){
         genes.get("color").getDomGene().setWeight(1.0);
       }else{
         genes.get("color").getDomGene().setWeight(0.5);
       }
       
       println("Mutating " + n +  ". New Color One: " + Arrays.toString(getDomColor()));
     }else if(colorMutator < (mutability*2) ){
       int randIndex = round(random(2));
       Integer[] temp = (Integer[])genes.get("color").getRecGene().getValue();
       do{
         temp[randIndex] += mutator("color");
       }while(temp[randIndex] > 255 || temp[randIndex] < 0);
       genes.get("color").getRecGene().setValue(toIntArr(temp));
       
       
       if(random(1) > .25){
         genes.get("color").getRecGene().setWeight(1.0);
       }else{
         genes.get("color").getRecGene().setWeight(0.5);
       }
       
       println("Mutating " + n +  ". New Color Two: " + Arrays.toString(getRecColor()));
     }
     
     visualColor = getVisualColor();
     
     //Mono-hybrid for Petal shape
     Genotype[] petalMono = getMonoHybrid(mGenes.get("petal"), fGenes.get("petal"));
     genes.put("petal", new Chromosome(petalMono[0], petalMono[1]));
     
     if(m.getGender() == 'M'){
       father = m;
       mother = f;
     }else{
       father = f;
       mother = m;
     }
     m.addChild();
     f.addChild();
   }
   
   /** 
   *  Empty constructor.
   *  Used for debug generation of a random flower.
   */
   Flower(int x, int y){
      genes = new HashMap<String, Chromosome>();
      this.x = x;
      this.y = y;
     
      name = "Test_" + (char)(97 + (int)random(26));
     
      if(random(1) < .50){
        gender = 'M';
      }else{
        gender = 'F';
      }
      
      age = 0;
      children = 0;
      lastBreed = 0;
      
      int[] colorOne = new int[3];
      float weightOne = random(1);
      int[] colorTwo = new int[3];
      float weightTwo = random(1);
      
      for(int i = 0; i < colorOne.length; i++){
         colorOne[i] = (int)random(256);
         colorTwo[i] = (int)random(256);
      }
      if(weightOne < 0.5){
        weightOne = 0.5;
      }else{
        weightOne = 1.0;
      }
      if(weightTwo < 0.5){
        weightTwo = 0.5;
      }else{
        weightTwo = 1.0;
      }
      
      genes.put("color", new Chromosome(new Genotype(colorOne, weightOne), new Genotype(colorTwo, weightTwo)));
      
      visualColor = getVisualColor();
      
      int sizeOne = (int)random(12,120);
      weightOne = random(1);
      int sizeTwo = (int)random(12,120);
      weightTwo = random(1);
      if(weightOne < 0.5){
        weightOne = 0.5;
      }else{
        weightOne = 1.0;
      }
      if(weightTwo < 0.5){
        weightTwo = 0.5;
      }else{
        weightTwo = 1.0;
      }
      
      genes.put("size", new Chromosome(new Genotype(sizeOne, weightOne), new Genotype(sizeTwo, weightTwo)));
      
      size = ( (Integer) getPhenotype(genes.get("size"), 2) )/2;
      pSize = ceil(size/3);
      maxAge = getSizeAge(size*2);
      if(random(1) < mutability){
        maxAge += mutator("maxAge"); 
      }
      
      String[] petalTypes = new String[]{"square", "round", "triangle"};
      float[] petalWeights = new float[]{1.0, 0.66, 0.33};
      
      int petalOne = (int)random(3);
      int petalTwo = (int)random(3);
      
      genes.put("petal", new Chromosome(new Genotype(petalTypes[petalOne], petalWeights[petalOne]), new Genotype(petalTypes[petalTwo], petalWeights[petalTwo])));
      
      float mutOne = random(0.02);
      weightOne = random(1);
      float mutTwo = random(0.02);
      weightTwo = random(1);
      if(weightOne < 0.5){
        weightOne = 0.5;
      }else{
        weightOne = 1.0;
      }
      if(weightTwo < 0.5){
        weightTwo = 0.5;
      }else{
        weightTwo = 1.0;
      }
      
      genes.put("mutability", new Chromosome(new Genotype(mutOne, weightOne), new Genotype(mutTwo, weightTwo)));
   }
   
   void draw(){
     rectMode(RADIUS);
     fill(visualColor[0], visualColor[1], visualColor[2]);
     stroke((abs(visualColor[0]-255)), (abs(visualColor[1]-255)), (abs(visualColor[2]-255)));
     
     switch((String)getPhenotype(genes.get("petal"), 1)){
     case "square":
       rect(x, y - size, pSize, pSize);
       rect(x - size, y, pSize, pSize);
       rect(x, y + size, pSize, pSize);
       rect(x + size, y, pSize, pSize);
       break;
     
     case "round":
       ellipseMode(CENTER);
       ellipse(x, y - size, size, size);
       ellipse(x - size, y, size, size);
       ellipse(x, y + size, size, size);
       ellipse(x + size, y, size, size);
       break;
     
     case "triangle":
       triangle(x-(pSize/2), y-size, x, y-size-pSize, x+(pSize/2), y-size);
       triangle(x+size, y-(pSize/2), x+size+pSize, y, x+size, y+(pSize/2));
       triangle(x+(pSize/2), y+size, x, y+size+pSize, x-(pSize/2), y+size);
       triangle(x-size, y+(pSize/2), x-size-pSize, y, x-size, y-(pSize/2));
       break;
     }
     
     rect(x, y, size, size);
     fill(0);
     textAlign(CENTER);
     textSize(12);
     text(name, x, y+3);
     text(age, x, y+15);
     
     if(frameCount%60 == 0){
        age++;
     }
     rectMode(CORNER);
     noStroke();
   }
   
   Map<String, Chromosome> getGenes(){
     return genes;
   }
   
   int getSize(){
     return size; 
   }
   
   String getName(){
     return name;
   }
   
   int[] getDomColor(){
      Integer[] tempVal = (Integer[])genes.get("color").getDomGene().getValue();
      int[] out = new int[tempVal.length];
      for(int i = 0; i < tempVal.length; i++){
        out[i] = tempVal[i];
      }
      return out;
   }
   
   int[] getRecColor(){
      Integer[] tempVal = (Integer[])genes.get("color").getRecGene().getValue();
      int[] out = new int[tempVal.length];
      for(int i = 0; i < tempVal.length; i++){
        out[i] = tempVal[i];
      }
      return out;
   }
   
   int[] getVisualColor(){
     int[] colorOne = getDomColor();
     float weightOne = genes.get("color").getDomGene().getWeight();
     int[] colorTwo = getRecColor();
     float weightTwo = genes.get("color").getRecGene().getWeight();
     
     if(weightOne > weightTwo){
       return colorOne;
     }else if(weightOne == weightTwo){
        int[] newColor = {
          (colorOne[0] + colorTwo[0])/2,
          (colorOne[1] + colorTwo[1])/2,
          (colorOne[2] + colorTwo[2])/2,
        };
        return newColor;
     }else{
       return colorTwo; 
     }
   }
   
   char getGender(){
      return gender;
   }
   
   int getAge(){
      return age;
   }
   
   int getMaxAge(){
      return maxAge;
   }
   
   int getNumChildren(){
     return children;
   }
   
   int getLastBreed(){
     return lastBreed;
   }
   
   int getX(){
     return x;
   }
   
   int getY(){
     return y;
   }
   
   private int getSizeAge(int s){
     int mA = ceil(exp(-pow(s-60,2)/(2*pow(25,2)))/(sqrt(2*PI)*0.00222)+20);
     
     if(random(1) < .05){
       mA += mutator("maxAge");
     }
     
     return mA;
   }
   
   void setLastBreed(){
     lastBreed = frameCount;
   }
   
   int mutator(String flag){
     switch(flag){
       case "size":
         return (int)random(-60,60);
       case "maxAge":
         return (int)random(-25,25);
       case "color":
         return (int)random(-30,30);
       default:
         return 1;
     }
   }
   
   boolean canBreed(){
     if(age >= 30){
       if(lastBreed <= (frameCount - 1000) && gender == 'M'){
         return true; 
       }else if( lastBreed <= (frameCount - 1400) && gender == 'F'){
         return true;
       }else{
         return false;
       }
     }
     return false;
   }
   
   void addChild(){
     children++;
   }
   
   boolean mouseIn(){
     if(mouseX >= (x-size) && mouseX <= (x+size)){
      if(mouseY >= (y-size) && mouseY <= (y+size)){
        return true;
      }else{
        return false;
      }
    }else{
      return false;
    }
   }
   
   void debug(){
     int bioH = 0;
      if(mother != null){
        bioH = 840;
      }else{
        bioH = 770;
      }
      BioScreen bio = new BioScreen(this, 500, bioH);
      runSketch(new String[]{""}, bio);
   }
   
   int[] toIntArr(Integer[] toBuild){
     int[] out = new int[toBuild.length];
     for(int i = 0; i < out.length; i++){
       out[i] = toBuild[i];
     }
     return out;
   }
   
   Genotype[] getMonoHybrid(Chromosome m, Chromosome f){
     Genotype[] out = new Genotype[2];
     float monoChance = random(1);
     if(monoChance < .25){
       out[0] = m.getDomGene();
       out[1] = f.getDomGene();
     }else if(monoChance < .5){
       out[0] = m.getDomGene();
       out[1] = f.getRecGene();
     }else if(monoChance < .75){
       out[0] = m.getRecGene();
       out[1] = f.getDomGene();
     }else{
       out[0] = m.getRecGene();
       out[1] = f.getRecGene();
     }
     return out;
   }
   
   /**
   *  Params
   *    Chromosome Gene - the two genotypes to decide a phenotype from
   *    int Type - the dominance type for this decision
   *      1 - complete dominance    -All String values must be type 1
   *      2 - co-dominance
   */
   Object getPhenotype(Chromosome gene, int type){
     if(type == 1){ // Type 1
       if(gene.getDomGene().getValue() instanceof Integer){
         return (Integer)gene.getDomGene().getValue();
       }else if(gene.getDomGene().getValue() instanceof Integer[]){
         return (Integer[])gene.getDomGene().getValue();
       }else if(gene.getDomGene().getValue() instanceof Float){
         return (Float)gene.getDomGene().getValue();
       }else if(gene.getDomGene().getValue() instanceof String){
         return (String)gene.getDomGene().getValue();
       }else{
         return null;
       }
     }
     else{ //Type 2
       if(gene.getDomGene().getValue() instanceof Integer){
         if(gene.getDomGene().getWeight() == gene.getRecGene().getWeight()){
          if((Integer)gene.getDomGene().getValue() >= (Integer)gene.getRecGene().getValue()){
            return (Integer)ceil( random( (Integer)gene.getRecGene().getValue(), (Integer)gene.getDomGene().getValue() ) );
          }else{
            return (Integer)ceil( random( (Integer)gene.getDomGene().getValue(), (Integer)gene.getRecGene().getValue() ) );
          }
        }else{
          return (Integer)gene.getDomGene().getValue();
        }
       }else if(gene.getDomGene().getValue() instanceof Integer[]){
         return new Integer[2];
       }else if(gene.getDomGene().getValue() instanceof String){
         return (String)gene.getDomGene().getValue();
       }else if(gene.getDomGene().getValue() instanceof Float){
         if(gene.getDomGene().getWeight() == gene.getRecGene().getWeight()){
           if((Float)gene.getDomGene().getValue() >= (Float)gene.getRecGene().getValue()){
             return (Float)random( (Float)gene.getRecGene().getValue(), (Float)gene.getDomGene().getValue() );
           }else{
             return (Float)random( (Float)gene.getDomGene().getValue(), (Float)gene.getRecGene().getValue() );
           }
         }else{
           return (Float)gene.getDomGene().getValue();
         }
       }else{
         return null;
       }
     }
  }
}