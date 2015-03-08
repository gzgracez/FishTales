class Pellet implements Tankable {

  private float pX, pY;
  private color skin;
  private int type;//1-food, 2-poison, 3-fast
  private int size;
  private FishTank tank=theTank;

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
  
  Pellet(int t, FishTank t2) {
    tank=t2;
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
    if (pY<600-size/2) pY+=0.08;
  }

  public void update() {
    show();
    move();
  }

  public boolean hasCollision(Tankable p) {
    //return false;
    if (sqrt(sq(pX-p.getX())+sq(pY-p.getY()))<(getRadius()+p.getRadius())) {
      return true;
    } 
    else return false;
  }

  public boolean stillKickin() {
    if (pY>=600-size/2) return false;
    else return true;
  }

  public void bump() {
    
  }

  public float getX() {
    return pX;
  }
  public float getY() {
    return pY;
  }
  public float getRadius() {
    return (float)size/2.0;
  }
}

