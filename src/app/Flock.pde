
class Flock {
  ArrayList<Boid> boids; // An ArrayList for all the boids
  ArrayList<Predator> predators;
  Predator p;

  Flock() {
    boids = new ArrayList<Boid>(); // Initialize the ArrayList
    predators = new ArrayList<Predator>();
  }

  void run() {
    for (Boid b : boids) {
      b.run(boids);  // Passing the entire list of boids to each boid individually
      b.avoidPredators(predators);
    }
    
    for(Predator p : predators) {
      p.run(boids);
      if(p.preyWasKilled()){
        killBoid(p.getPrey());
        p.resetPrey();
      }
    }
  }

  void addBoid(Boid b) {
    boids.add(b);
  }
  
  void setPredator(Predator p) {
    this.p = p;
  }
  
  void addPredator(Predator p) { 
   predators.add(p); 
  }
  
  void killBoid(Boid b) {
    if(boids.contains(b)) {
      boids.remove(b);
    }
  }
  
  void updateForceConstants(float maxForce, float maxSpeed, float alignmentForce, float separationForce, float cohesionForce) {
    for(Boid b : boids) {
      b.setMaxForce(maxForce);
      b.setMaxSpeed(maxSpeed);
      b.setAlignmentForce(alignmentForce);
      b.setSeparationForce(separationForce);
      b.setCohesionForce(cohesionForce);
    }
  }

  void drawNeighbors(float neighborDist) {
    for(Boid b : boids) {
       for(Boid n : boids) {
         if(PVector.dist(b.position,n.position) < neighborDist){
           pushMatrix();
           stroke(b.COLOR);
           line(b.position.x,b.position.y,b.position.z,n.position.x,n.position.y,n.position.z);
           popMatrix();
         }
       }
    }
  }
}
