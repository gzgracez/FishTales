class Bubbles {  
  float bX, bY;
  float bSize;
  float move;
  float stopX1, stopX2;

  Bubbles(float x, float y, float s) {
    bX=x;
    bY=y;
    bSize=s;
    move=2;
    stopX1=bX-2;
    stopX2=bX+2;
  }

  void show() {
    noFill();
    stroke(255);
    ellipse(bX, bY, bSize, bSize);
  }

  void move() {
    if (bY>-bSize) {
      bY--;
      bX+=move/10;
    }
    if (bX<=stopX1)
      move=-1*move;
    else if (bX>=stopX2)
      move=-1*move;
  }
}
