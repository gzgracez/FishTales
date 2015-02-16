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

  public void updateAll() {//show & move
    shakeTank();//tapTheTank
    for (Tankable t : items) {
      t.update();
    }
    resetMatrix();
    for (int a=0; a<items.size (); a++) {
      for (int b=0; b<items.size (); b++) {
        if (items.get(a)!=items.get(b)) {
          if (items.get(a).hasCollision(items.get(b))) {
            println("COLLISION");
            if (items.get(a) instanceof Fish) {
              println("a IS FISH");
              Fish f1=(Fish)items.get(a);
              if (f1.tryToEat(items.get(b))) {
                items.remove(items.get(b));
                b--;
                println("FISH");
              }
            }
          }
        }
      }
    }
  }

  public void showAll() {//show
    shakeTank();
    for (Tankable t : items) {
      t.show();
    }
    resetMatrix();
  }

  public void tapTheTank() {
    tapped=true;
    tapCount=0;
  }

  public int getAmmoniaLevel() { 
    return ammoniaLevel;
  }

  public int waterLevel() {
    return 1;
  }

  public int cleanTheTank() {
    return 1;
  }

  public void reset() {
    for (int i=items.size ()-1; i>=0; i--) {
      items.remove(i);
    }
  }

  public boolean add(Tankable t) {
    return items.add(t);
  }
  public boolean remove(Tankable t) {
    return items.remove(t);
  }

  public void shakeTank() {//translating for tapTheTank
    if (tapCount>=11) tapped=false;
    if (tapped && tapCount<11) {
      for (Tankable t : items) {
        if (t instanceof Fish) t.bump();
      }
      tapCount++;
      translate(random(-20, 20), random(-10, 10));
    }
  }
}

