interface Tankable {
  void update();
  boolean hasCollision(Tankable t);
  void bump();
  boolean stillKickin();
}
