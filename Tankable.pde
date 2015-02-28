interface Tankable {
  public void update();
  public boolean stillKickin();
  public void bump();
  public boolean hasCollision(Tankable t);
  public float getRadius();
  public float getX();
  public float getY();
  public void show();
}
