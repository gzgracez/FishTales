class Piranha extends Fish {
  Piranha() {
    super();//calls the Fish() constructor to initialize all the common data
    maxAge=10000;
    maxWeight=50;
    fishX=random(50, 550);
    fishY=random(50, 550);
    speedX=random(-2, 2);
    if (speedX==0) speedX=random(-2, 2);
    speedY=sqrt(4-sq(speedX));
    skin=color(random(224), random(255), random(112,255));
    weight=random(10, 15);
    type="Piranha";
  }
}

