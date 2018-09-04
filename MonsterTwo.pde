class MonsterTwo {
  float damp =  0.8;
  int health;
  PImage img;
  PVector pos;
  PVector vel;
  int imgIdx =0;
  PImage [] flying = new PImage[6];
  ArrayList<MonsterProjectile> projectile= new ArrayList<MonsterProjectile>();
  MonsterTwo(PVector pos, PVector vel) {
    this.pos = pos;
    this.vel = vel;
    health = 10;
    for (int i=0; i<flying.length; i++) {
      flying[i] = loadImage("beholder"+i+".png");
      //blinking[i].resize(blinking[i].width/3, blinking[i].height/3);
    }
    img = flying[imgIdx];
  }
  void checkProjectile() {
    for (int i=0; i<projectile.size(); i++) {
      MonsterProjectile currProjectile=projectile.get(i);
      currProjectile.update(projectile);
    }
  }
  void fireMonster() {
    projectile.add(new MonsterProjectile(new PVector (pos.x, pos.y), new PVector (-1, 0)));
  }
  void handleCollision() {

    if (pos.x>width+img.width/2) pos.x = -img.width/2;
    if (pos.x<-img.width/2) pos.x = width +img.width/2;
    if (pos.y<-img.height/2) pos.y = height + img.height/ 2;
    if (pos.y>height +img.height/ 2) pos.y = -img.height/ 2;
  }
  boolean collision(Avatar other) {
    if (dist(pos.x, pos.y, other.pos.x, other.pos.y) < img.width/2 + other.img.width/2) {
      return true;
    }
    return false;
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
  }
  void update() {
    checkProjectile();
    if (frameCount % 100 ==0 && health >  0) {
      for (int i =0; i < monsterTwo.size(); i++) {
        MonsterTwo monTwo = monsterTwo.get(i);
        monTwo.fireMonster();
      }
    }
    if (health !=0) {
      pos.add(vel);
      if (pos.x-50 < 500 || pos.x+50>850) vel.x *= -1;

      handleCollision();
      render();
      if (frameCount% 6 ==0) {
        imgIdx++;
        if (imgIdx==flying.length) {
          imgIdx=0;
        }
      }
    }
  }


  void render() {

    pushMatrix();
    translate(pos.x, pos.y);

    //image(img, 0-img.width/2, 0-img.height/2);
    //println("Monster x = " + pos.x + " - y = " + pos.y);
    PImage img= flying[imgIdx];
    //image(img, -img.width/2, -img.height/2);
    image(img, -img.width/2, -img.height/2);
    popMatrix();
  }
}