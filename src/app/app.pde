
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
  size(1000, 700,P3D);
  
  //Define the Gui Parameters of the app
  gui = new GuiLayer(this);
  
  GSlider force = new GSlider(this, width-200, height-360, 200, 100, 50);
  force.setShowValue(true);
  force.setLimits(MAX_FORCE,0.0,0.3);
  gui.addSlider("MAX_FORCE", force);
  
  GSlider speed = new GSlider(this, width-200, height-290, 200, 100, 50);
  speed.setShowValue(true);
  speed.setLimits(MAX_SPEED,0.0,10);
  gui.addSlider("MAX_SPEED", speed);
 
  GSlider alignment = new GSlider(this, width-200, height-220, 200, 100, 50);
  alignment.setShowValue(true);
  alignment.setLimits(ALIGN_FORCE,0.0,2.0);
  gui.addSlider("ALIGN_FORCE", alignment);
  
  GSlider separation = new GSlider(this, width-200, height-150, 200, 100, 50);
  separation.setShowValue(true);
  separation.setLimits(SEP_FORCE,0.0,5.0);
  gui.addSlider("SEP_FORCE", separation);
  
  GSlider cohesion = new GSlider(this, width-200, height-80, 200, 100, 50);
  cohesion.setShowValue(true);
  cohesion.setLimits(COH_FORCE,0.0,5.0);
  gui.addSlider("COH_FORCE", cohesion);
  
  
  
  //Define the boids in the system
  flock = new Flock();
  for (int i = 0; i < 700; i++) {
    flock.addBoid(new Boid(MAX_FORCE, MAX_SPEED, NEIGHBOR_DIST, DESIRED_SEP, SEP_FORCE, ALIGN_FORCE, COH_FORCE));
  }
  
  //flock.addPredator(new Predator(0.05, 8, NEIGHBOR_DIST, DESIRED_SEP, SEP_FORCE, ALIGN_FORCE, COH_FORCE));
  //flock.addPredator(new Predator(0.05, 8, NEIGHBOR_DIST, DESIRED_SEP, SEP_FORCE, ALIGN_FORCE, COH_FORCE));
}

void draw() {
  background(255);
  camera(width/2, height/2, 1000, width/2, height/2, 0, 0, 1, 0);
  //camera(mouseX*2, height/2, mouseY*3, width/2, height/2, 0, 0, 1, 0);
   
  gui.drawScene();
  flock.updateForceConstants(gui.getValueOfSlider("MAX_FORCE"), gui.getValueOfSlider("MAX_SPEED"), gui.getValueOfSlider("ALIGN_FORCE"), gui.getValueOfSlider("SEP_FORCE"), gui.getValueOfSlider("COH_FORCE"));
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
