abstract class Fish implements Tankable {
  protected String names[]=loadStrings("names.txt");
  protected String name;
  protected float speedX, speedY;
  protected float fishX, fishY;
  protected float weight, maxWeight;
  protected int skin;
  protected int age=0, maxAge;
  protected boolean isDead=false;
  protected float ammonia=0;
  protected String type;
  protected String death="Alive";
  protected String gender;
  protected boolean breed=false;
  protected FishTank tank=theTank;

  Fish() {
    int n=(int)random(names.length);
    name=names[n];
    if (n<=999) gender="Male";
    else gender="Female";
  }

  Fish(FishTank t, String n, float sX, float sY, float x, float y, float z, int c) {
    tank=t;
    name=n;
    speedX=sX;
    speedY=sY;
    fishX=x;
    fishY=y;
    weight=z;
    skin=c;
    maxWeight=50;
  }

  Fish(FishTank t, String n, float s, float z, int c) {
    tank=t;
    name=n;
    speedX=s; 
    speedY=s;
    fishX=random(600);
    fishY=random(600);
    weight=z;
    skin=c;
    maxWeight=50;
  }

  Fish(int c) {
    name=names[(int)random(names.length)];
    speedX=random(-3, 3);
    if (speedX==0) speedX=random(-3, 3);
    speedY=random(-3, 3);
    if (speedY==0) speedY=random(-3, 3);
    fishX=random(50, 550);
    fishY=random(50, 550);
    weight=random(10, 20);
    skin=c;
    maxWeight=50;
  }

  public float getX() {
    return fishX;
  }
  public float getY() {
    return fishY;
  }
  public String getGender() {
    return gender;
  }
  public float getRadius() { 
    return (float)(weight)/2.0;
  }
  public float getFishAmmonia(){
    return ammonia;
  }
  public void changeSpeeds(float x, float y) {
    speedX=x;
    speedY=y;
  }
  public void setFishPos(float x, float y) {
    fishX=x;
    fishY=y;
  }
  public boolean stillKickin() {
    return !isDead;
  }

  public boolean hasCollision(Tankable t) {
    if (sqrt(sq(t.getX()-fishX)+sq(t.getY()-fishY))<this.getRadius()+t.getRadius()) {
      return true;
    } else return false;
  }

  public void bump() {
    speedX*=-1;
    speedY*=-1;
    if ((int)age/50==(int)random((age-50)/50, (maxAge+1)/50)) { 
      isDead=true;
      death="Death due to over-tapping \nof tank";
    }
  }
  public void update() {
    show();
    move();
  }

  public void show() {
    fill(0);
    textAlign(CENTER);
    text(name, fishX, fishY-weight);
    if (isDead==false) {//alive
      noStroke();
      fill(skin);
      if (age%60<=15)//tail
        triangle(fishX, fishY, fishX-(weight/2/sqrt(speedX*speedX+speedY*speedY))*(2*speedX+speedY), fishY-(weight/2/sqrt(speedX*speedX+speedY*speedY))*(2*speedY-speedX), fishX-(weight/2/sqrt(speedX*speedX+speedY*speedY))*(2*speedX-speedY), fishY-(weight/2/sqrt(speedX*speedX+speedY*speedY))*(2*speedY+speedX));
      else
        triangle(fishX, fishY, fishX-(weight/2/sqrt(speedX*speedX+speedY*speedY))*(2*speedX+speedY/2), fishY-(weight/2/sqrt(speedX*speedX+speedY*speedY))*(2*speedY-speedX/2), fishX-(weight/2/sqrt(speedX*speedX+speedY*speedY))*(2*speedX-speedY/2), fishY-(weight/2/sqrt(speedX*speedX+speedY*speedY))*(2*speedY+speedX/2));
      fill(skin);//body
      ellipse(fishX, fishY, weight, weight);
      fill(255);//eye
      ellipse(fishX+((2*weight/5)/sqrt(speedX*speedX+speedY*speedY))*speedX-((1*weight/10)/sqrt(speedX*speedX+speedY*speedY))*(2*speedX-speedY), fishY+((2*weight/5)/sqrt(speedX*speedX+speedY*speedY))*speedY-((1*weight/10)/sqrt(speedX*speedX+speedY*speedY))*(2*speedY+speedX), 2*weight/5, 2*weight/5);
      fill(0);//pupil
      ellipse(fishX+((weight/2)/sqrt(speedX*speedX+speedY*speedY))*speedX-((1*weight/10)/sqrt(speedX*speedX+speedY*speedY))*(2*speedX-speedY), fishY+((weight/2)/sqrt(speedX*speedX+speedY*speedY))*speedY-((1*weight/10)/sqrt(speedX*speedX+speedY*speedY))*(2*speedY+speedX), 1*weight/5, 1*weight/5);
    }//alive
    else {//dead
      noStroke();
      fill(skin);//tail
      triangle(fishX, fishY, fishX+weight, fishY+weight/2, fishX+weight, fishY-weight/2);
      fill(skin);//body
      ellipse(fishX, fishY, weight, weight);
      stroke(0);//eye
      line((fishX-2*weight/5)-weight/5, fishY-3*weight/10, (fishX-2*weight/5)+weight/5, fishY+weight/10);
      line((fishX-2*weight/5)-weight/5, fishY+weight/10, (fishX-2*weight/5)+weight/5, fishY-3*weight/10);
    }//dead
  }
  abstract void move();
  abstract boolean tryToEat(Tankable a);
  abstract void bounce(Tankable t);

  public void changeWeight(float d) {
    if (weight+d<=maxWeight && weight+d>.1*maxWeight) weight+=d;
    else if (weight+d>maxWeight) { 
      death="Death due to obesity";
      isDead=true;
    } else if (weight+d<=.1*maxWeight) { 
      death="Death due to emaciation";
      isDead=true;
    }
  }

  public void slow() {
    speedX*=0.8;
    speedY*=0.8;
  }

  public boolean hasCollision(Pellet p) {//fish collides with pellet
    if (sqrt(sq(p.pX-fishX)+sq(p.pY-fishY))<(weight/2+p.size/2)) return true;
    else return false;
  }//hasCollision

  public boolean closeFood(Pellet p) {//fish is close to the food
    if (sqrt(sq(p.pX-fishX)+sq(p.pY-fishY))<=5+(weight/2+p.size/2)) return true;
    else return false;
  }//closeFood

  public boolean hasCollision(Fish f) {//fish collides with fish
    if (sqrt(sq(f.fishX-this.fishX)+sq(f.fishY-this.fishY))<(this.weight/2+f.weight/2)) return true;
    else return false;
  }//hasCollision
}

