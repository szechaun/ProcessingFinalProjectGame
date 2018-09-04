class MonsterProjectile {
  PVector pos, vel, dimension;
  MonsterProjectile(PVector pos, PVector vel) {
    this.pos = pos;
    this.vel = vel;
    dimension = new PVector(10, 10);
  }
  void update(ArrayList projectile) {
        move();
    render();
    if (dist(avt.pos.x, avt.pos.y, pos.x, pos.y) < 50 / 2 + 10 / 2) {
      avt.hit();
      avt.pos.x=20;
      avt.pos.y=height-60;
      projectile.remove(this);
    }
    if (pos.y > height) {
      projectile.remove(this);
    }
    if (pos.x <0) {
      projectile.remove(this);
    }
    if (pos.x >width) {
      projectile.remove(this);
    }
    
  }
    void move() {
    pos.add(vel);
  }

  void render() {
    //butterfly
    pushMatrix();
    strokeWeight(5);
    stroke(248,255,70);
    fill(0, 255, 0);
    translate(pos.x, pos.y);
    ellipse(0, 0, 10, 10);
    popMatrix();
  }
}