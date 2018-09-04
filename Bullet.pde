class Bullet {
  PVector pos, vel;
  int dmg;
  int bulletWidth =10;
  int bossWidth = 90;
  

  Bullet(PVector pos, PVector vel) {
    this.pos = pos;
    this.vel = vel;
  }
  void update(ArrayList bullets) {
    move();
    render();
    for (int i = 0; i < monsters.size(); i++) {
      Monster monster = monsters.get(i);
      if (dist(monster.pos.x, monster.pos.y, pos.x, pos.y) < 50 / 2 + 10 / 2) {       
        monster.hit();

        bullets.remove(this);
      }
    }
    if (pos.y < 0) {
      bullets.remove(this);
    }
    if (pos.y > height) {
      bullets.remove(this);
    }
    if (pos.x <0) {
      bullets.remove(this);
    }
    if (pos.x >width) {
      bullets.remove(this);
    }
  }
  void updateTwo(ArrayList bullets) {
    move();
    render();
    for (int i = 0; i < monsters.size(); i++) {
      Monster monster = monsters.get(i);
      if (dist(monster.pos.x, monster.pos.y, pos.x, pos.y) < 50 / 2 + 10 / 2) {       
        monster.hit();

        bullets.remove(this);
      }
    }
    for (int i = 0; i < monsterTwo.size(); i++) {
      MonsterTwo monsTwo = monsterTwo.get(i);
      if (dist(monsTwo.pos.x, monsTwo.pos.y, pos.x, pos.y) < 50 / 2 + 10 / 2) {     
        monsTwo.hit();

        bullets.remove(this);
      }
    }

    if (pos.y < 0) {
      bullets.remove(this);
    }
    if (pos.y > height) {
      bullets.remove(this);
    }
    if (pos.x <0) {
      bullets.remove(this);
    }
    if (pos.x >width) {
      bullets.remove(this);
    }
  }
  void updateThree(ArrayList bullets) {
    move();
    render();
    //for (int i = 0; i < monsters.size(); i++) {
    //  Monster monster = monsters.get(i);
    //  if (dist(monster.pos.x, monster.pos.y, pos.x, pos.y) < 50 / 2 + 10 / 2) {       
    //    monster.hit();


    //  }
    //}
    //    for (int i = 0; i < monsterTwo.size(); i++) {
    //  MonsterTwo monsTwo = monsterTwo.get(i);
    //  if (dist(monsTwo.pos.x, monsTwo.pos.y, pos.x, pos.y) < 50 / 2 + 10 / 2) {     
    //    monsTwo.hit();
    //    monsterTwo.remove(monsTwo);


    //  }
    //}
    if (dist(boss.pos.x, boss.pos.y, pos.x, pos.y) < bossWidth/2 + bulletWidth/2 ) {
      boss.hit();
      bullets.remove(this);
    }





    if (pos.y < 0) {
      bullets.remove(this);
    }
    if (pos.y > height) {
      bullets.remove(this);
    }
    if (pos.x <0) {
      bullets.remove(this);
    }
    if (pos.x >width) {
      bullets.remove(this);
    }
  }

  boolean collision(Boss other) {
    if (dist(pos.x, pos.y, other.pos.x, other.pos.y) < 5 + 50) {
      return true;
    }
    return false;
  }


  void bulletDmg() {
    dmg =1;
  }

  void move() {
    pos.add(vel);
  }
  void render() {
    pushMatrix();
    strokeWeight(5);
    stroke(255, 0, 0);
    fill(0, 255, 0);
    translate(pos.x, pos.y);
    ellipse(0, 0, 10, 10);
    popMatrix();
  }
}