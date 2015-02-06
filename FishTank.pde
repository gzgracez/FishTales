class FishTank {

  private ArrayList <Tankable> items=new ArrayList<Tankable>();
  private int ammoniaLevel;
  private float tWidth, tHeight;
  private String name;

  FishTank(String name, float w, float h) {
    this.name=name;
    this.tWidth=w;
    this.tHeight=h;
    this.ammoniaLevel=0;
  }

  public void updateAll() {
    for (Tankable t: items) {
      t.update();
    }
  }
  public void showAll() {
    for (Tankable t: items) {
      t.show();
    }
  }

  public int getAmmoniaLevel() { 
    return ammoniaLevel;
  }
  public void tapTheTank() {
    /*int count=0;
     if (count<10) {//tap the tank
     count++;
     translate(random(-20, 20), random(-10, 10));
     }*/
    for (Tankable t: items) {
      t.bump();
    }
  }
  public int waterLevel() {
    return 1;
  }
  public int cleanTheTank() {
    return 1;
  }
  public boolean add(Tankable t) {
    return items.add(t);
  }
  public boolean remove(Tankable t) {
    return items.remove(t);
  }
}

