class Whale extends Fish {
  Whale() {
    super();//calls the Fish() constructor to initialize all the common data
    maxAge=30000;
    maxWeight=100;
    fishX=random(50, 550);
    fishY=random(50, 550);
    speedX=random(-1, 1);
    if (speedX==0) speedX=random(-1, 1);
    speedY=sqrt(1-sq(speedX));
    skin=color(random(10, 255));
    weight=random (14, 20);
    type="Whale";
  }

  public boolean tryToEat(Tankable p) {
    if (p instanceof Pellet) {
      Pellet p1=(Pellet)p;
      if (p1.type==1) changeWeight(5);
      else if (p1.type==2) changeWeight(-10);
      else if (p1.type==3) slow();
      return true;
    } else return false;
  }

  public void move() {
    if (isDead==false) {//alive
      age++;
      ammonia+=0.001;
      if (fishX<=weight/2) {//bounce
        speedY=random(-1, 1);
        speedX=sqrt(1-sq(speedY));
      } else if (fishX>=600-weight/2) {
        speedY=random(-1, 1);
        speedX=-sqrt(1-sq(speedY));
      }
      if (fishY<=weight/2) {
        speedX=random(-1, 1);
        speedY=sqrt(1-sq(speedY));
      } else if (fishY>=600-weight/2) {
        speedX=random(-1, 1);
        speedY=-sqrt(1-sq(speedY));
      }
      fishX+=speedX; 
      fishY+=speedY;
      if (age%900==0) weight+=2;//weight increase by age
      if (age==900*maxAge) {
        isDead=true;
        death="Death due to old age";
      }
      if (weight>=maxWeight) {
        death="Death due to obesity";
        isDead=true;
      }
      if (weight<=0.1*maxWeight) { 
        death="Death due to emaciation";
        isDead=true;
      }
    }//alive
    else {//dead
      if (fishY>0) {//float to the top after death
        speedX=0;
        speedY=-1;
        fishX+=speedX; 
        fishY+=speedY;
      } else {//stop at the top
        speedX=0;
        speedY=0;
      }
    }//dead
  }//move()
}

