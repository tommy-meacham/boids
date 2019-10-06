
Flock flock;
Predator pred;
GuiLayer gui;


float MAX_FORCE = 0.05;
float MAX_SPEED = 4;
float NEIGHBOR_DIST = 80;
float DESIRED_SEP = 50;
float SEP_FORCE = 1.5;
float ALIGN_FORCE = 0.8;
float COH_FORCE = 1.0;


void setup() {
  size(700, 700,P3D);
  
  //Define the Gui Parameters of the app
  gui = new GuiLayer(this);
 
  GSlider slider = new GSlider(this, width-200, height-100, 200, 100, 50);
  slider.setShowValue(true);
  slider.setLimits(1.5,0.0,2.0);
  gui.addSlider("SEP_FORCE", slider);
  
  //Define the boids in the system
  flock = new Flock();
  for (int i = 0; i < 700; i++) {
    flock.addBoid(new Boid(MAX_FORCE, MAX_SPEED, NEIGHBOR_DIST, DESIRED_SEP, SEP_FORCE, ALIGN_FORCE, COH_FORCE));
  }
  
  flock.addPredator(new Predator(0.05, 8, NEIGHBOR_DIST, DESIRED_SEP, SEP_FORCE, ALIGN_FORCE, COH_FORCE));
  flock.addPredator(new Predator(0.05, 8, NEIGHBOR_DIST, DESIRED_SEP, SEP_FORCE, ALIGN_FORCE, COH_FORCE));
}

void draw() {
  background(255);
  camera(width/2, height/2, 1000, width/2, height/2, 0, 0, 1, 0);
  //camera(mouseX*2, height/2, mouseY*3, width/2, height/2, 0, 0, 1, 0);
   
  //gui.drawScene();
  flock.run();
  
  if(gui.isMouseLocked()){
    flock.drawNeighbors(NEIGHBOR_DIST);
  }
}

void mousePressed() {
  gui.setMouseLock(true); 
}

void mouseReleased() {
  gui.setMouseLock(false);
}
