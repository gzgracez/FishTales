class Bubbles implements Tankable {  
  private float bX, bY;
  private float bSize;
  private float move;
  private float stopX1, stopX2;
  private FishTank tank=theTank;

  Bubbles(float x, float y, float s) {
    bX=x;
    bY=y;
    bSize=s;
    move=random(-2, 2);
    stopX1=bX-2;
    stopX2=bX+2;
  }

  Bubbles(float x, float y, float s, FishTank t) {
    bX=x;
    bY=y;
    bSize=s;
    move=random(-2, 2);
    stopX1=bX-2;
    stopX2=bX+2;
    tank=t;
  }

  public void show() {
    noFill();
    stroke(255);
    ellipse(bX, bY, bSize, bSize);
  }

  public void move() {
    Random generator;
    generator=new Random();
    bY-=random(0, 2);
    bX+=generator.nextGaussian();
    ;
  }

  public void update() {
    show();
    move();
  }
  public boolean stillKickin() {
    if (bY<=-bSize) return false;
    return true;
  }
  public void bump() {
  }
  public boolean hasCollision(Tankable t) {
    return false;
  }
  public float getRadius() {
    return bSize/2;
  }
  public float getX() {
    return bX;
  }
  public float getY() {
    return bY;
  }
}

