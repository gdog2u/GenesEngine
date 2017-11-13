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
   */
   Flower(String n, char gen, int ma, Genotype s, Genotype c1, Genotype c2, Genotype p1, Genotype p2){
     genes = new HashMap<String, Chromosome>();
     
     genes.put("color", new Chromosome(c1, c2));
     genes.put("size", new Chromosome(s, s));
     genes.put("petal", new Chromosome(p1, p2));
     
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
     
     x = (int)random(width - 100) + 50;
     y = (int)random(height - 100) + 50;
     
     visualColor = getVisualColor();
   }
   
   Flower(Flower m, Flower f, String n){
     genes = new HashMap<String, Chromosome>();
     Map<String, Chromosome> mGenes = m.getGenes();
     Map<String, Chromosome> fGenes = f.getGenes();
     
     //Mono-hybrid for Size
     Genotype[] sizeMono = getMonoHybrid(mGenes.get("size"),fGenes.get("size"));
     genes.put("size", new Chromosome(sizeMono[0], sizeMono[1]));
     
     //Mutation for Size
     float sizeMut = random(1);
     if(sizeMut < 0.1){
         if(sizeMut < 0.05){
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
     
     if(random(1) < 0.1){
       maxAge += mutator("maxAge"); 
     }
     
     children = 0;
     lastBreed = 0;
     
     if(random(1) < .51){
       gender = 'F';
     }else{
       gender = 'M'; 
     }
     
     x = (int)random(0, width-size*2);
     y = (int)random(75, height-size*2);
     
     
     //Mono-hybrid for Color
     Genotype[] colorMono = getMonoHybrid(mGenes.get("color"),fGenes.get("color"));
     genes.put("color", new Chromosome(colorMono[0], colorMono[1]));
     
     //Mutation for Color
     float colorMutator = random(1);
     if(colorMutator < .025){
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
     }else if(colorMutator < .05){
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
   
   int getVisualSize(){
     int sizeOne = (Integer)genes.get("size").getDomGene().getValue();
     float weightOne = genes.get("size").getDomGene().getWeight();
     int sizeTwo = (Integer)genes.get("size").getRecGene().getValue();
     float weightTwo = genes.get("size").getRecGene().getWeight();
     
     if(weightOne > weightTwo){
       return sizeOne/2;
     }else if(weightOne == weightTwo){
       if(sizeOne >= sizeTwo){
         return (int)random(sizeTwo, sizeOne)/2;
       }else{
         return (int)random(sizeOne, sizeTwo)/2;
       }
     }else{
       return sizeTwo/2;
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
       if(lastBreed <= (frameCount + 200) && gender == 'M'){
         return true; 
       }else if( lastBreed <= (frameCount + 400) && gender == 'F'){
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
      println("Name: " + name);
      println("Gender: " + gender);
      println("Size: " + size);
      println("Max Age: " + maxAge);
      if(mother != null){
        println("Mother: " + mother.getName());
        println("Father: " + father.getName());
      }
      println("Children: " + children);
      println("Last Breed: " + lastBreed);
      println("\n        GENES");
      println("Color One: " + Arrays.toString(getDomColor()));
      println("    Weight: " + genes.get("color").getDomGene().getWeight());                                    
      println("Color Two: " + Arrays.toString(getRecColor()));
      println("    Weight: " + genes.get("color").getRecGene().getWeight());
      
      println("Size One: " + genes.get("size").getDomGene().getValue());
      println("    Weight: " + genes.get("size").getDomGene().getWeight());
      println("Size Two: " + genes.get("size").getRecGene().getValue());
      println("    Weight: " + genes.get("size").getRecGene().getWeight());
      
      println("Petal One: " + genes.get("petal").getDomGene().getValue());
      println("    Weight: " + genes.get("petal").getDomGene().getWeight());
      println("Petal Two: " + genes.get("petal").getRecGene().getValue());
      println("    Weight: " + genes.get("petal").getRecGene().getWeight());
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
     if(gene.getDomGene().getValue() instanceof Integer){
       if(type == 1){
         return (Integer)gene.getDomGene().getValue();
       }else /*if(type == 2)*/{
         if(gene.getDomGene().getWeight() == gene.getRecGene().getWeight()){
           if((Integer)gene.getDomGene().getValue() >= (Integer)gene.getRecGene().getValue()){
              return (Integer)ceil( random( (Integer)gene.getRecGene().getValue(), (Integer)gene.getDomGene().getValue() ) );
           }else{
              return (Integer)ceil( random( (Integer)gene.getDomGene().getValue(), (Integer)gene.getRecGene().getValue() ) );
           }
         }else{
           return (Integer)gene.getDomGene().getValue();
         }
       }
     }else if(gene.getDomGene().getValue() instanceof Integer[]){
       return new Integer[2];
     }else if(gene.getDomGene().getValue() instanceof String){
       return gene.getDomGene().getValue();
     }else{
       return new Integer(1);
     }
   }
}