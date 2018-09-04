class Boss extends BossObjects {
  int maxHealth=50;
  int state;
  int health = maxHealth;
  float healthPercentage=1;

  int bulletWidth =10;
  int bossWidth = 90;

  ArrayList<Projectile> bossProjectile = new ArrayList<Projectile>();

  Boss(PVector pos, PVector vel) {
    super(pos, vel);
  }


  void checkProjectile() {
    for (int i=0; i<bossProjectile.size(); i++) {
      Projectile currProjectile=bossProjectile.get(i);
      currProjectile.update(bossProjectile);
    }
  }
  void update() {
    super.update();
    if (pos.y < 150 || pos.y>650) vel.y *= -1;
    checkProjectile();
    println(boss.health);





    if (boss.collision(avt)) {
      avt.hit();
      avt.pos.x=20;
      avt.pos.y=height/2;
    }
    if (health >0 && (frameCount %30 == 0)) {
      boss.fireBoss();
    }
  }


  void fireBoss() {
    bossProjectile.add(new Projectile(new PVector (pos.x, pos.y), new PVector (random(-10, -20), random(-5, 6))));
  }

  void hit() {
    if (damageState == 1) {

      health = health - 1;
    }
    if (damageState == 2) {

      health = health - 2;
    }
    if (beastState == 1) {

      health = health - 3;
    }


    healthPercentage = (float)health/(float)maxHealth;
  }

  boolean collision(Avatar other) {
    if (dist(pos.x, pos.y, other.pos.x, other.pos.y) < 50 + other.img.width/2) {
      return true;
    }
    return false;
  }










  void render() {
    pushMatrix();
    translate(pos.x, pos.y);
    scale(0.7);

    //head
    fill(255);
    stroke(1);
    ellipse(0, -100, 50, 50);
    //body
    rect(-30, -75, 60, 110);
    //legs
    rect(-25, 35, 25, 40);
    rect(0, 35, 25, 40);
    arc(-12, 75, 25, 25, PI, PI*2);
    arc(13, 75, 25, 25, PI, PI*2);
    //hand
    rect(-40, -70, 15, 90);
    rect(25, -70, 15, 90);
    ellipse(-32, 21, 15, 15);
    ellipse(33, 21, 15, 15);
    //eyes
    arc(-10, -105, 8, 8, PI, PI*2);
    arc(10, -105, 8, 8, PI, PI*2);
    //lips
    ellipse(0, -85, 20, 10);
    //collarlines
    stroke(255, 211, 52);
    line(-20, -60, 20, -60);
    line(-20, -50, 20, -50);
    line(-20, -40, 20, -40);
    line(-20, -30, 20, -30);
    //tophat
    stroke(247, 30, 39);
    fill(0);
    ellipse(0, -160, 50, 10);
    rect(-25, -159, 50, 40);
    ellipse(0, -119, 100, 10);


    popMatrix();
  }
}