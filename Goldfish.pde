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
    } 
    else if (p instanceof Goldfish && !(p instanceof Toroidalfin)) {
      if (!this.isDead && p.stillKickin()) {
        Goldfish pFish=(Goldfish)p;
        if ((this.gender=="Female" && pFish.getGender()=="Male") || (this.gender=="Female" && pFish.getGender()=="Male")) {
          float ranNum=random(0, 1);
          if (ranNum<0.8) {
            this.bounce(p);
          } 
          else { 
            if (this.breed==false || pFish.breed==false) {
              println("BREED");
              println(theTank.size());
              tank.add(new Goldfish());
              this.breed=true;
              pFish.breed=true;
            } 
            else {
              this.bounce(p);
            }
          }
        } //end can breed
        else {
          this.bounce(p);
        } //end can't breed
      }//both alive
      return false;
    } 
    else return false;
  }

  public void bounce(Tankable t) {
    Fish tFish=(Fish)t;
    if (this.fishX<tFish.fishX) {
      this.speedX=-1*random(1, 3);
      float tempSpeedX=random(1, 3);
      if (this.fishY<tFish.fishY) {
        this.speedY=-1*sqrt(9-sq(this.speedX));
        float tempSpeedY=sqrt(9-sq(tempSpeedX));
        tFish.changeSpeeds(tempSpeedX, tempSpeedY);
      }
      else {
        this.speedY=sqrt(9-sq(this.speedX));
        float tempSpeedY=-1*sqrt(9-sq(tempSpeedX));
        tFish.changeSpeeds(tempSpeedX, tempSpeedY);
      }
    }
    else {
      this.speedX=random(1, 3);
      float tempSpeedX=-1*random(1, 3);
      if (this.fishY<tFish.fishY) {
        this.speedY=-1*sqrt(9-sq(this.speedX));
        float tempSpeedY=sqrt(9-sq(tempSpeedX));
        tFish.changeSpeeds(tempSpeedX, tempSpeedY);
      }
      else {
        this.speedY=sqrt(9-sq(this.speedX));
        float tempSpeedY=-1*sqrt(9-sq(tempSpeedX));
        tFish.changeSpeeds(tempSpeedX, tempSpeedY);
      }
    }
  }

  public void move() {
    if (isDead==false) {//alive
      age++;
      ammonia+=0.001;
      if (fishX<=weight/2) {//bounce
        speedY=random(-3, 3);
        speedX=sqrt(9-sq(speedY));
      } 
      else if (fishX>=600-weight/2) { 
        speedY=random(-3, 3);
        speedX=-sqrt(9-sq(speedY));
      }
      if (fishY<=weight/2) {
        speedX=random(-3, 3);
        speedY=sqrt(9-sq(speedX));
      } 
      else if (fishY>=600-weight/2) {
        speedX=random(-3, 3);
        speedY=-sqrt(9-sq(speedX));
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
      } 
      else {//stop at the top
        speedX=0;
        speedY=0;
      }
    }//dead
  }//move()
}

