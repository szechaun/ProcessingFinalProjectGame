class Wing {
  PImage img;
  PVector pos;

  Wing(PImage img, PVector pos) {
    this.img = img;
    this.pos = pos;
  }
  boolean collision(Avatar other) {
    if (dist(pos.x, pos.y, other.pos.x, other.pos.y) < img.width/2 + other.img.width/2) {
      return true;
      
      
    }
    return false;
  }
    void update() {
    
    render();
  }
  
    void render() {
    pushMatrix();
    translate(pos.x, pos.y);
    image(img, 0-img.width/2, 0-img.height/2);
    popMatrix();
  }
}