import ddf.minim.*;
import ddf.minim.ugens.*;
import ddf.minim.effects.*;
Minim m;


final String JUMP="jump.wav";
final String SONG="song.mp3";

AudioPlayer sound;
AudioPlayer song;
AudioPlayer laser;
AudioPlayer grunt;
AudioPlayer dead;


PImage [] blinking = new PImage[6];
PImage [] flying = new PImage[6];
PImage saiyan[] = new PImage[6];
PImage aura[] = new PImage[6];
PImage potionImg;


int countWing = 1;
int countMons = 1;
int countmonTwo =1;
int damageState = 1;
int beastState = 0;
boolean runOnce = true;
boolean renderOnce = true;


GameWorld gw;
Boss boss;
DamageUp dmgUp;
Avatar avt;
Wing w;

ArrayList<Block> blocks = new ArrayList<Block>();
ArrayList<Monster> monsters = new ArrayList<Monster>();
ArrayList<MonsterTwo> monsterTwo = new ArrayList<MonsterTwo>();
ArrayList<CheckPoint> checkPoint = new ArrayList<CheckPoint>();
ArrayList<Potion> potion = new ArrayList<Potion>();


//states 

final int INSTRUCTION = 5;
final int LEVEL_ONE = 0;
final int LEVEL_TWO = 1;
final int LEVEL_THREE =2;
final int WON = 3;
final int LOST = 4;

int state = INSTRUCTION;

void playSound(String file) {
  sound=m.loadFile(file);

  sound.play();
}

void setup() {
  m = new Minim(this);
  song = m.loadFile("song.mp3");

  song.loop();
  

  


  dead = m.loadFile("Falling.mp3");
  gw = new GameWorld();

  size(1300, 800);
  loadCatFrames();

  boss = new Boss(new PVector(width - 100, height-400), new PVector (0, 2));
  PImage avtImg;
  avtImg = loadImage("manwalk0.png");
  avt = new Avatar(avtImg, new PVector(20, height/4 * 3));
  avtImg.resize(avtImg.width/2, avtImg.height/2);
  avt.jumping = true;

  PImage damageImg = loadImage("damage.png");
  dmgUp = new DamageUp(damageImg, new PVector(300, 350));
  damageImg.resize(damageImg.width/2, damageImg.height/2);

  PImage wingImg = loadImage("wing.png");
  w = new Wing(wingImg, new PVector(980, 205));
  wingImg.resize(wingImg.width/3, wingImg.height/2);



  potionImg = loadImage("health.png");
  potionImg.resize(potionImg.width/2, potionImg.height/2);
  for (int i = 0; i<1; i++) {
    spawnPotion();
  }



  for (int i =0; i < countMons; i++) {
    spawnMon();
  }
  for (int i=0; i<flying.length; i++) {
    flying[i] = loadImage("beholder"+i+".png");
  }
  for (int i =0; i < countmonTwo; i++) {
    spawnMonTwo();
  }
  for (int i =0; i < countWing; i++) {
  }

  spawnCheckPoint();
}
void draw() {


  switch(state)
  {
  case INSTRUCTION:
    instructions();
    break;
  case LEVEL_ONE:
    gamePlay();
    break;
  case LEVEL_TWO:
    gamePlayTwo();
    break;
  case LEVEL_THREE:
    gamePlayThree();
    break;
  case WON:
    textScreen("You won!");
    break;
  case LOST:
    
    textScreen("You lost!");
    break;
  }
}
void instructions() {
   gw.startScreen();


}
public void mousePressed() {
  if (state == 5) {startGame();}
}
void startGame() {
  state = 0;
}




void drawHealthBar() {
  int healthBarWidth = 200;
  pushMatrix();
  fill(0, 64);
  translate(20, 20);
  rect(0, 0, healthBarWidth, 20); //container for health
  fill(255, 0, 0, 255);
  rect(0, 0, healthBarWidth * avt.healthPercentage, 20); //health bar
  popMatrix();
}
void drawBossHealthBar() {
  int healthBarWidth = 100;
  pushMatrix();
  fill(0, 64);
  translate(boss.pos.x-60, boss.pos.y-150);
  rect(0, 0, healthBarWidth, 20); //container for health
  fill(255, 0, 0, 255);
  rect(0, 0, healthBarWidth * boss.healthPercentage, 20); //health bar
  popMatrix();
}

void textScreen(String str) {
  background(255);
  PFont font = loadFont("Arial-Black-48.vlw");
  fill(240,29,29);
  textFont(font, 60);
  text(str, width/2-120, height/2);
}

void gamePlay() {

  gw.sky();






  if (runOnce) {
    blocks.add(new Block(new PVector(width/2, height - 20), new PVector(width, 40)));
    blocks.add(new Block(new PVector(200, height - 120), new PVector(200, 40)));
    blocks.add(new Block(new PVector(400, height - 240), new PVector(200, 40)));
    blocks.add(new Block(new PVector(700, height - 400), new PVector(300, 40)));
    blocks.add(new Block(new PVector(width/2+500, height - 500), new PVector(200, 40)));
    runOnce = false;
  }




  if (up && !avt.jumping) {
    avt.jump(upForce);
    //jump = minim.loadFile("jump.wav");
    //jump.play();
    playSound(JUMP);
  }
  if (down) { 
    avt.move(downForce);
  }
  if (left) avt.move(leftForce);
  if (right) avt.move(rightForce);
  //
  for (int j =0; j < monsters.size(); j++) {
    Monster mon = monsters.get(j);

    mon.update();
    if (mon.health <=0) {
      monsters.remove(mon);
    }

    if (mon.collision(avt)) {
      avt.hit();
      avt.pos.x=20;
      avt.pos.y=height-60;

      mon.hit();
    }
  }
  for (int j =0; j < checkPoint.size(); j++) {
    CheckPoint check = checkPoint.get(j);

    check.update();

    if (check.collision(avt)) {



      state = LEVEL_TWO;
      avt.pos.x=20;
      avt.pos.y=900;
      runOnce = true;
    }
  }



  //
  dmgUp.render();
  if (dmgUp.collision(avt)) {
    damageState = 2;
    textSize(32);
    fill(247, 53, 53);
    text("FOREVER double damage ↑", 100, 100);
  }





  avt.update();



  if (avt.block != null) {
    if (!avt.block.isOn(avt)) {
      avt.jumping = true;
    }
  }

  if (avt.jumping) {

    avt.move(gravForce);
    for (int i = 0; i < blocks.size(); i++) {
      Block b = blocks.get(i);
      if (b.bump(avt)) {
        if (avt.vel.y > 0) {
          avt.landOn(b);
        } else {
          avt.fall();
        }
      }
    }
  }




  for (int i = 0; i < blocks.size(); i++)
    //blocks.get(i).drawMe();
    blocks.get(i).drawMe();

  avt.render();
  drawHealthBar();
}


void gamePlayTwo() {

  gw.night();
  if (runOnce) {
    blocks.add(new Block(new PVector(width/2, height - 20), new PVector(width, 40)));
    blocks.add(new Block(new PVector(0, height - 120), new PVector(200, 40)));
    blocks.add(new Block(new PVector(700, height - 240), new PVector(200, 40)));
    blocks.add(new Block(new PVector(700, height - 400), new PVector(300, 40)));
    blocks.add(new Block(new PVector(width/2+500, height - 500), new PVector(200, 40)));
    runOnce = false;
  }

  println(state);


  if (up && !avt.jumping) {
    avt.jump(upForce);
    //jump = minim.loadFile("jump.wav");
    //jump.play();
    playSound(JUMP);
  }
  if (down) avt.move(downForce);
  if (left) avt.move(leftForce);
  if (right) avt.move(rightForce);
  //
  for (int j =0; j < monsterTwo.size(); j++) {
    MonsterTwo mtwo = monsterTwo.get(j);

    mtwo.update();
    if (mtwo.health <= 0) {
      monsterTwo.remove(mtwo);
    }

    if (mtwo.collision(avt)) {           
      avt.hit();

      avt.pos.x=20;
      avt.pos.y=height-60;

      mtwo.hit();
    }
  }

  for (int j =0; j < monsters.size(); j++) {
    Monster mon = monsters.get(j);

    mon.updateTwo();
    if (mon.health <= 0) {
      monsters.remove(mon);
    }

    if (mon.collision(avt)) {
      avt.hit();

      avt.pos.x=20;
      avt.pos.y=height-60;

      mon.hit();
    }
  }

  avt.updateTwo();

  if (avt.block != null) {
    if (!avt.block.isOn(avt)) {
      avt.jumping = true;
    }
  }

  if (avt.jumping) {

    avt.move(gravForce);
    for (int i = 0; i < blocks.size(); i++) {
      Block b = blocks.get(i);
      if (b.bump(avt)) {
        if (avt.vel.y > 0) {
          avt.landOn(b);
        } else {
          avt.fall();
        }
      }
    }
  }

  w.render();
  if (w.collision(avt)) {
    beastState = 1;
  }




  for (int i = 0; i < blocks.size(); i++)
    //blocks.get(i).drawMe();
    blocks.get(i).drawMe();

  avt.render();
  drawHealthBar();

  for (int j =0; j < checkPoint.size(); j++) {
    CheckPoint check = checkPoint.get(j);

    check.updateTwo();
    if (check.collision(avt)) {


      checkPoint.remove(check);
      state = LEVEL_THREE;
      avt.pos.x=20;
      avt.pos.y=500;
      runOnce = true;
    }
  }
}
void gamePlayThree() {
  gw.space();
  PVector upForce = new PVector(0, -speed);
  if (up) avt.move(upForce);
  if (down) avt.move(downForce);
  if (left) avt.move(leftForce);
  if (right) avt.move(rightForce);

  boss.render();
  boss.update();
  drawBossHealthBar();
  if (boss.health <= 0) {
    state = WON;
  }
  for (int i =0; i < potion.size(); i++) { 
    Potion ptn = potion.get(i);

    ptn.update();

    if (ptn.collision(avt)) {

      avt.rejuvenate();
      if (avt.health <5)avt.health+=1;
      potion.remove(ptn);
      if (potion.size() < 1) spawnPotion();
    }
  }


  avt.updateThree();
  avt.render();
  drawHealthBar();
}

void spawnMon() {
  //monsters.add(new Monster(monImg, new PVector(random(monImg.width, width-monImg.width), random(monImg.height/2, height/4)), new PVector(8, 0)));
  monsters.add(new Monster(new PVector(700, height - 450), new PVector(2, 0)));
  monsters.add(new Monster(new PVector(700, height - 70), new PVector(2, 0)));
  
}
void spawnMonTwo() {
  //monsters.add(new Monster(monImg, new PVector(random(monImg.width, width-monImg.width), random(monImg.height/2, height/4)), new PVector(8, 0)));
  monsterTwo.add(new MonsterTwo(new PVector(900, height - 450), new PVector(0, 0)));
  monsterTwo.add(new MonsterTwo(new PVector(500, height - 60), new PVector(0, 0)));
  monsterTwo.add(new MonsterTwo(new PVector(1250, height - 550), new PVector(0, 0)));
}
void spawnPotion() {
  potion.add(new Potion(potionImg, new PVector(random(potionImg.width, width-300), random(potionImg.height, height-potionImg.height))));
}
void spawnCheckPoint() {
  checkPoint.add(new CheckPoint(new PVector(1200, 220)));
}