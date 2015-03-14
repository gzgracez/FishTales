class Seaweed implements Tankable {
  private float posX;
  private float sizeScale;
  private FishTank tank=theTank;
  private PImage[] seaweed = new PImage [8];
  private float count=0;
  private int pNum=1;

  Seaweed() {
    for (int i=1; i<9; i++) {
      seaweed[i-1]=loadImage("Seaweed"+i + ".png");
    }
    posX=random(0, 3.0*tank.getTWidth()/12.0);
    sizeScale=random(0.5, 1.1);
  }
  Seaweed(int x) {
    for (int i=1; i<9; i++) {
      seaweed[i-1]=loadImage("Seaweed"+i + ".png");
    }
    if (x==1) {
      posX=random(0, 3.0*tank.getTWidth()/12.0);
    } else if (x==2) {
      posX=random(5.0*tank.getTWidth()/12.0, 8.0*tank.getTWidth()/12.0);
    } else {
      posX=random(9.0*tank.getTWidth()/12.0, tank.getTWidth()-seaweed[pNum].width);
    }
    sizeScale=random(0.5, 1.1);
  }
  Seaweed(FishTank tank) {
    for (int i=1; i<9; i++) {
      seaweed[i-1]=loadImage("Seaweed"+i + ".png");
    }
    posX=random(0, 3.0*tank.getTWidth()/12.0);
    sizeScale=random(0.5, 1.1);
    this.tank=tank;
  }
  Seaweed(int x, FishTank tank) {
    for (int i=1; i<9; i++) {
      seaweed[i-1]=loadImage("Seaweed"+i + ".png");
    }
    if (x==1) {
      posX=random(0, 3.0*tank.getTWidth()/12.0);
    } else if (x==2) {
      posX=random(5.0*tank.getTWidth()/12.0, 8.0*tank.getTWidth()/12.0);
    } else {
      posX=random(9.0*tank.getTWidth()/12.0, tank.getTWidth()-seaweed[pNum].width);
    }
    sizeScale=random(0.5, 1.1);
    this.tank=tank;
  }
  public float getX() {
    return posX;
  }
  public float getY() {
    return tank.getTHeight();
  }
  public float getRadius() {
    return (sizeScale*seaweed[pNum].height)/2;
  }
  public boolean stillKickin() {
    return true;
  }
  public boolean hasCollision(Tankable t) {
    if (t instanceof Goldfish) {
      Goldfish g=(Goldfish)t;
      if ((g.getX()>posX) && (g.getX()<(posX+sizeScale*seaweed[pNum].width)) && (g.getY()>tank.getTHeight()-sizeScale*seaweed[pNum].height)) {
        g.setNoPiranha(true);
      } else {
        g.setNoPiranha(false);
      }
    }
    return false;
  }
  public void bump() {
  }
  public void update() {
    show();
    move();
  }
  public void show() {
    imageMode(CORNER);
    image(seaweed[pNum], posX, tank.getTHeight()-sizeScale*seaweed[pNum].height, sizeScale*seaweed[pNum].width, sizeScale*seaweed[pNum].height);
  }
  public void move() {
    count+=0.05;
    pNum=(int)(count%8);
  }
}
