int num=10000;
int attractorNum=6;

Particle[]ps;
PVector[]attractor;

float spdRange=2000;   
float damp=0.002;

void setup() {
  size(960, 720);  
  
  attractor=new PVector[attractorNum];
  ps=new Particle[num];
  reset();
}

void draw() {
  stroke(0, 4);

  for (int i=0; i<num; i++) {
    ps[i].step();
    point(ps[i].pos.x, ps[i].pos.y);
  }

}

void keyPressed() {
  if (key==' ') {
    reset();
  }
}

void reset() {
  for (int i=0; i<attractor.length; i++) {
    attractor[i]=new PVector(random(width), random(height));
  }

  for (int i=0; i<num; i++) {
    ps[i]=new Particle();
  }

  background(255);
  fill(255, 0, 0);
  noStroke();
  for (int i=0; i<attractor.length; i++) {
    ellipse(attractor[i].x, attractor[i].y, 20, 20);
  }
}

class Particle {
  PVector pos;
  PVector vel;

  Particle() {
    pos=new PVector(random(width), random(height));
    vel=new PVector(random(-spdRange, spdRange), random(-spdRange, spdRange));
  }

  void step() {

    for (int i=0; i<attractor.length; i++) {
      float sqD=PVector.sub(pos, attractor[i]).magSq();

      if (sqD>0.1) {
        PVector acc=PVector.sub(attractor[i], pos).div(sqD).mult(spdRange*2);
        vel.add(acc);
      }
    }

    pos.add(vel);
    vel.mult(damp);
  }
}
