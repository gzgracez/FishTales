class Fish {
  String names[]=loadStrings("names.txt");
  String name;
  float speedX, speedY;
  float fishX, fishY;
  float weight, maxWeight;
  int skin;
  int age=0, maxAge;
  boolean isDead=false;
  float ammonia=0;
  String type;
  String death="Alive";
  String gender;
  boolean breed=false;

  Fish() {
    int n=(int)random(names.length);
    name=names[n];
    if (n<=999) gender="Male";
    else gender="Female";
  }

  Fish(String n, float sX, float sY, float x, float y, float z, int c) {
    name=n;
    speedX=sX;
    speedY=sY;
    fishX=x;
    fishY=y;
    weight=z;
    skin=c;
    maxWeight=50;
  }

  Fish(String n, float s, float z, int c) {
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

  void show() {
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

  void move() {
    if (isDead==false) {//alive
      age++;
      ammonia+=0.001;
      if (fishX<=weight/2) {//bounce
        if (this instanceof Goldfish) {
          speedY=random(-3, 3);
          speedX=sqrt(9-sq(speedY));
        }
        else if (this instanceof Whale) {
          speedY=random(-1, 1);
          speedX=sqrt(1-sq(speedY));
        }
        else if (this instanceof Piranha) {
          speedY=random(-2, 2);
          speedX=sqrt(4-sq(speedY));
        }
      }
      else if (fishX>=600-weight/2) {
        if (this instanceof Goldfish) { 
          speedY=random(-3, 3);
          speedX=-sqrt(9-sq(speedY));
        }
        else if (this instanceof Whale) { 
          speedY=random(-1, 1);
          speedX=-sqrt(1-sq(speedY));
        }
        else if (this instanceof Piranha) { 
          speedY=random(-2, 2);
          speedX=-sqrt(4-sq(speedY));
        }
      }
      if (fishY<=weight/2) {
        if (this instanceof Goldfish) {
          speedX=random(-3, 3);
          speedY=sqrt(9-sq(speedY));
        }
        else if (this instanceof Whale) {
          speedX=random(-1, 1);
          speedY=sqrt(1-sq(speedY));
        }
        else if (this instanceof Piranha) {
          speedX=random(-2, 2);
          speedY=sqrt(4-sq(speedY));
        }
      }
      else if (fishY>=600-weight/2) {
        if (this instanceof Goldfish) {
          speedX=random(-3, 3);
          speedY=-sqrt(9-sq(speedY));
        }
        else if (this instanceof Whale) { 
          speedX=random(-1, 1);
          speedY=-sqrt(1-sq(speedY));
        }
        else if (this instanceof Piranha) { 
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
      }
      else {//stop at the top
        speedX=0;
        speedY=0;
      }
    }//dead
  }//move()

  void changeWeight(float d) {
    if (weight+d<=maxWeight && weight+d>.1*maxWeight) weight+=d;
    else if (weight+d>maxWeight) { 
      death="Death due to obesity";
      isDead=true;
    }
    else if (weight+d<=.1*maxWeight) { 
      death="Death due to emaciation";
      isDead=true;
    }
  }

  void slow() {
    speedX*=0.8;
    speedY*=0.8;
  }

  boolean hasCollision(Pellet p) {//fish collides with pellet
    if (sqrt(sq(p.pX-fishX)+sq(p.pY-fishY))<(weight/2+p.size/2)) return true;
    else return false;
  }//hasCollision

  boolean closeFood(Pellet p) {//fish is close to the food
    if (sqrt(sq(p.pX-fishX)+sq(p.pY-fishY))<=5+(weight/2+p.size/2)) return true;
    else return false;
  }//closeFood

  boolean hasCollision(Fish f) {//fish collides with fish
    if (sqrt(sq(f.fishX-this.fishX)+sq(f.fishY-this.fishY))<(this.weight/2+f.weight/2)) return true;
    else return false;
  }//hasCollision
}

