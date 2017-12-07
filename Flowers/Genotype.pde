class Genotype{
  Object value;
  float weight;
  
  public Genotype(Integer value, float weight){
    this.value = value;
    this.weight = weight;
  }
  
  public Genotype(Integer[] value, float weight){
    this.value = value;
    this.weight = weight;
  }
  
  public Genotype(Character value, float weight){
    this.value = value;
    this.weight = weight;
  }
  
  public Genotype(String value, float weight){
    this.value = value;
    this.weight = weight;
  }
  
  public Genotype(Float value, float weight){
    this.value = value;
    this.weight = weight;
  }
  
  public Object getValue(){
    return value;
  }
  
  public float getWeight(){
    return weight;
  }
  
  public void setValue(Integer value){
    this.value = value;
  }
  
  public void setValue(Integer[] value){
    this.value = value;
  }
  
  public void setValue(Character value){
    this.value = value;
  }
  
  public void setValue(String value){
    this.value = value;
  }
  
  public void setValue(Float value){
    this.value = value;
  }
  
  void setWeight(float weight){
    this.weight = weight;
  }
}