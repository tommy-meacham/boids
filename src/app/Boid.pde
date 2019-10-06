
class Boid {
  float MAX_FORCE;
  float MAX_SPEED;
  float NEIGHBOR_DIST;
  float DESIRED_SEP;
  float SEP_FORCE;
  float ALIGN_FORCE;
  float COH_FORCE;
  
  color COLOR;
  
  PVector position;
  PVector velocity;
  PVector acceleration;
  ArrayList<Boid> neighbors;
  
  
  Boid(float maxforce, float maxspeed, float neighbordist, float desiredsep, float sepforce, float alignforce, float cohforce) {    
    MAX_FORCE = maxforce;
    MAX_SPEED = maxspeed;
    NEIGHBOR_DIST = neighbordist;
    DESIRED_SEP = desiredsep;
    SEP_FORCE = sepforce;
    ALIGN_FORCE = alignforce;
    COH_FORCE = cohforce;
    
    COLOR = color(random(1000));
    float x = random(width);
    float y = random(height);
    float z = 0;
    position = new PVector(x, y, z);
    velocity = PVector.random2D();
    acceleration = new PVector(0, 0, 0);
  }
  
  void render() {
    pushMatrix();
    translate(position.x,position.y, position.z);
    noStroke();
    fill(COLOR);
    ellipse(0, 0,10,10);
    popMatrix();
  }

  void run(ArrayList<Boid> boids) {
    neighbors = findNeighbors(boids);
    flock(boids);
    updatePosition();
    alignColor();
    render();
  }

  void flock(ArrayList<Boid> boids) {
    PVector sep = separate(boids);
    PVector ali = align();
    PVector coh = cohesion();
    PVector wall = avoidWalls();
    
    // Arbitrarily weight these forces
    sep.mult(SEP_FORCE);
    ali.mult(ALIGN_FORCE);
    coh.mult(COH_FORCE);

    applyForce(sep);
    applyForce(ali);
    applyForce(coh);
    applyForce(wall);
  }
  
  void applyForce(PVector force) {
    acceleration.add(force);
  }


  void updatePosition() {
    velocity.add(acceleration);
    velocity.limit(MAX_SPEED);
    position.add(velocity);
    acceleration.mult(0);
  }
 
  
  PVector avoidWalls() {
   PVector steer = new PVector();
     if((position.x < 50) ||
           (position.x > (width-50)) ||
           (position.y < 50) ||
           (position.y > (width-50)) ||
           (position.z < -345) ||
           (position.z > 345)) {
               float x = random(width-100) + 50;
               float y = random(height-100) + 50;
               float z = random(700-100) -345;
               PVector p = new PVector(x,y,z);  
               steer = PVector.sub(p, position);
               steer.limit(MAX_FORCE);
     } 
   return steer; 
  }


  PVector separate(ArrayList<Boid> boids) {
    PVector steer = new PVector(0, 0, 0);
    int count = 0;

    for (Boid other : boids) {
      float d = PVector.dist(position, other.position);
      if ((d > 0) && (d < DESIRED_SEP)) {     
        // Calculate vector pointing away from neighbor
        PVector diff = PVector.sub(position, other.position);
        diff.normalize();
        diff.div(d);        // Weight by distance
        steer.add(diff);
        count++;
      }
    }
    if (count > 0) {
      steer.div((float)count);
      // Implement Reynolds: Steering = Desired - Velocity
      steer.setMag(MAX_SPEED);
      steer.sub(velocity);
      steer.limit(MAX_FORCE);
    }
    return steer;
  }


  PVector align() {
    PVector sum = new PVector(0, 0, 0);
    int count = 0;
    
    for(Boid other : neighbors) {
      sum.add(other.velocity);
      count++;  
    }
    if (count > 0) {
      sum.div((float)count);
      // Implement Reynolds: Steering = Desired - Velocity
      sum.setMag(MAX_SPEED);
      PVector steer = PVector.sub(sum, velocity);
      steer.limit(MAX_FORCE);
      return steer;
    } else {
      return sum;
    }
  }


  PVector cohesion() {
    PVector sum = new PVector(0, 0, 0);
    int count = 0;
    
    for(Boid other : neighbors) {
      sum.add(other.position); 
      count++;
    } 
    if (count > 0) {
      sum.div(count);
      PVector desired = PVector.sub(sum, position);
       desired.setMag(MAX_SPEED);  
      // Implement Reynolds: Steering = Desired - Velocity
      PVector steer = PVector.sub(desired, velocity);
      steer.limit(MAX_FORCE);
      return steer;
    } else {
      return sum;
    }
  }
  
  ArrayList<Boid> findNeighbors(ArrayList<Boid> boids) {
    ArrayList<Boid> neighbors = new ArrayList();
    for(Boid other : boids){
      float d = PVector.dist(position, other.position);
      if ((d > 0) && (d < NEIGHBOR_DIST)) {
        neighbors.add(other);
      }
    }
    return neighbors;
  }
  
  void alignColor() {
    float sum = 0;
    int count = 0;
    for(Boid other : neighbors) {
      sum += other.COLOR;
      count++;
    }
    float avg = sum / count;
    float dist = Math.abs(avg - COLOR) / 5;
    if(COLOR < avg) {
      COLOR += dist;
    } else if(COLOR > avg) {
      COLOR -= dist; 
    }
  }
  
  void avoidPredator(Predator p) {
    PVector steer = PVector.sub(position, p.position);
    if( steer.mag() < 150) { 
    steer.setMag(MAX_FORCE);
    applyForce(steer);
    }
  }
  
  void avoidPredators(ArrayList<Predator> ps) {
    for(Predator p : ps){
      PVector steer = PVector.sub(position, p.position);
      if(steer.mag() < 150) { 
        steer.setMag(MAX_FORCE);
        applyForce(steer);
      }
    }
  }
  
  void setMaxForce(float maxForce) {
    MAX_FORCE = maxForce;
  }
  
  void setMaxSpeed(float maxSpeed) {
    MAX_SPEED = maxSpeed;
  }
  
  void setAlignmentForce(float alignmentForce) {
    ALIGN_FORCE = alignmentForce;
  }
  
  void setSeparationForce(float separationForce) {
    SEP_FORCE = separationForce;
  }
  
  void setCohesionForce(float cohesionForce) {
    SEP_FORCE = cohesionForce;
  }
}
