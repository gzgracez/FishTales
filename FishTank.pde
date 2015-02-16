class FishTank {

  private ArrayList <Tankable> items=new ArrayList<Tankable>();
  private int ammoniaLevel;
  private float tWidth, tHeight;
  private String name;
  private boolean tapped;
  private int tapCount;

  FishTank(String name, float w, float h) {
    this.name=name;
    this.tWidth=w;
    this.tHeight=h;
    this.ammoniaLevel=0;
  }

  public void updateAll() {
    for (Tankable t : items) {
      if (tapCount>=10) tapped=false;
      if (tapped && tapCount<10) {
        t.bump();
        tapCount++;
        translate(random(-20, 20), random(-10, 10));
      }
      t.update();
      resetMatrix();
    }
    for (Tankable a : items) {
      for (Tankable b : items) {
        if (a!=b) {
        }
      }
    }
  }
  public void showAll() {
    for (Tankable t : items) {
      t.show();
    }
  }

  public int getAmmoniaLevel() { 
    return ammoniaLevel;
  }
  public void tapTheTank() {
    tapped=true;
    tapCount=0;
  }
  public int waterLevel() {
    return 1;
  }
  public int cleanTheTank() {
    return 1;
  }
  public void reset() {
    for (Tankable t : items) {
    }
  }
  public boolean add(Tankable t) {
    return items.add(t);
  }
  public boolean remove(Tankable t) {
    return items.remove(t);
  }
}

