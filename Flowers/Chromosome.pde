class Chromosome{
  Genotype geneOne;
  Genotype geneTwo;
  
  Chromosome(){
    geneOne = null;
    geneTwo = null;
  }
  
  Chromosome(Genotype gOne, Genotype gTwo){
    geneOne = gOne;
    geneTwo = gTwo;
  }
  
  void setGeneOne(Genotype gene){
    geneOne = gene;
  }
  
  void setGeneTwo(Genotype gene){
    geneTwo = gene;
  }
  
  Genotype getDomGene(){
    if(geneOne.getWeight() > geneTwo.getWeight()){
      return geneOne;
    }else{
      return geneTwo;
    }
  }
  
  Genotype getRecGene(){
    if(geneOne.getWeight() <= geneTwo.getWeight()){
      return geneOne;
    }else{
      return geneTwo;
    }
  }
}