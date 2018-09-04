
float speed = 2;
float upGrav = 0.3;
float grav = 1.5;
PVector gravForce = new PVector(0, grav);
int repeatX=2;
int timer = 0;


PVector upForce = new PVector(0, -speed * 25);
PVector downForce = new PVector(0, speed);
PVector leftForce = new PVector(-speed, 0);
PVector rightForce = new PVector(speed, 0);
boolean up, down, left, right;

void keyPressed() {


  if (key == 'w') 
    avt.fire();

  
  if (key == 's')avt.fireDown();
  if (key == 'a')avt.fireLeft();
  if (key == 'd')avt.fireRight();



  if (key == CODED) {
    if (keyCode == UP) up = true;
    else if (keyCode == DOWN) down = true;
    else if (keyCode == LEFT) {
      left = true;
      avt.turning = -1;
    } else if (keyCode == RIGHT) { 
      right = true;
      avt.turning = 1;
    }
    avt.walk();
  }
}
void keyReleased() {
  if (key == CODED) {
    if (keyCode == UP) up = false;
    else if (keyCode == DOWN) down = false;
    else if (keyCode == LEFT) left = false;
    else if (keyCode == RIGHT) right = false;
  }
  avt.sit();
}