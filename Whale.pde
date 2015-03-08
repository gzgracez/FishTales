class Whale extends Fish {
  Whale() {
    super();//calls the Fish() constructor to initialize all the common data
    maxAge=30000;
    maxWeight=100;
    fishX=random(50, 550);
    fishY=random(50, 550);
    speedX=pow(-1, (int)random(1, 5))*random(0.5, 1.2);
    speedY = 0;
    skin=color(random(10, 255));
    weight=random (14, 20);
    type="Whale";
  }
  Whale(FishTank t) {
    super();//calls the Fish() constructor to initialize all the common data
    tank=t;
    maxAge=30000;
    maxWeight=100;
    fishX=random(51, 549);
    fishY=random(51, 549);
    speedX=pow(-1, (int)random(1, 5))*random(0.5, 1.2);
    speedY=0;
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
    } else if (p instanceof Whale) {
      if (!this.isDead && p.stillKickin()) {
        Whale pFish=(Whale)p;
        if ((this.gender=="Female" && pFish.getGender()=="Male") || (this.gender=="Female" && pFish.getGender()=="Male")) {
          float ranNum=random(0, 1);
          if (ranNum<0.8) {
            this.bounce(p);
          } else { 
            if (this.breed==false || pFish.breed==false) {
              println("BREED");
              println(theTank.size());
              tank.add(new Whale());
              this.breed=true;
              pFish.breed=true;
            } else {
              this.bounce(p);
            }
          }
        } //end can breed
        else {
          this.bounce(p);
        } //end can't breed
      }
      return false;
    }//collide with whale
    else if (!(p instanceof Bubbles)) {
      Fish pFish=(Fish)p;
      this.changeWeight(pFish.getRadius());
      return true;
    } else {
      return false;
    }
  }

  public void bounce(Tankable t) {
    Fish tFish=(Fish)t;
    if (this.fishX<tFish.fishX) {
      this.speedX=-1*random(1, 1.4);
      tFish.changeSpeeds(-1*this.speedX, 0);
    } else {
      this.speedX=random(1, 1.4);
      tFish.changeSpeeds(-1*this.speedX, 0);
    }
  }

  public void move() {
    if (isDead==false) {//alive
      age++;
      ammonia+=0.001;
      if (fishX<=weight/2) {//bounce
        speedX=random(0.8, 1.2);
      } else if (fishX>=600-weight/2) {
        speedX=-1*random(0.8, 1.2);
      }
      if (fishY<=weight/2) {
        speedX=pow(-1, (int)random(1, 5));
      } else if (fishY>=600-weight/2) {
        speedX=pow(-1, (int)random(1, 5));
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

