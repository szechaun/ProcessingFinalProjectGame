
class GameWorld {
  //class that represents the game world.
  //the game world is an image
  PImage sky;
  PImage night;
  PImage space;
  PImage startScreen;

  GameWorld() {
    //load the background image
    sky = loadImage("sky.jpg");
    sky.resize(1300,800);
    night = loadImage("night.jpg");
    night.resize(1300, 800);
    space = loadImage("space.jpg");
    space.resize(1300, 800);
    startScreen = loadImage("instruction.jpg");
    startScreen.resize(1300,800);
    
  }
    void startScreen() {
    //display thhe image
    image(startScreen, 0, 0);
  }

  void sky() {
    //display thhe image
    image(sky, 0, 0);
  }

  void night() {
    image(night, 0, 0);
  }
  void space() {
    image(space, 0, 0);
  }
}