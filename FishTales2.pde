/*
 Program: Fish Tank 2.0
 Author: Grace Zhang
 Date: 3/7/15
 Notes:
 Tail that grows and flaps along with the fish & follows the direction of movement
 Bubbles come out of fish, then float to the top of the tank (They also move left & right)
 The closer a Fish is to maxAge, the more likely that "Tapping the Tank" will kill it
 "Clean the Tank" (net to get rid of dead fish)-fish movement produces ammonia; if not cleaned, fish start gradually dying after a set amount of time
 Circular buttons
 Gender attribute added to the Fish class; when a male & female of the same breed meet, there is a 20% chance that a new fish of that breed is born
 Fish follow food & poison
 "Slowness" pellets
 Pellets fall
 Click on fish for more info (Name, Species, Gender, Age, Weight, Alive/Death & How)
 Drag the fish
 Keyboard (corresponding keys are written on the button; space bar to pause)
 Reset button to completely reset the screen
 Tap the tank shakes the tank (in addition to making the fish go in opposite directions)
 Bubbles generate at mouse position (if mouse is on the screen) when tank is tapped
 Bubbles appear using the Gaussian distribution
 */
import java.util.*;
ArrayList <Fish> fishTank = new ArrayList <Fish>();
ArrayList <Bubbles> bubbles = new ArrayList <Bubbles>();
ArrayList <Pellet> pelletList = new ArrayList <Pellet>();
FishTank theTank;
boolean clicked=false;
Fish fishClick;
boolean frame=false;
PImage net;

void setup() {
  size(800, 600);
  background (0, 150, 255);
  net=loadImage("net2.png");
  theTank=new FishTank("theTank", width-100, height);
}

void draw() {
  println(theTank.size());
  if (frame) theTank.showAll();
  else theTank.updateAll();
  if (clicked==true && theTank.contains(fishClick)==true) {
    noStroke();
    if (fishClick instanceof Toroidalfin) fill(255, 0, 0, 127);
    else fill(fishClick.getSkin(), 127);
    ellipse (fishClick.getX(), fishClick.getY(), 10*fishClick.getRadius()/3, 10*fishClick.getRadius()/3);
  }
  textAlign(CENTER);
  drawButtons();
  if (clicked==true && theTank.contains(fishClick)) text("Name: " + fishClick.getName() + "\nSpecies: " + fishClick.getType() + "\nGender: " + fishClick.getGender() + "\nAge: " + fishClick.getAge()/900 + "\nWeight: " + nf(fishClick.getRadius()*2, 0, 1) + "\n" + fishClick.getDeath(), 700, 300);
}

void keyPressed() {
  if (key==' ') {//pause
    if (frame==false) frame=true;
    else frame=false;
  } else if (key=='f') {//Sprinkle food
    for (int i=0; i<8; i++) theTank.add(new Pellet(1));
  } else if (key=='p') {//Sprinkle poison
    for (int i=0; i<8; i++) theTank.add(new Pellet(2));
  } else if (key=='t') theTank.tapTheTank(); 
  else if (key=='g') theTank.add(new Goldfish());//add goldfish
  else if (key=='w') theTank.add(new Whale());//add whale
  else if (key=='h') theTank.add(new Piranha());//add piranha
  else if (key=='d') theTank.add(new Toroidalfin());//add toroidalfin
  else if (key=='s') {//Sprinkle slowness
    for (int i=0; i<8; i++) theTank.add(new Pellet(3));
  } else if (key=='c') {//clean the tank
    theTank.deltaX=0;
    theTank.cleanTheTank();
  } else if (key=='r') {//Reset
    theTank.reset();
  }
}

void mouseDragged() {
  for (int i=0; i<theTank.size (); i++) {
    if (theTank.get(i) instanceof Fish) {
      Fish tankFish=(Fish)theTank.getFish(i);
      if (sq(mouseX-tankFish.getX())+sq(mouseY-tankFish.getY())<sq(tankFish.getRadius()+5)) {
        if (mouseX>tankFish.getMaxWeight()/2 && mouseX<600-tankFish.getMaxWeight()/2 && mouseY>tankFish.getMaxWeight()/2 && mouseY<600-tankFish.getMaxWeight()/2) {
          tankFish.setFishPos(mouseX, mouseY);
        }
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
  if (sq(mouseX-750)+sq(mouseY-50)<1600) theTank.tapTheTank();
  if (sq(mouseX-750)+sq(mouseY-140)<1600) {//clean the tank
    theTank.deltaX=0;
    theTank.cleanTheTank();
  }
  if (sq(mouseX-750)+sq(mouseY-230)<1600) theTank.reset();
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

