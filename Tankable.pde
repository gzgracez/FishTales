interface Tankable {
  void update();
  boolean hasCollision(Tankable t);
  void bump();
  boolean stillKickin();
  float getX();
  float getY();
  float getRadius();
  void show();
}
