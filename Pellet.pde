class Pellet implements Tankable {

  private float pX, pY;
  private color skin;
  private int type;//1-food, 2-poison, 3-fast
  private int size;

  Pellet() {
    pX=random(600);
    pY=random(600);
    skin=color(0, 255, 0);
    type=0;
    size=5;
  }

  Pellet(int t) {
    pX=random(600);
    pY=random(200);
    type=t;
    if (type==1) skin=color(0, 255, 0);
    else if (type==2) skin=color(255, 0, 0);
    else if (type==3) skin=color(255, 255, 0);
    size=5;
  }

  public void show() {
    stroke(skin);
    fill(skin);
    ellipse(pX, pY, size, size);
  }

  public void move() {
    if (pY<600-size/2)
      pY+=0.08;
  }

  public void update() {
    show();
    move();
  }

  public boolean hasCollision(Tankable t) {
    return false;
    //    if (sqrt(sq(pX-t.X)+sq(t.pY-fishY))<(weight/2+t.size/2)) return true;
    //    else return false;
  }

  public boolean stillKickin() {
    return true;
  }

  public void bump() {
    int count=0;
    if (count<10) {//tap the tank
      count++;
      translate(random(-20, 20), random(-10, 10));
    }
  }

  public float getX() {
    return pX;
  }
  public float getY() {
    return pY;
  }
  public float getRadius() {
    return size/2;
  }
}

