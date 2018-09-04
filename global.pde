PImage[] manFramesMoving;
PImage[] manFramesSitting;

void loadCatFrames() {
  manFramesMoving=new PImage[2];
  manFramesSitting=new PImage[4];
  
  loadFrames(manFramesMoving, "manwalk");
  loadFrames(manFramesSitting, "man");
  
}
void loadFrames(PImage[] ar, String fname) {
  for (int i=0;i<ar.length;i++) {
    PImage frame=loadImage(fname+i+".png");
    frame.resize(25, 50);
    ar[i]=frame;
  }
}