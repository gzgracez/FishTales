class Pellet implements Tankable {

  float pX, pY;
  color skin;
  int type;//1-food, 2-poison, 3-fast
  int size;

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

  void show() {
    stroke(skin);
    fill(skin);
    ellipse(pX, pY, size, size);
  }

  void move() {
    if (pY<600-size/2)
      pY+=0.08;
  }

  void update() {
    show();
    move();
  }

  boolean hasCollision(Tankable t) {
    return false;
    //    if (sqrt(sq(pX-t.X)+sq(t.pY-fishY))<(weight/2+t.size/2)) return true;
    //    else return false;
  }

  boolean stillKickin() {
    return true;
  }

  void bump() {
    translate(random(-20, 20), random(-10, 10));
  }
}

