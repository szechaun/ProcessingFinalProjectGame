class CheckPoint {
  PVector pos;
  CheckPoint(PVector pos) {
    this.pos = pos;
  }
  boolean collision(Avatar other) {
    if (dist(pos.x, pos.y, other.pos.x, other.pos.y) < 30 + 30) {
      return true;
    }
    return false;
  }
  void update() {
    drawMe();
  }
  void updateTwo() {
    drawMe();
  }
  void drawMe() {
    pushMatrix();
    translate(pos.x, pos.y);
    stroke(0);
    strokeWeight(5);
    line(0,50,0,0);
    strokeWeight(1);
    fill(229,60,60);
    triangle(0,0,-30,10,0,20);


    popMatrix();
  }
}