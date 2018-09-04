class Monster {
  float damp =  0.8;
  int health;
  PImage img;
  PVector pos;
  PVector vel;
  int imgIdx =0;
  PImage [] blinking = new PImage[6];
  Monster(PVector pos, PVector vel) {
    this.pos = pos;
    this.vel = vel;
    health = 4;

    for (int i=0; i<blinking.length; i++) {
      blinking[i] = loadImage("zombie"+i+".png");
      blinking[i].resize(blinking[i].width/9, blinking[i].height/9);
    }
    img = blinking[imgIdx];
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
    if (health !=0) {
      pos.add(vel);
      if (pos.x-50 < 520 || pos.x+50>870) vel.x *= -1;

      handleCollision();
      render();
      if (frameCount% 6 ==0) {
        imgIdx++;
        if (imgIdx==blinking.length) {
          imgIdx=0;
        }
      }
    }
  }
  void updateTwo() {
    if (health !=0) {
      pos.add(vel);
      if (pos.x-50 < 500 || pos.x+50>850) vel.x *= -1;

      handleCollision();
      render();
      if (frameCount% 6 ==0) {
        imgIdx++;
        if (imgIdx==blinking.length) {
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
    PImage img= blinking[imgIdx];
    //image(img, -img.width/2, -img.height/2);
    image(img, -img.width/2, -img.height/2);
    popMatrix();
  }
}