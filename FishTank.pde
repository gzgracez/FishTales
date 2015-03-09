class FishTank {

  private ArrayList <Tankable> items=new ArrayList<Tankable>();
  private float ammoniaLevel;
  private float tWidth, tHeight;
  private String name;
  private boolean tapped;
  private int tapCount;
  private int deltaX=650;

  FishTank(String name, float w, float h) {
    this.name=name;
    this.tWidth=w;
    this.tHeight=h;
    this.ammoniaLevel=0;
  }

  public void updateAll() {//show & move
    if (ammoniaLevel<=31) background(ammoniaLevel, 150-ammoniaLevel, 255-ammoniaLevel);//background
    else if (ammoniaLevel>31 && ammoniaLevel<=127) background(ammoniaLevel, 119, 255-ammoniaLevel);
    else if (ammoniaLevel>127 && ammoniaLevel<=198) background(127, 119, 255-ammoniaLevel);
    else background(127, 119, 57);
    if (deltaX<650) { 
      imageMode(CENTER);
      image(net, deltaX, 0, 200, 200);
      cleanTheTank();
    }
    ammoniaLevel=0;
    shakeTank();//tapTheTank
    for (int t=0; t<items.size (); t++) {
      items.get(t).update();
      if (items.get(t) instanceof Fish) {
        Fish tFish=(Fish)items.get(t);
        ammoniaLevel+=tFish.getFishAmmonia();
        if (ammoniaLevel>300) {
          if ((int)random(tFish.getAge()-ammoniaLevel)==(int)random(tFish.getAge()-ammoniaLevel)) { 
            tFish.setIsDead(true);
            tFish.setDeath("Death due to un-clean tank");
          }
        }//check for too much ammonia
        if (tFish.getAge()%600==(int)random(50*(tFish.getAge()/600), 900) && tFish.stillKickin()) {//original point of bubble
          items.add(new Bubbles(tFish.getX(), tFish.getY(), (tFish.getRadius()*2)/3));
        }
      }//if istanceof Fish
    }
    resetMatrix();
    for (int a=0; a<items.size (); a++) {
      Tankable t1=items.get(a);
      if (t1.stillKickin()) {
        for (int b=0; b<items.size (); b++) {
          Tankable t2=items.get(b);
          if (t1!=t2) {
            if (t1.hasCollision(t2)) {
              if (t1 instanceof Fish) {
                if (((Fish)t1).tryToEat(t2)) {
                  items.remove(t2);
                  b--;
                }
              }//end - t1 instanceof fish  
              else if (t1 instanceof Pellet && t2 instanceof Pellet) {
                t1.bump();
                t2.bump();
              }
            }//end collision has happened
            if (t1 instanceof Fish && !(t1 instanceof Whale) && t2 instanceof Pellet && (((Pellet)t2).getType()==1 || ((Pellet)t2).getType()==2)) {
              if (((Fish)t1).closeFood((Pellet)t2)) {
                Pellet p = (Pellet)t2;
                Fish tFish=(Fish)t1;
                if (tFish instanceof Goldfish) {
                  tFish.speedX=3*(p.pX-tFish.getX())/sqrt(sq(p.getX()-tFish.getX())+sq(p.getY()-tFish.getY()));
                  tFish.speedY=3*(p.pY-tFish.fishY)/sqrt(sq(p.getX()-tFish.getX())+sq(p.getY()-tFish.getY()));
                } 
                else if (tFish instanceof Whale) {
                  tFish.speedX=(p.pX-tFish.getX())/sqrt(sq(p.getX()-tFish.getX())+sq(p.getY()-tFish.getY()));
                  tFish.speedY=(p.pY-tFish.fishY)/sqrt(sq(p.getX()-tFish.getX())+sq(p.getY()-tFish.getY()));
                } 
                else if (tFish instanceof Piranha) {
                  tFish.speedX=(p.pX-tFish.getX())/sqrt(sq(p.getX()-tFish.getX())+sq(p.getY()-tFish.getY()));
                  tFish.speedY=(p.pY-tFish.fishY)/sqrt(sq(p.getX()-tFish.getX())+sq(p.getY()-tFish.getY()));
                }
              }
            }
          }
        }
      }
    }
    if (clicked==true && theTank.contains(fishClick)) text("Name: " + fishClick.getName() + "\nSpecies: " + fishClick.getType() + "\nGender: " + fishClick.getGender() + "\nAge: " + fishClick.getAge()/900 + "\nWeight: " + nf(fishClick.getRadius()*2, 0, 1) + "\n" + fishClick.getDeath(), 700, 300);
  }

  public void showAll() {//show
    if (ammoniaLevel<=31) background(ammoniaLevel, 150-ammoniaLevel, 255-ammoniaLevel);//background
    else if (ammoniaLevel>31 && ammoniaLevel<=127) background(ammoniaLevel, 119, 255-ammoniaLevel);
    else if (ammoniaLevel>127 && ammoniaLevel<=198) background(127, 119, 255-ammoniaLevel);
    else background(127, 119, 57);
    shakeTank();
    for (Tankable t : items) {
      t.show();
    }
    resetMatrix();
  }

  public void tapTheTank() {
    tapped=true;
    tapCount=0;
    if (mouseX>0 && mouseX<tWidth && mouseY>0 && mouseY<tHeight)
    {
      Random generator;
      generator=new Random();
      for (int i=0; i<random (6, 10); i++) {
        float tempX=constrain((float)(mouseX+30*generator.nextGaussian()), 0, tWidth);
        float tempY=constrain((float)(mouseY+30*generator.nextGaussian()), 0, tHeight);
        items.add(new Bubbles(tempX, tempY, 10));
      }
    }
  }

  public float getAmmoniaLevel() { 
    return ammoniaLevel;
  }

  public int waterLevel() {
    return 1;
  }

  public void cleanTheTank() {
    ammoniaLevel=0;
    deltaX+=5;
    for (int i=0; i<items.size (); i++) {
      if (items.get(i) instanceof Fish) {
        Fish fish=(Fish)items.get(i);
        fish.setFishAmmonia(0);
        if (fish.isDead==true && fish.getY()>=-fish.getRadius() && fish.getY()<=100-fish.getRadius() && fish.getX()<=deltaX && fish.getX()>=deltaX-50) {
          items.remove(i);
          i--;
        }
      } 
      else {
        Tankable thing=items.get(i);
        if (thing.getY()>=-thing.getRadius() && thing.getY()<=100-thing.getRadius() && thing.getX()<=deltaX && thing.getX()>=deltaX-50) {
          items.remove(i);
          i--;
        }
        if (!thing.stillKickin()) { 
          items.remove(i);
          i--;
        }
      }
    }
  }

  public int size() {
    return items.size();
  }

  public void reset() {
    for (int i=items.size ()-1; i>=0; i--) {
      items.remove(i);
    }
  }

  public boolean add(Tankable t) {
    return items.add(t);
  }
  public boolean remove(Tankable t) {
    return items.remove(t);
  }
  public boolean contains(Tankable t) {
    if (items.contains(t)) return true;
    else return false;
  }
  public Tankable get(int index) {
    return items.get(index);
  }
  public Fish getFish(int index) {
    if (items.get(index) instanceof Fish) return (Fish)items.get(index);
    else return null;
  }
  public Goldfish getLiveGoldfish() {
    ArrayList <Goldfish> goldfish=new ArrayList<Goldfish>();
    for (Tankable g : items) {
      if (g instanceof Goldfish) {
        goldfish.add((Goldfish)g);
      }
    }
    if (goldfish.size()!=0) {
      int tempIndex=(int)random(0, goldfish.size());
      return goldfish.get(tempIndex);
    } 
    else {
      return null;
    }
  }

  public Goldfish getClosestGoldfish(Piranha p) {
    if (items.size()>0) {
      Tankable close=items.get(0);
      int count=0;
      for (Tankable g : items) {
        if (g instanceof Goldfish) {
          close=(Goldfish)g;
          count++;
        }
      }
      if (count==0) return null;
      else {
        for (Tankable g : items) {
          if (g instanceof Goldfish) {
            if (sqrt(sq(p.getX()-g.getX())+sq(p.getY()-g.getY()))<sqrt(sq(close.getX()-g.getX())+sq(close.getY()-g.getY()))) close=(Goldfish)g;
          }
        }
      }
      return (Goldfish)close;
    } 
    else return null;
  }

  public void shakeTank() {//translating for tapTheTank
    if (tapCount>=11) tapped=false;
    if (tapped && tapCount<11) {
      for (Tankable t : items) {
        if (t instanceof Fish) {
          t.bump();
          if (tapCount==10) {
            //(Fish)t.changeSpeeds(-1*(Fish)t.getSpeedX,-1*(Fish)t.getSpeedY);
          }
        }
      }
      tapCount++;
      translate(random(-20, 20), random(-10, 10));
    }
  }
}

