
Flock flock;
Predator pred;
GuiLayer guiLayer;


float MAX_FORCE = 0.05;
float MAX_SPEED = 4;
float NEIGHBOR_DIST = 80;
float DESIRED_SEP = 50;
float SEP_FORCE = 1.5;
float ALIGN_FORCE = 0.8;
float COH_FORCE = 1.0;

boolean mouseLock = false;

void setup() {
  size(700, 700,P3D);
  guiLayer = new GuiLayer(this);
  
  flock = new Flock();
  
  // Add an initial set of boids into the system
  for (int i = 0; i < 700; i++) {
    flock.addBoid(new Boid(MAX_FORCE, MAX_SPEED, NEIGHBOR_DIST, DESIRED_SEP, SEP_FORCE, ALIGN_FORCE, COH_FORCE));
  }
  
  flock.addPredator(new Predator(0.05, 8, NEIGHBOR_DIST, DESIRED_SEP, SEP_FORCE, ALIGN_FORCE, COH_FORCE));
  flock.addPredator(new Predator(0.05, 8, NEIGHBOR_DIST, DESIRED_SEP, SEP_FORCE, ALIGN_FORCE, COH_FORCE));
}

void draw() {
  background(255);
  //camera(mouseX*2, height/2, mouseY*3, width/2, height/2, 0, 0, 1, 0);
  camera(width/2, height/2, 1000, width/2, height/2, 0, 0, 1, 0);
  

  flock.run();
  
  if(mouseLock){
    flock.drawNeighbors(NEIGHBOR_DIST);
  }
}

void mousePressed() {
  mouseLock = true;
}

void mouseReleased() {
  mouseLock = false;
}
