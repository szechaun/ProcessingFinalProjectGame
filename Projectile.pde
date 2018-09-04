
class Projectile extends Boss {

  
  Projectile(PVector pos, PVector vel) {
    //pos = new PVector(pos.x, pos.y);
    //vel = new PVector(vel.x, vel.y);
    super(pos, vel);
    dimension = new PVector(50, 50);
  }
  void update(ArrayList bossProjectile) {
    move();
    handleWalls();
    render();
    if (dist(avt.pos.x, avt.pos.y, pos.x, pos.y) < 50 / 2 + 10 / 2) {
      avt.hit();
      bossProjectile.remove(this);
    }



  }

  void move() {
    pos.add(vel);
  }
    void handleWalls() {
    if (pos.x<-dimension.x/2) vel.x *= -1;
    if (pos.x>width+dimension.x/2) vel.x *= -1;
    if (pos.y<-dimension.y/2) vel.y *= -1;
    if (pos.y>height+dimension.y/2) vel.y *= -1;
  }



  void render() {
    //butterfly
    pushMatrix();

    strokeWeight(5);
    stroke(255, 36, 36);
    fill(0);
    translate(pos.x, pos.y);
    ellipse(0, 0, 50, 50);
    popMatrix();
  }
}