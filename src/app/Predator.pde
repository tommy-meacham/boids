
class Predator extends Boid {
  Boid prey;
  
  Predator(float maxforce, float maxspeed, float neighbordist, float desiredsep, float sepforce, float alignforce, float cohforce) {
    super(maxforce, maxspeed, neighbordist, desiredsep, sepforce, alignforce, cohforce);
  }
  

  void run(ArrayList<Boid> boids) {
     render();
     if(prey == null){
       prey = findPrey(boids);
     } else {
       drawPreyLine(); 
     }
     
     hunt(prey);
  }
 
  
  void hunt(Boid prey) {
    applyForce(turnTowards(prey));
    applyForce(moveTowards(prey));
    updatePosition();
  }
  
  
  PVector turnTowards(Boid prey) {
    PVector steer = PVector.sub(prey.velocity, velocity);
    steer.setMag(MAX_FORCE);
    return steer; 
  }
 
  
  PVector moveTowards(Boid prey) {
    PVector steer = PVector.sub(prey.position, position);
    steer.setMag(MAX_FORCE);
    return steer;
  } 
  
  void resetPrey() {
      prey = null; 
  }
  
  
  boolean preyWasKilled() {
    return PVector.dist(prey.position,position) < 15;
  }
  
  Boid getPrey() {
    return prey;
  }
 
  
  Boid findPrey(ArrayList<Boid> boids) {
    float closest = 10000;
    Boid prey = null;
    
    for(Boid b : boids) {
      float d = PVector.dist(position,b.position);
      if(d < closest) {
        closest = d;
        prey = b;
      }
    }
    return prey;
  } 
 
  
  void render() {
    pushMatrix();
    translate(position.x,position.y, position.z);
    noStroke();
    fill(0);
    ellipse(0, 0,15,15);
    popMatrix();
  }
  
  void drawPreyLine() {
    pushMatrix();
    stroke(0);
    line(prey.position.x,prey.position.y,prey.position.z,position.x,position.y, position.z);
    popMatrix();
  }
}
