class FishTank {

  private ArrayList <Tankable> items=new ArrayList<Tankable>();
  private float ammoniaLevel;
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
    if (ammoniaLevel<=31) background(ammoniaLevel, 150-ammoniaLevel, 255-ammoniaLevel);//background
    else if (ammoniaLevel>31 && ammoniaLevel<=127) background(ammoniaLevel, 119, 255-ammoniaLevel);
    else if (ammoniaLevel>127 && ammoniaLevel<=198) background(127, 119, 255-ammoniaLevel);
    else background(127, 119, 57);
    ammoniaLevel=0;
    shakeTank();//tapTheTank
    for (Tankable t : items) {
      t.update();
      if (t instanceof Fish) {
        Fish tFish=(Fish)t;
        ammoniaLevel+=tFish.getFishAmmonia();
      }
    }
    resetMatrix();
    for (int a=0; a<items.size (); a++) {
      Tankable t1=items.get(a);
      if (t1.stillKickin()) {
        for (int b=0; b<items.size (); b++) {
          Tankable t2=items.get(b);
          if (t1!=t2) {
            if (t1.hasCollision(t2)) {
              if (t1 instanceof Fish) {
                if (((Fish)t1).tryToEat(t2)) {
                  items.remove(t2);
                  b--;
                }
              }//end - t1 instanceof fish  
              else if (t1 instanceof Pellet && t2 instanceof Pellet) {
                t1.bump();
                t2.bump();
              }
            }//end collision has happened
          }
        }
      }
    }
  }

  public void showAll() {//show
    if (ammoniaLevel<=31) background(ammoniaLevel, 150-ammoniaLevel, 255-ammoniaLevel);//background
    else if (ammoniaLevel>31 && ammoniaLevel<=127) background(ammoniaLevel, 119, 255-ammoniaLevel);
    else if (ammoniaLevel>127 && ammoniaLevel<=198) background(127, 119, 255-ammoniaLevel);
    else background(127, 119, 57);
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

  public float getAmmoniaLevel() { 
    return ammoniaLevel;
  }

  public int waterLevel() {
    return 1;
  }

  public int cleanTheTank() {
    return 1;
  }

  public int tankSize() {
    return items.size();
  }

  public void reset() {
    for (int i=items.size()-1; i>=0; i--) {
      items.remove(i);
    }
  }

  public boolean add(Tankable t) {
    return items.add(t);
  }
  public boolean remove(Tankable t) {
    return items.remove(t);
  }
  public boolean contains(Tankable t) {
    if (items.contains(t)) return true;
    else return false;
  }
  public Tankable get(int index) {
    return items.get(index);
  }
  public Goldfish getLiveGoldfish() {
    int index=(int)random(0, items.size());
    while (! (items.get (index) instanceof Goldfish) || (!items.get(index).stillKickin())) {
      index=(int)random(0, items.size());
    }
    Goldfish g=(Goldfish)items.get(index);
    return g;
  }


  public void shakeTank() {//translating for tapTheTank
    if (tapCount>=11) tapped=false;
    if (tapped && tapCount<11) {
      for (Tankable t : items) {
        if (t instanceof Fish) {
          t.bump();
          if (tapCount==10) {
            //(Fish)t.changeSpeeds(-1*(Fish)t.getSpeedX,-1*(Fish)t.getSpeedY);
          }
        }
      }
      tapCount++;
      translate(random(-20, 20), random(-10, 10));
    }
  }
}

