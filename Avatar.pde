class Avatar extends MovingObject {
  //image that is the character
  //PImage img;
  //PVector pos;
  //PVector vel;
  //PVector dim;
  float damp = 0.8; //constant damping factor

  int maxHealth=5;
  int health = maxHealth;
  float healthPercentage=1;
  int imgIdx =0;

  boolean jumping = false;
  Block block = 
    null;
  ArrayList<Bullet> bullets = new ArrayList<Bullet>();
  int fireTimer;
  int currFrame;
  int animationRate=6;
  PImage[] frames;
  int turning=1;


  Avatar(PImage img, PVector pos) {
    //this.img = img; 
    ////what to do with the img parameter?
    //this.pos = pos;
    super(img, pos);
    vel = new PVector();
    dim = new PVector(50, 50);
    frames=manFramesSitting;

    for (int i=0; i<saiyan.length; i++) {
      saiyan[i] = loadImage("saiyan"+i+".png");
    }
    img = saiyan[imgIdx];


    for (int i=0; i<aura.length; i++) {
      aura[i] = loadImage("aura"+i+".png");
    }
    img = aura[imgIdx];
  }

  void walk() {
    frames=manFramesMoving;
  }
  void sit() {
    frames=manFramesSitting;
  }

  void updateFrame() {
    if (frameCount % animationRate == 0) {
      if (currFrame < frames.length - 1)
        currFrame++;
      else
        currFrame = 0;
      img = frames[currFrame];
    }
  }


  void move(PVector acc) {
    vel.add(acc);
  }
  void fire() {
    laser = m.loadFile("laser.wav");
    if (fireTimer==0) {
      bullets.add(new Bullet(new PVector(pos.x, pos.y), new PVector(0, -15)));
      fireTimer =10;
      laser.play();
    }
  }
  void fireDown() {
    laser = m.loadFile("laser.wav");
    if (fireTimer==0) {
      bullets.add(new Bullet(new PVector(pos.x, pos.y), new PVector(0, 15)));
      fireTimer =10;
    }
    laser.play();
  }
  void fireLeft() {
    laser = m.loadFile("laser.wav");
    if (fireTimer==0) {
      bullets.add(new Bullet(new PVector(pos.x, pos.y), new PVector(-15, 0)));
      fireTimer =10;
    }
    laser.play();
  }
  void fireRight() {
    laser = m.loadFile("laser.wav");
    if (fireTimer==0) {
      bullets.add(new Bullet(new PVector(pos.x, pos.y), new PVector(15, 0)));
      fireTimer =10;
    }

    laser.play();
  }


  void update() {

    vel.mult(damp);
    if (fireTimer>0) fireTimer--;

    super.update();
    for (int i= 0; i<bullets.size(); i++) {
      Bullet currBullet = bullets.get(i);
      currBullet.update(bullets);
    }

    render();
    if (damageState == 2) {
      renderSaiyan();
      if (frameCount% 6 ==0) {
        imgIdx++;
        if (imgIdx==saiyan.length) {
          imgIdx=0;
        }
      }
    }
    updateFrame();
  }
  void updateTwo() {

    vel.mult(damp);
    if (fireTimer>0) fireTimer--;

    super.update();
    for (int i= 0; i<bullets.size(); i++) {
      Bullet currBullet = bullets.get(i);
      currBullet.updateTwo(bullets);
    }
    if (beastState == 1) {
      renderAura();
      if (frameCount% 6 ==0) {
        imgIdx++;
        if (imgIdx==aura.length) {
          imgIdx=0;
        }
      }
    }

    render();
    if (damageState == 2) {
      renderSaiyan();
      if (frameCount% 6 ==0) {
        imgIdx++;
        if (imgIdx==saiyan.length) {
          imgIdx=0;
        }
      }
    }
    updateFrame();
  }
  void updateThree() {

    vel.mult(damp);
    if (fireTimer>0) fireTimer--;

    super.update();
    for (int i= 0; i<bullets.size(); i++) {
      Bullet currBullet = bullets.get(i);
      currBullet.updateThree(bullets);
    }

    render();
    if (damageState == 2) {
      renderSaiyan();
      if (frameCount% 6 ==0) {
        imgIdx++;
        if (imgIdx==saiyan.length) {
          imgIdx=0;
        }
      }
    }
    if (beastState == 1) {
      renderAura();
      if (frameCount% 6 ==0) {
        imgIdx++;
        if (imgIdx==aura.length) {
          imgIdx=0;
        }
      }
    }
  }



  void jump(PVector upAcc) {
    move(upAcc);
    jumping = true;
  }


  void landOn(Block b) {
    block = b;
    pos.y = b.pos.y - dim.y /2 - b.dim.y / 2;
    jumping = false;
    vel.y = 0;
  }

  void fall() {
    vel.y *= -1;
  }

  void hit() {
    grunt = m.loadFile("punch.wav");
    health--;
    //if (health <= 0)
    //  //{
    //  //  state = 2;
    //  //}
    //  //check if the health is 0 (the player has lost)
    //  //if yes, then tell the game we've lost
    //  //and always replace the character in the middle of the screen
    //  pos.x = width/2;
    //pos.y = height/4 * 3;
    //and update the health percentage
    grunt.play();
    healthPercentage = (float)health/(float)maxHealth;
    if (health<=0) {
      state = LOST;
    }
  }
  void rejuvenate() {
    if (health<5)
      health+=1;
    healthPercentage = (float)health / (float)maxHealth;
  }


  void render() {
    pushMatrix();
    translate(pos.x, pos.y);
    scale(turning, 1);
    //draw the image
    image(img, 0-img.width/2, 0-img.height/2);
    popMatrix();
  }
  void renderAura() {
    {
      pushMatrix();
      translate(pos.x, pos.y);
      //draw the image
      PImage img= aura[imgIdx];
      image(img, -img.width/2, -img.height/1.3);
      popMatrix();
    }
  }

  void renderSaiyan() {
    {
      pushMatrix();
      translate(pos.x, pos.y);
      //draw the image
      PImage img= saiyan[imgIdx];
      image(img, -img.width/2, -img.height/1.3);
      popMatrix();
    }
  }
}