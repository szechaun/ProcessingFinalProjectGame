
class Block {
  PVector pos, dim;
  Block(PVector pos, PVector dim) {
    this.pos = pos;
    this.dim = dim;
  }
  boolean isOn(Avatar avt) {
    //if (abs(c.pos.x - pos.x) < c.dim.x / 2 + dim.x / 2) {
    if (abs(avt.pos.x - (pos.x-avt.pos.x)) < avt.dim.x / 2 + dim.x / 2) {
      return true;
    }
    return false;
  }
  boolean bump(Avatar avt) {
    if (abs(avt.pos.x - (pos.x)) < avt.dim.x / 2 + dim.x / 2 &&
    //if (abs(c.pos.x - pos.x )< c.dim.x / 2 + dim.x / 2 &&
      abs(avt.pos.y - pos.y) < avt.dim.y / 2 + dim.y / 2) {
      return true;
    }
    return false;
  }
//;    void drawMe() {
  void drawMe() {
    noStroke();
    pushMatrix();
    fill(0);
//    translate(pos.x, pos.y);
    translate(pos.x, pos.y);
    rect(-dim.x/2, -dim.y/2, dim.x, dim.y);
    popMatrix();
  }
}