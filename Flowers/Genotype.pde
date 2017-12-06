class Genotype{
  Object value;
  float weight;
  
  public Genotype(int value, float weight){
    this.value = new Integer(value);
    this.weight = weight;
  }
  
  public Genotype(int[] value, float weight){
    Integer[] newValue = new Integer[value.length];
      for(int i = 0; i < value.length; i++){
        newValue[i] = value[i];
      }
    this.value = newValue;
    this.weight = weight;
  }
  
  public Genotype(char value, float weight){
    this.value = (Character)value;
    this.weight = weight;
  }
  
  public Genotype(String value, float weight){
    this.value = value;
    this.weight = weight;
  }
  
  public Genotype(float value, float weight){
    this.value = new Float(value);
    this.weight = weight;
  }
  
  public Object getValue(){
    return value;
  }
  
  public float getWeight(){
    return weight;
  }
  
  public void setValue(int value){
    this.value = new Integer(value);
  }
  
  public void setValue(int[] value){
    Integer[] newValue = new Integer[value.length];
      for(int i = 0; i < value.length; i++){
        newValue[i] = value[i];
      }
    this.value = newValue;
  }
  
  public void setValue(char value){
    this.value = (Character)value;
  }
  
  public void setValue(String value){
    this.value = value;
  }
  
  public void setValue(float value){
    this.value = new Float(value);
  }
  
  void setWeight(float weight){
    this.weight = weight;
  }
}