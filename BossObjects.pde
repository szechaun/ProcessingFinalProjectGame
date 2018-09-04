class BossObjects {
  PVector pos, vel, dimension;
  PImage img;
  float damp = 1;
  BossObjects(PVector pos, PVector vel) {
    this.pos=pos;
    this.vel=vel;
    
  }
  void update() {
    move();
    handleWalls();
    
  }
  void move() {
    pos.add(vel);
    vel.mult(damp);
  }
  void handleWalls() {


  }

}