/*
 Program: Fish Tank 2.0
 Author: Grace Zhang
 Date: 2/22/15
 Notes:
 Tail that grows and flaps along with the fish & follows the direction of movement
 Bubbles come out of fish, then float to the top of the tank (They also move left & right)
 The closer a Fish is to maxAge, the more likely that "Tapping the Tank" will kill it
 "Clean the Tank" (net to get rid of dead fish)-fish movement produces ammonia; if not cleaned, fish start gradually dying after a set amount of time
 Circular buttons
 Gender attribute added to the Fish class; when a male & female of the same breed meet, there is a 20% change that a new fish of that breed is born
 Fish follow food & poison
 "Slowness" pellets
 Pellets fall
 Click on fish for more info (Name, Species, Gender, Age, Weight, Alive/Death & How)
 Drag the fish
 Keyboard (corresponding keys are written on the button; space bar to pause)
 Reset button to completely reset the screen
 Tap the tank shakes the tank (in addition to making the fish go in opposite directions)
 The fish only eat each other if the predator's size is greater than or equal to that of the prey
 */

ArrayList <Fish> fishTank = new ArrayList <Fish>();
ArrayList <Bubbles> bubbles = new ArrayList <Bubbles>();
ArrayList <Pellet> pelletList = new ArrayList <Pellet>();
FishTank theTank;
float ammonia=0;
boolean clicked=false;
Fish fishClick;
boolean frame=false;
String dead="alive";
PImage net;
boolean clean=false;
int deltaX=0;

void setup() {
  size(800, 600);
  background (0, 150, 255);
  net=loadImage("net2.png");
  theTank=new FishTank("theTank", width-100, height);
}

void draw() {
  if (frame==false) {
    ammonia=0;
    for (int i=0; i<fishTank.size (); i++) {//ammonia & random bubbles & random change in direction
      ammonia+=fishTank.get(i).ammonia;
      if (fishTank.get(i).age%600==(int)random(50*(fishTank.get(i).age/600), 900) && fishTank.get(i).isDead==false) {//original point of bubble
        bubbles.add(new Bubbles(fishTank.get(i).fishX, fishTank.get(i).fishY, fishTank.get(i).weight/3));
        if (fishTank.get(i) instanceof Goldfish) {
          fishTank.get(i).speedX=random(-3, 3);
          fishTank.get(i).speedY=sqrt(9-sq(fishTank.get(i).speedX));
        } else if (fishTank.get(i) instanceof Whale) {
          fishTank.get(i).speedX=random(-1, 1);
          fishTank.get(i).speedY=sqrt(1-sq(fishTank.get(i).speedX));
        } else if (fishTank.get(i) instanceof Piranha) {
          fishTank.get(i).speedX=random(-2, 2);
          fishTank.get(i).speedY=sqrt(4-sq(fishTank.get(i).speedX));
        }
      }
    }
    if (ammonia>300) {
      for (int i=0; i<fishTank.size (); i++) {
        if ((int)random(fishTank.get(i).age-ammonia)==(int)random(fishTank.get(i).age-ammonia)) { 
          fishTank.get(i).isDead=true;
          fishTank.get(i).death="Death due to un-clean tank";
        }
      }
    }
    for (int i=0; i<fishTank.size (); i++) {//detecting fish-pellet collision & fish closeness to food
      Fish n = fishTank.get(i);
      for (int j=0; j<pelletList.size (); j++) {
        Pellet p=pelletList.get(j);
        if (n.closeFood(p) == true && n.isDead==false  && (p.type==1 || p.type==2)) {
          if (n instanceof Goldfish) {
            n.speedX=random(0.1, 3)*(p.pX-n.fishX)/sqrt(sq(p.pX-n.fishX)+sq(p.pY-n.fishY));
            n.speedY=sqrt(9-sq(n.speedX))*(p.pY-n.fishY)/sqrt(sq(p.pX-n.fishX)+sq(p.pY-n.fishY));
          } else if (n instanceof Whale) {
            n.speedX=random(0.1, 1)*(p.pX-n.fishX)/sqrt(sq(p.pX-n.fishX)+sq(p.pY-n.fishY));
            n.speedY=sqrt(1-sq(n.speedX))*(p.pY-n.fishY)/sqrt(sq(p.pX-n.fishX)+sq(p.pY-n.fishY));
          } else if (n instanceof Piranha) {
            n.speedX=random(1.1, 2)*(p.pX-n.fishX)/sqrt(sq(p.pX-n.fishX)+sq(p.pY-n.fishY));
            n.speedY=sqrt(4-sq(n.speedX))*(p.pY-n.fishY)/sqrt(sq(p.pX-n.fishX)+sq(p.pY-n.fishY));
          }
        }
        if (n.hasCollision(p) == true && n.isDead==false) {
          pelletList.remove(j);
          if (p.type==1) n.changeWeight(5);
          else if (p.type==2) n.changeWeight(-10);
          else if (p.type==3) n.slow();
        }
      }
    }//end detecting fish-pellet collision & fish closeness to food
  }//end of paused frame
  
  
  if (frame) theTank.showAll();
  else theTank.updateAll();

  for (int i=0; i<bubbles.size (); i++) {//showing & moving bubbles
    bubbles.get(i).show();
    if (frame==false) bubbles.get(i).move();
    if (bubbles.get(i).bY<=-bubbles.get(i).bSize) bubbles.remove(i);
  }

  if (clicked==true && theTank.contains(fishClick)==true) {
    noStroke();
    if (fishClick instanceof Toroidalfin) fill(255, 0, 0, 127);
    else fill(fishClick.skin, 127);
    ellipse (fishClick.fishX, fishClick.fishY, 5*fishClick.weight/3, 5*fishClick.weight/3);
  }

  if (clean==true) {
    deltaX+=5;
    imageMode(CENTER);
    image(net, deltaX, 0, 200, 200);
    for (int i=0; i<fishTank.size (); i++) {
      if (fishTank.get(i).isDead==true && fishTank.get(i).fishY>=-fishTank.get(i).weight/2 && fishTank.get(i).fishY<=100-fishTank.get(i).weight/2 && fishTank.get(i).fishX<=deltaX && fishTank.get(i).fishX>=deltaX-50) fishTank.remove(i);
    }
    if (deltaX>=650) clean=false;
  }
  drawButtons();
  textAlign(CENTER);
  if (clicked==true && theTank.contains(fishClick)) text("Name: " + fishClick.name + "\nSpecies: " + fishClick.type + "\nGender: " + fishClick.getGender() + "\nAge: " + fishClick.age/900 + "\nWeight: " + nf(fishClick.weight, 0, 1) + "\n" + fishClick.death, 700, 300);
}

void keyPressed() {
  if (key==' ') {//pause
    if (frame==false) frame=true;
    else frame=false;
  } else if (key=='f') {//Sprinkle food
    for (int i=0; i<8; i++) theTank.add(new Pellet(1));
  } else if (key=='p') {//Sprinkle poison
    for (int i=0; i<8; i++) theTank.add(new Pellet(2));
  } else if (key=='t') {//Tap the Tank
    theTank.tapTheTank();
  } else if (key=='g') theTank.add(new Goldfish());//add goldfish
  else if (key=='w') theTank.add(new Whale());//add whale
  else if (key=='h') theTank.add(new Piranha());//add piranha
  else if (key=='d') theTank.add(new Toroidalfin());//add toroidalfin
  else if (key=='s') {//Sprinkle slowness
    for (int i=0; i<8; i++) theTank.add(new Pellet(3));
  } else if (key=='c') {//clean the tank
    clean=true;
    deltaX=0;
    for (int i=0; i<fishTank.size (); i++) fishTank.get(i).ammonia=0;
    ammonia=0;
  } else if (key=='r') {//Reset
    theTank.reset();
  }
}

void mouseDragged() {
  for (int i=0; i<theTank.items.size (); i++) {
    if (sq(mouseX-theTank.items.get(i).getX())+sq(mouseY-theTank.items.get(i).getY())<sq(theTank.items.get(i).getRadius()+5)) {
      if (mouseX>theTank.items.get(i).getRadius() && mouseX<600-theTank.items.get(i).getRadius() && mouseY>theTank.items.get(i).getRadius() && mouseY<600-theTank.items.get(i).getRadius()) {
        Fish tankFish=(Fish)theTank.items.get(i);
        tankFish.setFishPos(mouseX, mouseY);
      }
    }
  }
}

void mouseClicked() {
  if (sq(mouseX-650)+sq(mouseY-50)<1600) {//feed the fish
    for (int i=0; i<8; i++) theTank.add(new Pellet(1));
  }
  if (sq(mouseX-650)+sq(mouseY-140)<1600) {//poison the fish
    for (int i=0; i<8; i++) theTank.add(new Pellet(2));
  }
  if (sq(mouseX-650)+sq(mouseY-230)<1600) {//slow
    for (int i=0; i<8; i++) theTank.add(new Pellet(3));
  }
  if (sq(mouseX-750)+sq(mouseY-50)<1600) {//tap the tank
    theTank.tapTheTank();
  }
  if (sq(mouseX-750)+sq(mouseY-140)<1600) {//clean the tank
    clean=true;
    deltaX=0;
    for (int i=0; i<fishTank.size (); i++) fishTank.get(i).ammonia=0;
    ammonia=0;
  }
  if (sq(mouseX-750)+sq(mouseY-230)<1600) {//Reset
    theTank.reset();
  }
  if (sq(mouseX-650)+sq(mouseY-440)<1600) theTank.add(new Goldfish());//add goldfish
  if (sq(mouseX-650)+sq(mouseY-525)<1600) theTank.add(new Whale());//add whale
  if (sq(mouseX-750)+sq(mouseY-440)<1600) theTank.add(new Piranha());//add piranha
  if (sq(mouseX-750)+sq(mouseY-525)<1600)  theTank.add(new Toroidalfin());//add toroidalfin
  for (int i=0; i<theTank.items.size (); i++) {//fish info
    if (theTank.get(i) instanceof Fish) {
      if (sq(mouseX-theTank.get(i).getX())+sq(mouseY-theTank.items.get(i).getY())<sq(theTank.items.get(i).getRadius())) {
        clicked=true;
        fishClick=(Fish)theTank.items.get(i);
      }
    }
  }
}

void drawButtons() {
  textAlign(CENTER);
  fill(220);
  noStroke();
  rect(600, 0, 200, 600);//panel

  fill(0, 255, 0);//feed the fish
  ellipse(650, 50, 80, 80);
  fill(0);
  text("Sprinkle \nFood (f)", 650, 50);//feed the fish

  fill(255, 0, 0);//poison the fish
  ellipse(650, 140, 80, 80);
  fill(0);
  text("Sprinkle \nPoison (p)", 650, 140);//poison the fish

  fill(255, 255, 0);//slow
  ellipse(650, 230, 80, 80);
  fill(0);
  text("Sprinkle \nSlowness \n(s)", 650, 225);//slow

  fill(0, 200, 255);//tap the tank
  ellipse(750, 50, 80, 80);
  fill(0);
  text("Tap the \nTank (t)", 750, 50);//tap the tank

  fill(0, 200, 255);//clean the tank
  ellipse(750, 140, 80, 80);
  fill(0);
  text("Clean the \nTank (c)", 750, 140);//clean the tank

  fill(0, 200, 255);//Reset
  ellipse(750, 230, 80, 80);
  fill(0);
  text("Reset (r)", 750, 230);//Reset

  fill(255, 165, 0);//add a fish
  ellipse(650, 440, 80, 80);
  fill(0);
  text("Goldfish" + "\n(g)", 650, 440);//add a fish

  fill(190);//2
  ellipse(650, 525, 80, 80);
  fill(0);
  text("Whale" + "\n(w)", 650, 525);//whale

  fill(64, 224, 208);//piranha
  ellipse(750, 440, 80, 80);
  fill(0);
  text("Piranha" + "\n(h)", 750, 440);//piranha

  stroke(255, 0, 0);//toroidalfin
  noFill();
  ellipse(750, 525, 80, 80);
  fill(0);
  text("Toroidalfin" + "\n(d)", 750, 525);//toroidalfin
  text("To pause, press the space bar", 700, 585);
  fill(0);
}

