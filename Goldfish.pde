class Goldfish extends Fish {
  Goldfish() {
    super();//calls the Fish() constructor to initialize all the common data
    maxAge=20000;
    maxWeight=30;
    fishX=random(50, 550);
    fishY=random(50, 550);
    speedX=random(-3, 3);
    if (speedX==0) speedX=random(-3, 3);
    speedY=sqrt(9-sq(speedX));
    skin=color(random(233, 255), random(165), random(128));
    weight=random(6, 10);
    type="Goldfish";
  }
}

