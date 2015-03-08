class Bubbles implements Tankable {  
  private float bX, bY;
  private float bSize;
  private float move;
  private float stopX1, stopX2;

  Bubbles(float x, float y, float s) {
    bX=x;
    bY=y;
    bSize=s;
    move=2;
    stopX1=bX-2;
    stopX2=bX+2;
  }

  public void show() {
    noFill();
    stroke(255);
    ellipse(bX, bY, bSize, bSize);
  }

  public void move() {
    if (bY>-bSize) {
      bY--;
      bX+=move/10;
    }
    if (bX<=stopX1)
      move=-1*move;
    else if (bX>=stopX2)
      move=-1*move;
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

