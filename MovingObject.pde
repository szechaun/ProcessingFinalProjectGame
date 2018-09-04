class MovingObject {
  PVector vel, pos, dim;
  float damp = 1;
  PImage img;

  MovingObject(PImage img, PVector pos) {
    this.img = img;
    this.pos = pos;

    
  }
   void update() {
    move();
    handleWalls();
    render();
   }
  void move() {
    pos.add(vel);
    vel.mult(damp);
  }
  void handleWalls() {
        if (pos.y + dim.y/2 > height) { //when it goes off the longest block let it land on the floor
      pos.y = height - dim.y/2;
      vel.y=0;
    }

    //boundary detection. just keep the player from going off the walls.
    if (pos.x < img.width/2) pos.x = img.width/2;
    if (pos.x > width - img.width/2) pos.x = width-img.width/2;
    if (pos.y > height - img.height / 2) pos.y = height - img.height / 2;
  }
  void render() {
    println("eror! render() should be implemented for all child object!");
  }
}