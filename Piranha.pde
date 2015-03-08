class Piranha extends Fish {
  Goldfish follow;
  Piranha() {
    super();//calls the Fish() constructor to initialize all the common data
    maxAge=10000;
    maxWeight=50;
    fishX=random(50, 550);
    fishY=random(50, 550);
    speedX=random(-2, 2);
    if (speedX==0) speedX=random(-2, 2);
    speedY=sqrt(4-sq(speedX))*pow(-1, (int)random(1, 5));
    skin=color(random(224), random(255), random(112, 255));
    weight=random(10, 15);
    type="Piranha";
    follow=tank.getClosestGoldfish(this);
    //    if (tank.getClosestGoldfish(this)!=null) {
    //      follow=tank.getClosestGoldfish(this);
    //    }
  }
  Piranha(FishTank t) {
    super();//calls the Fish() constructor to initialize all the common data
    tank=t;
    maxAge=10000;
    maxWeight=50;
    fishX=random(50, 550);
    fishY=random(50, 550);
    speedX=random(-2, 2);
    if (speedX==0) speedX=random(-2, 2);
    speedY=sqrt(4-sq(speedX))*pow(-1, (int)random(1, 5));
    skin=color(random(224), random(255), random(112, 255));
    weight=random(10, 15);
    type="Piranha";
    follow=tank.getClosestGoldfish(this);
  }

  public boolean tryToEat(Tankable p) {
    if (p instanceof Pellet) {
      Pellet p1=(Pellet)p;
      if (p1.type==1) changeWeight(5);
      else if (p1.type==2) changeWeight(-10);
      else if (p1.type==3) slow();
      return true;
    } else if (p instanceof Piranha) {
      Fish pFish=(Fish)p;
      if (this.weight>=pFish.weight) {
        this.changeWeight(pFish.getRadius());
        return true;
      } else if (this.weight==pFish.weight) {
        if (!this.isDead && p.stillKickin()) {
          if ((this.gender=="Female" && pFish.getGender()=="Male") || (this.gender=="Female" && pFish.getGender()=="Male")) {
            float ranNum=random(0, 1);
            if (ranNum<0.8) {
              this.bounce(p);
            } else { 
              if (this.breed==false || pFish.breed==false) {
                println("BREED");
                println(theTank.size());
                tank.add(new Piranha());
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
      } else {
        return false;
      }
    } else if (p instanceof Goldfish) {
      Fish pFish=(Fish)p;
      this.changeWeight(pFish.getRadius());
      return true;
    } else return false;
  }

  public void bounce(Tankable t) {
    Fish tFish=(Fish)t;
    if (this.fishX<tFish.fishX) {
      this.speedX=-1*random(1, 3);
      float tempSpeedX=random(1, 3);
      if (this.fishY<tFish.fishY) {
        this.speedY=-1*random(1, 3);
        float tempSpeedY=random(1, 3);
        tFish.changeSpeeds(tempSpeedX, tempSpeedY);
      } else {
        this.speedY=random(1, 3);
        float tempSpeedY=-1*random(1, 3);
        tFish.changeSpeeds(tempSpeedX, tempSpeedY);
      }
    } else {
      this.speedX=random(1, 3);
      float tempSpeedX=-1*random(1, 3);
      if (this.fishY<tFish.fishY) {
        this.speedY=-1*random(1, 3);
        float tempSpeedY=random(1, 3);
        tFish.changeSpeeds(tempSpeedX, tempSpeedY);
      } else {
        this.speedY=random(1, 3);
        float tempSpeedY=-1*random(1, 3);
        tFish.changeSpeeds(tempSpeedX, tempSpeedY);
      }
    }
  }

  public void move() {
    if (isDead==false) {//alive
      age++;
      ammonia+=0.001;
      if (follow!=null) {
        if (this.hasCollision((Tankable)follow)) {
          follow=tank.getClosestGoldfish(this);
        }
      }
      if (follow==null) {
        follow=tank.getClosestGoldfish(this);
        if (fishX<=weight/2) {//bounce
          speedY=random(-2, 2);
          speedX=sqrt(4-sq(speedY));
        } else if (fishX>=600-weight/2) {
          speedY=random(-2, 2);
          speedX=-sqrt(4-sq(speedY));
        }
        if (fishY<=weight/2) {
          speedX=random(-2, 2);
          speedY=sqrt(4-sq(speedY));
        } else if (fishY>=600-weight/2) { 
          speedX=random(-2, 2);
          speedY=-sqrt(4-sq(speedY));
        }
      } else {
        float xDiff=follow.getX()-this.fishX;
        float yDiff=follow.getY()-this.fishY;
        float scale=2/sqrt(sq(xDiff)+sq(yDiff));
        speedX=xDiff*scale;
        speedY=yDiff*scale;
        if (fishX<=weight/2) {//bounce
          speedY=random(-2, 2);
          speedX=sqrt(4-sq(speedY));
        } else if (fishX>=600-weight/2) {
          speedY=random(-2, 2);
          speedX=-sqrt(4-sq(speedY));
        }
        if (fishY<=weight/2) {
          speedX=random(-2, 2);
          speedY=sqrt(4-sq(speedY));
        } else if (fishY>=600-weight/2) { 
          speedX=random(-2, 2);
          speedY=-sqrt(4-sq(speedY));
        }
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

