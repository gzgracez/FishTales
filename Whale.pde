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
}

