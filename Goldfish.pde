class Goldfish extends Fish {
  Goldfish() {
    super();//calls the Fish() constructor to initialize all the common data
    maxAge=20000;
    maxWeight=30;
    fishX=random(50, 550);
    fishY=random(50, 550);
    speedX=random(-3, 3);
    if (speedX==0) speedX=random(-3, 3);
    speedY=sqrt(9-sq(speedX))*pow(-1, (int)random(1, 5));
    skin=color(random(233, 255), random(165), random(128));
    weight=random(6, 10);
    type="Goldfish";
  }
  Goldfish(FishTank t) {
    super();//calls the Fish() constructor to initialize all the common data
    tank=t;
    maxAge=20000;
    maxWeight=30;
    fishX=random(50, 550);
    fishY=random(50, 550);
    speedX=random(-3, 3);
    if (speedX==0) speedX=random(-3, 3);
    speedY=sqrt(9-sq(speedX))*pow(-1, (int)random(1, 5));
    skin=color(random(233, 255), random(165), random(128));
    weight=random(6, 10);
    type="Goldfish";
  }

  public boolean tryToEat(Tankable p) {
    if (p instanceof Pellet) {
      Pellet p1=(Pellet)p;
      if (p1.type==1) changeWeight(5);
      else if (p1.type==2) changeWeight(-10);
      else if (p1.type==3) slow();
      return true;
    } else if (p instanceof Goldfish) {
      if (!this.isDead && p.stillKickin()) {
        Goldfish pFish=(Goldfish)p;
        if ((this.gender=="Female" && pFish.getGender()=="Male") || (this.gender=="Female" && pFish.getGender()=="Male")) {
          float ranNum=random(0, 1);
          if (ranNum<0.8) {
            this.bounce(p);
          } else { 
            tank.add(new Goldfish());
          }
        } //end can breed
        else {
          this.bounce(p);
        } //end can't breed
      }
      return false;
    } else return false;
  }
  
  public void bounce(Tankable t) {
    Fish tFish=(Fish)t;
    this.speedX=random(-3, 3);
    if (this.speedX==0) this.speedX=random(-3, 3);
    this.speedY=sqrt(9-sq(this.speedX))*pow(-1, (int)random(1, 5));
    tFish.changeSpeeds(-1*this.speedX, -1*this.speedY);
  }

  public void move() {
    if (isDead==false) {//alive
      age++;
      ammonia+=0.001;
      if (fishX<=weight/2) {//bounce
        speedY=random(-3, 3);
        speedX=sqrt(9-sq(speedY));
      } else if (fishX>=600-weight/2) { 
        speedY=random(-3, 3);
        speedX=-sqrt(9-sq(speedY));
      }
      if (fishY<=weight/2) {
        speedX=random(-3, 3);
        speedY=sqrt(9-sq(speedY));
      } else if (fishY>=600-weight/2) {
        speedX=random(-3, 3);
        speedY=-sqrt(9-sq(speedY));
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

